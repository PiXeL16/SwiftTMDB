//
//  MoviesInTheatersViewModel.swift
//  swifttmdb
//
//  Created by Christopher Jimenez on 7/6/15.
//  Copyright (c) 2015 greenpixels. All rights reserved.
//

import ReactiveViewModel
import ReactiveCocoa
import ReachabilitySwift

class MoviesInTheatersViewModel: RVMViewModel {
    
    var movies = [Movie]()
    let beginLoadingSignal :RACSignal = RACSubject()
    let endLoadingSignal :RACSignal = RACSubject()
    let updateContentSignal: RACSignal = RACSubject()
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
    
    
    override init(){
        
        super.init()
        
        reachability.startNotifier()
        
        self.didBecomeActiveSignal.subscribeNext { [unowned self] active in
            self.active = false
            // Notify caller that network request is about to begin
            if let beginSignal = self.beginLoadingSignal as? RACSubject { beginSignal.sendNext(nil) }
            
            // Check if we have connectivity
            if self.reachability.isReachable(){
                self.loadData()
            }
            else
            {
                if let updateSignal = self.updateContentSignal as? RACSubject {
                    
                    updateSignal.sendError(NSError(domain: "No internet connection", code: 500, userInfo: nil))
                }
                //TODO: Present reachbility error
            }
        }
        
    }
    
    
    func loadData(){
        
        TMDBProvider.request(.MoviesInTheaters(currentPage), completion: { (data, statusCode, response, error) -> () in
            
            // Notify caller that network request ended
            if let endSignal = self.endLoadingSignal as? RACSubject { endSignal.sendNext(nil) }
            
            
            // Check error, and if so notify back and cancel processing
            // data.
            if let err = error where err.code != 0 {
                if let updateSignal = self.updateContentSignal as? RACSubject {
                    
                    updateSignal.sendError(err)
                }
                
                return
            }
            //Parse
            
            if let data = data {
                var localError: NSError?
                if let json: AnyObject = NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers, error: &localError){
                    if let movies = json["results"] as? Array<Dictionary<String, AnyObject>> {
                        
                        for jsonMovie in movies{
                            
                            let movie = Movie.fromJSON(jsonMovie) as! Movie
                            self.movies.append(movie)
                            
                        }
                        
                        // Report back the new data.
                        if let updateSignal = self.updateContentSignal as? RACSubject {
                            updateSignal.sendNext(self.movies)
                        }
                    }
                    
                } else {
                    //If error getting result notify error
                    if let updateSignal = self.updateContentSignal as? RACSubject {
                        updateSignal.sendError(localError)
                    }
                }
                
            }
            
        })
    }
    
    
    func loadMore()
    {
        
        if let beginSignal = self.beginLoadingSignal as? RACSubject
        { beginSignal.sendNext(nil) }
        
        self.currentPage++
        self.loadData()
        
    }
    
    
    
}
