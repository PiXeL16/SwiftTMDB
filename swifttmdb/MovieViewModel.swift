//
//  MovieViewModel.swift
//  swifttmdb
//
//  Created by Christopher Jimenez on 7/27/15.
//  Copyright (c) 2015 greenpixels. All rights reserved.
//

import UIKit
import RxViewModel
import RxSwift
import RxCocoa

public class MovieViewModel: RxViewModel {
    
    public var movie:Movie?
    
    /**
    Init ViewModel
    
    :returns: self
    */
    public init(movie:Movie){
        
        self.movie = movie;
        
        super.init()
        
        self.didBecomeActive >- subscribeNext { [weak self] _ in
            
            if let strongSelf = self{
                
            }
        }
    }
   
}
