//
//  BaseMovieCollectionViewController.swift
//  swifttmdb
//
//  Created by Christopher Jimenez on 7/10/15.
//  Copyright (c) 2015 greenpixels. All rights reserved.
//

import UIKit

class BaseMovieCollectionViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    private struct Constants{
        static let numberOfLinesiPhonePortrait = 2
        static let numberOfItemsiPhonePortrait = 2
        static let numberOfLinesiPhoneLandscape = 2
        static let numberOfItemsiPhoneLandscape = 5
        static let desirediPadCellWidth = 155
        static let desirediPadCellHeight = 205
    }
    
    
    @IBOutlet weak var collectionView: UICollectionView!{
        didSet{
            collectionView.alwaysBounceVertical = true
        }
    }
    
    @IBOutlet weak var collectionViewLayout: UICollectionViewFlowLayout!
    
    
    let reuseIdentifier = "MoviePosterCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.setupCollectionView()
        
    }
    
    func setupCollectionView(){
        
        self.collectionView!.registerNib(UINib(nibName: "MoviePosterCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
        
        self.collectionView?.collectionViewLayout.invalidateLayout()
        
    }
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)
        
        collectionViewLayout?.invalidateLayout()
    }
    
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
    
}



/*
// MARK: - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
// Get the new view controller using segue.destinationViewController.
// Pass the selected object to the new view controller.
}
*/
