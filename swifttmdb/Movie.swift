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
    var backdropImagePath: String
    var posterImagePath: String
    
    
    init(id: Int, title: String, overview: String, releaseDate: String?, backdropImagePath: String, posterImagePath: String){
        
        self.id = id
        self.title = title
        self.overview = overview
        self.releaseDate = releaseDate
        self.backdropImagePath = backdropImagePath
        self.posterImagePath = posterImagePath
    }
    
    override class func fromJSON(source:[String:AnyObject]) -> JSONAble{
        
        
        let json = JSON(source)
        
        //TODO add json parsing
        
//        let id = json["id"].stringValue
//        let maxBidAmount = json["max_bid_amount_cents"].intValue
//        
//        var bid: Bid?
//        if let bidDictionary = json["highest_bid"].object as? [String: AnyObject] {
//            bid = Bid.fromJSON(bidDictionary) as? Bid
//        }
//        
//        return BidderPosition(id: id, highestBid: bid, maxBidAmountCents: maxBidAmount)
        
        return JSONAble()
        
        
    }
    
    
   
}
