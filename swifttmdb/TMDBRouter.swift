//
//  TMDBRouter.swift
//  swifttmdb
//
//  Created by Christopher Jimenez on 7/1/15.
//  Copyright (c) 2015 greenpixels. All rights reserved.
//

import UIKit
import Alamofire

struct TMDBRouter {
    
    enum Router:URLRequestConvertible{
        
        static let baseURL = Contants.serverBaseURL
        
        static let apiKey = Contants.apiKey
        
        case MoviesInTheaters(Int)
        case PopularMovies(Int)
        
        var URLRequest: NSURLRequest {
            let (path: String, parameters: [String: AnyObject]) = {
                switch self{
                    
                case .MoviesInTheaters (let page):
                    
                    let path = "/discover/movie"
                    let params = ["api_key": Router.apiKey,"page":"\(page)"]
                    
                    return (path, params)
                case .PopularMovies(let page):
                    
                    let path = "/discover/movie"
                    let params = ["api_key": Router.apiKey,"page":"\(page)"]
                    
                    return (path, params)
                    
                }
                
            }()
            
            let URL = NSURL(string: Router.baseURL)
            let request = NSURLRequest(URL: URL!.URLByAppendingPathComponent(path))
            let encoding = Alamofire.ParameterEncoding.URL
            
            return encoding.encode(request, parameters: parameters).0
            
        }
    }
    
}


