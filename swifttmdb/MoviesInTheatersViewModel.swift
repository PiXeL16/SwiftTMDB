//
//  MoviesInTheatersViewModel.swift
//  swifttmdb
//
//  Created by Christopher Jimenez on 7/6/15.
//  Copyright (c) 2015 greenpixels. All rights reserved.
//

import ReachabilitySwift
import RxViewModel

import RxSwift
import RxCocoa

/// View model for the MoviesInTheaters View Controller
public class MoviesInTheatersViewModel: BaseMoviesViewModel {
    
    
    /**
    Init ViewModels
    
    :returns: self
    */
    override init(){
        
        super.init()
        
    }
    
    /**
    Gets data from the server and parse it
    */
    override func loadData(){
        
        TMDBProvider.request(.MoviesInTheaters(self.currentPage), completion: { (data, statusCode, response, error) -> () in
            
            sendNext(self.endLoadingSignal, nil)
            
            // Check error, and if so notify back and cancel processing
            // data.
            if let err = error where err.code != 0 {
                
                log.error("Error in the request \(err.description)")
                
                sendError(self.updateContentSignal, err)
                
                return
            }
            
            //Parse json data
            if let data = data {
                var localError: NSError?
                if let json: AnyObject = NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers, error: &localError){
                    
                    if let movies = json["results"] as? Array<Dictionary<String, AnyObject>> {
                        
                        for jsonMovie in movies{
                            
                            let movie = Movie.fromJSON(jsonMovie) as! Movie
                            self.movies.append(movie)
                            
                        }
                        
                        //Report back new data
                        sendNext(self.updateContentSignal, self.movies)
                        
                    }
                    
                } else {

                    log.error("Error parsing data")
                    
                    if let error = localError{
                        
                        log.error("\(error.description)")
                        
                        sendError(self.updateContentSignal, error)
                        
                    }
                    
                }
                
            }
            
        })
    }
    
    /**
    Load more movies from API
    For movies in theaters we are only interested in the first 2 pages
    */
    override func loadMore()
    {
        //Only the first 2 pages matters
        if(currentPage <= 2)
        {
            sendNext(self.beginLoadingSignal, nil)
        
            self.currentPage++
            self.loadData()
            
        }
        
    }
    
    
    
}
