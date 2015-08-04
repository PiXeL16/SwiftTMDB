//
//  TMDBApi.swift
//  swifttmdb
//
//  Created by Chris Jimenez on 7/1/15.
//  Copyright (c) 2015 greenpixels. All rights reserved.
//
import Foundation
import Moya


// MARK: - Provider setup

let TMDBProvider = MoyaProvider(endpointsClosure: endpointClosure)
//
//let TMDBProvider = MoyaProvider<TMDB>()

// MARK: - Provider support

public enum TMDB{
    
    case MoviesInTheaters(Int)
    case PopularMovies(Int)
    
}
// MARK: - Moya target for TMDB API  - WIP
extension TMDB :MoyaTarget{
    
    /// Base URL
    public var baseURL: NSURL { return NSURL(string: Constants.serverBaseURL)! }
    
    public var path: String {
        switch self {
        case .MoviesInTheaters(_):
            return "/discover/movie"
        case .PopularMovies(_):
            return "/discover/movie"
        }
    }
    
    public var method: Moya.Method {
        return .GET
    }
    
    public var parameters: [String: AnyObject] {
        switch self {
        case .MoviesInTheaters(let page):
        
            let today:NSDate = NSDate()
            /**
            *  Get movies from this month(Guess the movies of this month are the ones on theaters at the momment
            *
            *  @param page Number of page to get
            *
            *  @return
            */
            return ["page":"\(page)",
                    "primary_release_date.gte":  today.dateAtTheStartOfMonth().simpleDateFormatString(),
                    "primary_release_date.lte":  today.dateAtTheEndOfMonth().simpleDateFormatString(),
                    "sort_by":"popularity.desc",
                    "vote_count.gte":"1"]
            
        case .PopularMovies(let page):
            /**
            *  Get movies sorted by popularity that have more than 1000 votes
            *
            *  @param page number of page
            *
            *  @return <#return value description#>
            */
            return ["page":"\(page)",
                    "sort_by":"vote_average.desc",
                    "vote_count.gte":"1000"]
        default:
            return [:]
        }
    }
    
    public var sampleData: NSData {
        switch self {
        //TODO: ADD sample data
        case .MoviesInTheaters(_):
            return "".dataUsingEncoding(NSUTF8StringEncoding)!
        case .PopularMovies(_):
            return "".dataUsingEncoding(NSUTF8StringEncoding)!
        }

    }
}

extension TMDB{
    /**
    Creates the complete Image URL of the IMDB api
    
    :param: imageFile Image File Path
    :param: width     Image Width
    
    :returns: Returns the image full URL path
    */
    public static func createImageURL(image imageFile: String, imageWidth width: Int)->NSURL!{
        
        var baseImageURL = "http://image.tmdb.org/t/p/w\(width)/\(imageFile)"
        
        return NSURL(string: baseImageURL)
        
    }
}

/// Endpoint that pretty much adds an API key to each request, so its not needed to be added manually in the target ENUM
let endpointClosure = { (target: TMDB) -> Endpoint<TMDB> in
    
    let endpoint: Endpoint<TMDB> = Endpoint<TMDB>(URL: url(target), sampleResponse: .Success(200, {target.sampleData}), method: target.method, parameters: target.parameters)
    
   return endpoint.endpointByAddingParameters(["api_key": Constants.apiKey])
    
}


// MARK: - Provider support , to used form sample data. .json files need to be defined in a local folder
private func stubbedResponse(filename: String) -> NSData! {
    @objc class TestClass { }
    
    let bundle = NSBundle(forClass: TestClass.self)
    let path = bundle.pathForResource(filename, ofType: "json")
    return NSData(contentsOfFile: path!)
}

/**
Returns the base URL with the route path of the target

:param: route Route of the target

:returns: Complete url with host / target
*/
public func url(route: MoyaTarget) -> String {
    
    return route.baseURL.URLByAppendingPathComponent(route.path).absoluteString!
}