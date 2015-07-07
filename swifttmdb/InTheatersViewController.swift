//
//  InTheatersViewController.swift
//  swifttmdb
//
//  Created by Christopher Jimenez on 6/30/15.
//  Copyright (c) 2015 greenpixels. All rights reserved.
//

import UIKit

class InTheatersViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    let moviesViewModel = MoviesInTheatersViewModel()
    let reuseIdentifier = "MoviePosterCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Configure the view models
        moviesViewModel.beginLoadingSignal.deliverOnMainThread().subscribeNext { [unowned self] _ in
            self.activityIndicator.startAnimating()
        }
        
        moviesViewModel.endLoadingSignal.deliverOnMainThread().subscribeNext { [unowned self] _ in
            self.activityIndicator.stopAnimating()
        }
        
        moviesViewModel.updateContentSignal.deliverOnMainThread().subscribeNext({ [unowned self] members in
            self.collectionView.reloadData()
            }, error: { [unowned self] error in
                let alertController = UIAlertController(title: "Unable to fetch movies", message: error?.description, preferredStyle: .Alert)
                
                let ok = UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
                    alertController.dismissViewControllerAnimated(true, completion: nil)
                })
                
                alertController.addAction(ok)
                self.presentViewController(alertController, animated: true, completion: nil)
                
                log.error("Unable to load movies in theaters")
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
        self.collectionView.collectionViewLayout.invalidateLayout()
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

// MARK: UICollectionViewDataSource
extension InTheatersViewController:UICollectionViewDataSource{
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return moviesViewModel.numbersOfSections
    }
    
    
    func collectionView(collectionView: UICollectionView,
        numberOfItemsInSection section: Int) -> Int
    {
        return moviesViewModel.numberOfItemsInSection(section)
    }
    
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! MoviePosterCollectionViewCell
        
        let movie = self.moviesViewModel.movieAtIndexPath(indexPath)
        
        cell.showPoster(posterPathURL: movie.posterImagePath)
        
        // Configure the cell
        
        return cell
    }
    
}


// MARK: - UICollectionViewDelegate
extension InTheatersViewController : UICollectionViewDelegate {
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
//        // Select
//        let cell = collectionView.cellForItemAtIndexPath(indexPath) as GifViewCell
//        
//        self.selectedImageView = cell.imageView
//        self.selectedGif = images[Int(indexPath.row)]
//        
//        self.performSegueWithIdentifier("showDetail", sender: nil)
    }
}
