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

let TMDBProvider = MoyaProvider<TMDB>()


// MARK: - Provider support

public enum TMDB{
    
    case MoviesInTheaters(Int)
    case PopularMovies(Int)
    
}

extension TMDB :MoyaTarget{
    
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
            return ["api_key": Constants.apiKey,"page":"\(page)"]
        case .PopularMovies(let page):
            return ["api_key": Constants.apiKey,"page":"\(page)"]
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



// MARK: - Provider support , to used form sample data. .json files need to be defined in a local folder
private func stubbedResponse(filename: String) -> NSData! {
    @objc class TestClass { }
    
    let bundle = NSBundle(forClass: TestClass.self)
    let path = bundle.pathForResource(filename, ofType: "json")
    return NSData(contentsOfFile: path!)
}


public func url(route: MoyaTarget) -> String {
    return route.baseURL.URLByAppendingPathComponent(route.path).absoluteString!
}