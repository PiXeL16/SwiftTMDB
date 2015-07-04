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
        
        loadMoviesInTheaters();

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func loadMoviesInTheaters(){
        
        TMDBProvider.request(.MoviesInTheaters(1), completion: { (data, statusCode, response, error) -> () in
            
            var success = error == nil
            if let data = data {
                let json: AnyObject? = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil)
                if let json = json as? NSDictionary {
                    
                    self.movies = Movie.fromData(json) as! [Movie]
                    
                    self.collectionView.reloadData()
                    
                    
                    
                } else {
                    success = false
                }
                
            }
            else
            {
                success = false
            }
            
            
            if !success{
                
            }
            
        })
        
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
