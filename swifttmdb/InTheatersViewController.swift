//
//  InTheatersViewController.swift
//  swifttmdb
//
//  Created by Christopher Jimenez on 6/30/15.
//  Copyright (c) 2015 greenpixels. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa
/// Shows the movies that are in theaters
class InTheatersViewController: BaseMovieCollectionViewController, UICollectionViewDataSource {
    
    let moviesViewModel = MoviesInTheatersViewModel()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        /**
        *  Begin loading signal executed when the network request is started initialy
        *
        *  @param MainScheduler.sharedInstance Main thread
        *
        *  @return
        */
        self.moviesViewModel.beginLoadingSignal >- observeOn(MainScheduler.sharedInstance) >- subscribeNext { [unowned self] _ in
            
            self.showNetworkIndicator()
            
        }
        /**
        *  End loading signal executed when the request has ended
        *
        *  @param MainScheduler.sharedInstance
        *
        *  @return
        */
        self.moviesViewModel.endLoadingSignal >- observeOn(MainScheduler.sharedInstance) >- subscribeNext{ [unowned self] _ in
            
            self.hideNetworkIndicator()
            
        }
        /**
        *  Update content signal executed when there is data to show
        *
        *  @param MainScheduler.sharedInstance
        *
        *  @return
        */
        self.moviesViewModel.updateContentSignal
            >- observeOn(MainScheduler.sharedInstance)
            >- subscribe ( next: { [unowned self] _ in
                    //Reloads the collection view when we have data
                    self.collectionView.reloadData()
                
                }, error: { error in
                    //Shows alert if there was an error
                    let alertController = UIAlertController(title: "Unable to fetch movies", message: error.localizedDescription, preferredStyle: .Alert)
                    
                    let ok = UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
                        alertController.dismissViewControllerAnimated(true, completion: nil)
                    })
                    
                    alertController.addAction(ok)
                    self.presentViewController(alertController, animated: true, completion: nil)

                }, completed: {
                    // do something on completed
            })
        
        
        // Trigger first load
        moviesViewModel.active = true
       
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    //MARK:UICollectionViewDataSource
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return moviesViewModel.numbersOfSections
    }
    
    
    func collectionView(collectionView: UICollectionView,
        numberOfItemsInSection section: Int) -> Int
    {
        return moviesViewModel.numberOfItemsInSection(section)
    }
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! MoviePosterCell
        
        let movie = self.moviesViewModel.movieAtIndexPath(indexPath)
        
        // Configure the cell
        
        cell.showMovie(movie)
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == self.moviesViewModel.movies.count - 1 {
            self.loadMore()
        }
    }
    
    func loadMore(){
        
        self.moviesViewModel.loadMore()
    }
   
    
    // MARK: UICollectionViewDelegate
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        let cell = collectionView.cellForItemAtIndexPath(indexPath)
        
        self.performSegueWithIdentifier("showDetail", sender: cell)
        
    }
    
    /**
    Prepare for segue
    
    :param: segue  description
    :param: sender AnyObject
    */
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "showDetail"{
            if let movieDetailViewController = segue.destinationViewController as? MovieDetailViewController{
                
                if let senderCell = sender as? UICollectionViewCell{
                    if let indexPath = collectionView!.indexPathForCell(senderCell){
                        let movie:Movie = self.moviesViewModel.movieAtIndexPath(indexPath)
                        
                        let movieViewModel = MovieViewModel(movie: movie)
                        
                        movieDetailViewController.movieViewModel = movieViewModel
                    }
                }
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}

