//
//  MovieDetailViewController.swift
//  swifttmdb
//
//  Created by Christopher Jimenez on 7/27/15.
//  Copyright (c) 2015 greenpixels. All rights reserved.
//

import UIKit
import SDWebImage

/// Movie detail class
class MovieDetailViewController: UIViewController {
    
    var movieViewModel:MovieViewModel? = nil
    
    @IBOutlet weak var movieBannerImageView: UIImageView!
    
    @IBOutlet weak var moviePosterImageView: UIImageView!
    
    @IBOutlet weak var movieDescriptionLabel: UILabel!

    @IBOutlet weak var starImageView: UIImageView!
    
    @IBOutlet weak var ratingLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /// If we have a view model initialize view with values
        if let viewModel = self.movieViewModel{
            
            if let movie = viewModel.movie{
                
                self.title = movie.title
                
                self.movieBannerImageView.sd_setImageWithURL(movie.backdropImagePath)
                
                self.moviePosterImageView.sd_setImageWithURL(movie.posterImagePath)
                
                self.movieDescriptionLabel.text = movie.overview
                
                self.starImageView.image = self.starImageView.image!.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
                
                self.ratingLabel.text  = String(format:"%.1f", movie.rating!)
                
            }
            //TODO: Add negative case in case movie is not present
        }

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
