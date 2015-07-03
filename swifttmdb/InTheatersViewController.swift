//
//  InTheatersViewController.swift
//  swifttmdb
//
//  Created by Christopher Jimenez on 6/30/15.
//  Copyright (c) 2015 greenpixels. All rights reserved.
//

import UIKit

class InTheatersViewController: UIViewController {
    
    let reuseIdentifier = "MoviePosterCell"
    var movies = [Movie]()
    
    @IBOutlet weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        return 1
    }
    
    
    func collectionView(collectionView: UICollectionView,
        numberOfItemsInSection section: Int) -> Int
    {
        return self.movies.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! MoviePosterCollectionViewCell
        
        let movie = self.movies[indexPath.row]
        
        cell.showPoster(posterPathURL: movie.posterImagePath)
        
        // Configure the cell
        
        return cell
    }
    
//    func collectionView(collectionView: UICollectionView,
//        cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
//    {
//        let gifViewCell = collectionView.dequeueReusableCellWithReuseIdentifier(gifViewCellIdentifier, forIndexPath: indexPath) as GifViewCell
//        let gifObject = images[Int(indexPath.row)]
//        gifViewCell.maskForGif(gifObject);
//        
//        if indexPath.row == self.fetchedImages - 5 {
//            self.fetchedImages = self.images.count + 25
//            // Fetch new images
//            GiphyAPIClient.sharedInstance.gifsForQuery(queryString,offset: self.images.count, callback: { (imageArray, error) -> () in
//                // Update collection view with new data
//                self.collectionView.performBatchUpdates({ () -> Void in
//                    let dataCount = self.images.count
//                    self.images += imageArray
//                    
//                    var indexPaths = [NSIndexPath]()
//                    for var i=dataCount; i<dataCount+imageArray.count; i++ {
//                        indexPaths.append(NSIndexPath(forRow: i, inSection: 0))
//                    }
//                    
//                    self.collectionView.insertItemsAtIndexPaths(indexPaths)
//                    
//                    }, completion: nil)
//            })
//        }
//        return gifViewCell;
//    }

    
}
