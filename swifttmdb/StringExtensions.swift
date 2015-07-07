//
//  StringExtension.swift
//  swifttmdb
//
//  Created by Chris Jimenez on 7/1/15.
//  Copyright (c) 2015 greenpixels. All rights reserved.
//

import UIKit
/**
*  Utils Sor strings
*/
extension String {
    
    var URLEscapedString: String {
        return self.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLHostAllowedCharacterSet())!
    }
    
    
    static func fromUTF8Data(data: NSData) -> String? {
        let nsString = NSString(data: data, encoding: NSUTF8StringEncoding)
        return (nsString != nil) ? String(nsString!) : nil
    }
    
    
    public func toUInt() -> UInt? {
        let i = toInt()
        if let i = i {
            return UInt(i)
        } else {
            return nil
        }
    }
    
    public func toUInt(#defaultValue: UInt) -> UInt {
        let i = toInt()
        if let i = i {
            return UInt(i)
        } else {
            return defaultValue
        }
    }

    
}