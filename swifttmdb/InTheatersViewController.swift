//
//  InTheatersViewController.swift
//  swifttmdb
//
//  Created by Christopher Jimenez on 6/30/15.
//  Copyright (c) 2015 greenpixels. All rights reserved.
//

import UIKit

class InTheatersViewController: UIViewController, UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    
    private struct Constants{
        static let numberOfLinesiPhonePortrait = 2
        static let numberOfItemsiPhonePortrait = 2
        static let numberOfLinesiPhoneLandscape = 2
        static let numberOfItemsiPhoneLandscape = 5
        static let desirediPadCellWidth = 160
        static let desirediPadCellHeight = 205
    }
    
    
    @IBOutlet weak var collectionView: UICollectionView!{
        didSet{
            collectionView.alwaysBounceVertical = true
            collectionView.dataSource = self
            collectionView.delegate = self
        }
    }
    
    @IBOutlet weak var collectionViewLayout: UICollectionViewFlowLayout!
    
    
    let moviesViewModel = MoviesInTheatersViewModel()
    let reuseIdentifier = "MoviePosterCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Configure the view models
        moviesViewModel.beginLoadingSignal.deliverOnMainThread().subscribeNext { [unowned self] _ in
            
            self.showProgressIndicator()
            
        }
        
        moviesViewModel.endLoadingSignal.deliverOnMainThread().subscribeNext { [unowned self] _ in
            

           self.hideProgressIndicator()
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
        
        self.setupCollectionView()
        
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
    
    //Hide status bar
    override func prefersStatusBarHidden() -> Bool {
        return true;
    }
    
    func setupCollectionView(){
        
        self.collectionView!.registerNib(UINib(nibName: "MoviePosterCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
        
        self.collectionView?.collectionViewLayout.invalidateLayout()
        
    }
    
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)
        
        collectionViewLayout?.invalidateLayout()
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
            loadMore()
        }
    }
    
    func loadMore(){
        
        self.moviesViewModel.loadMore()
    }
   
    
    // MARK: UICollectionViewDelegate
    
    
    // MARK: UICollectionViewDelegateFlowLayout & UICollectionViewDelegate
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        let visibleAreaHeight = collectionView.bounds.height - UIApplication.sharedApplication().statusBarFrame.height - self.tabBarController!.tabBar.bounds.height
        let visibleAreaWidth = collectionView.bounds.width
        
        //Set cell size based on size class.
        let sizeClass = (horizontal: self.view.traitCollection.horizontalSizeClass, vertical: self.view.traitCollection.verticalSizeClass)
        
        if let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout{
            switch sizeClass{
            case (.Compact,.Regular):
                //iPhone portrait
                let cellWidth = ((visibleAreaWidth - CGFloat(Constants.numberOfItemsiPhonePortrait - 1)*flowLayout.minimumInteritemSpacing - flowLayout.sectionInset.top - flowLayout.sectionInset.bottom)/CGFloat(Constants.numberOfItemsiPhonePortrait))
                let cellHeight = ((visibleAreaHeight - CGFloat(Constants.numberOfLinesiPhonePortrait - 1)*flowLayout.minimumLineSpacing - flowLayout.sectionInset.left - flowLayout.sectionInset.right)/CGFloat(Constants.numberOfLinesiPhonePortrait))
                return CGSizeMake(cellWidth, cellHeight)
            case (_,.Compact):
                //iPhone landscape
                let cellWidth = ((collectionView.bounds.width - CGFloat(Constants.numberOfItemsiPhoneLandscape - 1)*flowLayout.minimumInteritemSpacing - flowLayout.sectionInset.top - flowLayout.sectionInset.bottom)/CGFloat(Constants.numberOfItemsiPhoneLandscape))
                let cellHeight = ((collectionView.bounds.height - CGFloat(Constants.numberOfLinesiPhoneLandscape - 1)*flowLayout.minimumLineSpacing - flowLayout.sectionInset.left - flowLayout.sectionInset.right)/CGFloat(Constants.numberOfLinesiPhoneLandscape))
                return CGSizeMake(cellWidth, cellHeight)
            case (_,_):
                // iPad. Calculate cell size based on desired size
                let numberOfLines = Int(visibleAreaHeight) / Constants.desirediPadCellHeight
                let betweenLinesSpaceSum = CGFloat(numberOfLines - 1) * flowLayout.minimumLineSpacing
                let sectionInsetsVerticalSum = flowLayout.sectionInset.top + flowLayout.sectionInset.bottom
                
                let adjustedHeight = (visibleAreaHeight - betweenLinesSpaceSum  - sectionInsetsVerticalSum)/CGFloat(numberOfLines)
                let adjustedWidth = adjustedHeight * CGFloat(Constants.desirediPadCellWidth) / CGFloat(Constants.desirediPadCellHeight)
                
                return CGSizeMake(adjustedWidth, adjustedHeight)
            default: return CGSizeMake(50, 50)
            }
        }
        
        return CGSizeMake(50, 50)
    }

    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        //        // Select
        //        let cell = collectionView.cellForItemAtIndexPath(indexPath) as GifViewCell
        //
        //        self.selectedImageView = cell.imageView
        //        self.selectedGif = images[Int(indexPath.row)]
        //
        //        self.performSegueWithIdentifier("showDetail", sender: nil)
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

