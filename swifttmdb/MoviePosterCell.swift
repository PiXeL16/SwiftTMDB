//
//  MoviePosterCollectionViewCell.swift
//  swifttmdb
//
//  Created by Christopher Jimenez on 7/1/15.
//  Copyright (c) 2015 greenpixels. All rights reserved.
//

import UIKit
import SDWebImage
/// Movie Cell of the collection View
class MoviePosterCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    /// imgURL
    var imageURL: NSURL? {
        /**
        *  If the movie poster URL is set the it will hide the label property with the movie title
        */
        didSet{
            
            self.imageView.sd_setImageWithURL(imageURL,completed:{(image: UIImage!, error: NSError!, cacheType: SDImageCacheType, imageURL: NSURL!) -> Void in
                 self.titleLabel.hidden = self.imageView.image != nil
            })
        }
        
    }
    /// Set the title and show the label if needed
    var title : String? {
        didSet{
            self.titleLabel.hidden = false
            self.titleLabel.text = title
        }
    }
    
    /**
    Set movie cell values
    
    :param: movie the movie object
    */
    func showMovie(movie: Movie)
    {
        
        self.title = movie.title
        self.imageURL = movie.posterImagePath
        
    }
    /**
    Avoid leaks by setting the image property of the imageview to nil when preparing to reause the cell
    */
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.imageView.image = nil
    }
}
