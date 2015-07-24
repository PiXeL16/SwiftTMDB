//
//  Movie.swift
//  swifttmdb
//
//  Created by Christopher Jimenez on 7/1/15.
//  Copyright (c) 2015 greenpixels. All rights reserved.
//

import UIKit
import SwiftyJSON

/// Movie Model 
class Movie:JSONAble {
    
    var id: Int = 0
    var title: String
    var overview: String
    var releaseDate: String?
    var backdropImagePath: NSURL?
    var posterImagePath: NSURL?
    
    /**
    Inits Model with values
    
    :param: id                movie ID
    :param: title             movie Title
    :param: overview          movie overview
    :param: releaseDate       movie release date
    :param: backdropImagePath movie backdrop image path
    :param: posterImagePath   movie poster image path
    
    :returns: <#return value description#>
    */
    init(id: Int, title: String, overview: String, releaseDate: String?, backdropImagePath: NSURL?, posterImagePath: NSURL?){
        
        self.id = id
        self.title = title
        self.overview = overview
        self.releaseDate = releaseDate
        self.backdropImagePath = backdropImagePath
        self.posterImagePath = posterImagePath
    }
    
    /// Parse movie from Json Representation
    override class func fromJSON(source:[String:AnyObject]) -> JSONAble{


        let json              = JSON(source)

        let id                = json["id"].intValue
        let title             = json["title"].stringValue
        let overview          = json["overview"].stringValue
        let releaseDate       = json["release_date"].stringValue

        let backdropImagePath = TMDB.createImageURL(image: json["backdrop_path"].stringValue, imageWidth: 342)
        let posterImagePath   = TMDB.createImageURL(image: json["poster_path"].stringValue, imageWidth: 342)

        return Movie(id: id, title: title, overview: overview, releaseDate: releaseDate, backdropImagePath: backdropImagePath, posterImagePath: posterImagePath)

    }
    
    
}
