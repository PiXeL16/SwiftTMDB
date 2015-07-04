//
//  Movie.swift
//  swifttmdb
//
//  Created by Christopher Jimenez on 7/1/15.
//  Copyright (c) 2015 greenpixels. All rights reserved.
//

import UIKit
import SwiftyJSON

class Movie:JSONAble {
    
    var id: Int = 0
    var title: String
    var overview: String
    var releaseDate: String?
    var backdropImagePath: NSURL?
    var posterImagePath: NSURL?
    
    
    init(id: Int, title: String, overview: String, releaseDate: String?, backdropImagePath: NSURL?, posterImagePath: NSURL?){
        
        self.id = id
        self.title = title
        self.overview = overview
        self.releaseDate = releaseDate
        self.backdropImagePath = backdropImagePath
        self.posterImagePath = posterImagePath
    }
    
    override class func fromJSON(source:[String:AnyObject]) -> JSONAble{
        
        
        
        let json = JSON(source)
        
        let id = json["id"].intValue
        let title = json["title"].stringValue
        let overview = json["overview"].stringValue
        let releaseDate = json["release_date"].stringValue
        let backdropImagePath =  TMDB.createImageURL(image: json["backdrop_path"].stringValue, imageWidth: 342)
        let posterImagePath =  TMDB.createImageURL(image: json["poster_path"].stringValue, imageWidth: 342)

        return Movie(id: id, title: title, overview: overview, releaseDate: releaseDate, backdropImagePath: backdropImagePath, posterImagePath: posterImagePath)
        
    }
    
    class func fromData(data:AnyObject?)->[JSONAble]
    {
        var movies = [JSONAble]()
        
        if let data = data as? NSDictionary {
            let json = JSON(data)
            if let jsonMovies = json["results"].array {
                
                for jsonMovie in jsonMovies {
                    
                   let movie =  self.fromJSON(jsonMovie.object as! [String: AnyObject])
                    
                    movies.append(movie)
                    
                }
                
            }else{
                log.debug("Error in json results:\(json)")
            }
        }
        return movies
        
        
    }
   
}
