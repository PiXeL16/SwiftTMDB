//
//  MovieDetailViewController.swift
//  swifttmdb
//
//  Created by Christopher Jimenez on 7/27/15.
//  Copyright (c) 2015 greenpixels. All rights reserved.
//

import UIKit
import SDWebImage


class MovieDetailViewController: UIViewController {
    
    var movieViewModel:MovieViewModel? = nil
    
    @IBOutlet weak var movieBannerImageView: UIImageView!
    
    @IBOutlet weak var moviePosterImageView: UIImageView!
    
    @IBOutlet weak var movieDescriptionLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let viewModel = self.movieViewModel{
            
            if let movie = viewModel.movie{
                
                self.title = movie.title
                
                self.movieBannerImageView.sd_setImageWithURL(movie.backdropImagePath)
                
                self.moviePosterImageView.sd_setImageWithURL(movie.posterImagePath)
                
                self.movieDescriptionLabel.text = movie.overview
                
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
