//
//  BaseViewModel.swift
//  swifttmdb
//
//  Created by Christopher Jimenez on 7/24/15.
//  Copyright (c) 2015 greenpixels. All rights reserved.
//

import UIKit
import RxViewModel

import RxSwift
import RxCocoa

class BaseViewModel: RxViewModel {
    
    /// Array of movies
    var movies = [Movie]()
    
    /// Signal to be sent when network activity starts
    let beginLoadingSignal = PublishSubject<AnyObject?>()
    /// Signal to be sent when network activity ends
    let endLoadingSignal = PublishSubject<AnyObject?>()
    /// Signal to be sent when there is data to show
    let updateContentSignal =  PublishSubject<[Movie]?>()
    /// Reachability
//    let reachability = Reachability.reachabilityForInternetConnection()
    
    /// Current page to start the request
    var currentPage = 1
    
    /// Number of sections in the collection view
    var numbersOfSections:Int{
        get { return 1 }
    }
    
    /**
    Number of items in the collection
    
    :param: section section
    
    :returns: movies count
    */
    func numberOfItemsInSection(section: Int) -> Int {
        
        return self.movies.count
    }
    
    /**
    Get movie at an index path
    
    :param: indexPath
    
    :returns:
    */
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
        
//        reachability.startNotifier()
        
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
         preconditionFailure("This method must be overridden")
    }
    
    /**
    Load more movies from API
    For movies in theaters we are only interested in the first 2 pages
    */
    func loadMore()
    {
         preconditionFailure("This method must be overridden")
    }
    
}
