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
class MoviesInTheatersViewModel: RxViewModel {
    
    var movies = [Movie]()
    
    let beginLoadingSignal = PublishSubject<AnyObject?>()
    
            let endLoadingSignal = PublishSubject<AnyObject?>()
    
    let updateContentSignal =  PublishSubject<[Movie]?>()
    
    let reachability = Reachability.reachabilityForInternetConnection()
    
    var currentPage = 1
    
    var numbersOfSections:Int{
        get { return 1 }
    }
    
    
    func numberOfItemsInSection(section: Int) -> Int {
        
        return self.movies.count
    }
    
    
    func movieAtIndexPath(indexPath: NSIndexPath)-> Movie{
        
        let movie = movies[indexPath.row]
        
        return movie
    }
    
    /**
    Init ViewModel
    
    :returns: self
    */
    override init(){
        
        super.init()
        
        reachability.startNotifier()
        
        
        
        self.didBecomeActive >- subscribeNext { [weak self] _ in
            
            if let strongSelf = self{
                
                strongSelf.active = false
                
                strongSelf.loadData()
                
                sendNext(strongSelf.beginLoadingSignal, nil)
                
            }
            
        }
        // Check if we have connectivity
        //if self.reachability.isReachable(){
        
        //            }
        //            else
        //            {
        //                if let updateSignal = self.updateContentSignal as? RACSubject {
        //
        //                    updateSignal.sendError(NSError(domain: "No internet connection", code: 500, userInfo: nil))
        //                }
        //                //TODO: Present reachbility error
        //            }
        //}
    }
    
    /**
    Gets data from the server and parse it
    */
    func loadData(){
        
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
    
    
    func loadMore()
    {
        
        sendNext(self.beginLoadingSignal, nil)
        
        self.currentPage++
        self.loadData()
        
    }
    
    
    
}
