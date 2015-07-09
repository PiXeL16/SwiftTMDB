//
//  MoviePosterCollectionViewCell.swift
//  swifttmdb
//
//  Created by Christopher Jimenez on 7/1/15.
//  Copyright (c) 2015 greenpixels. All rights reserved.
//


import UIKit
import SDWebImage

class MoviePosterCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    var imageURL: NSURL? {
        
        didSet{
            
            self.imageView.sd_setImageWithURL(imageURL,completed:{(image: UIImage!, error: NSError!, cacheType: SDImageCacheType, imageURL: NSURL!) -> Void in
                 self.titleLabel.hidden = self.imageView.image != nil
            })
        }
        
    }
    
    var title : String? {
        didSet{
            
            self.titleLabel.hidden = false
            self.titleLabel.text = title
            
        }
    }
    
    
    func showMovie(movie: Movie)
    {
        
        self.title = movie.title
        self.imageURL = movie.posterImagePath
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.imageView.image = nil
    }
}
