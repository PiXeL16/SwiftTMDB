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
    /// Extends the string in case that it needs to have a properly excaped URL
    var URLEscapedString: String {
        return self.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLHostAllowedCharacterSet())!
    }
    
    /**
    Converts Data to UT8 String
    
    :param: data Your Data
    
    :returns: UTF8 String
    */
    static func fromUTF8Data(data: NSData) -> String? {
        let nsString = NSString(data: data, encoding: NSUTF8StringEncoding)
        return (nsString != nil) ? String(nsString!) : nil
    }
    
    /**
    Convert string to int
    
    :returns: Int representation of the string
    */
    public func toUInt() -> UInt? {
        let i = toInt()
        if let i = i {
            return UInt(i)
        } else {
            return nil
        }
    }
    /**
    Convert string to Unsigned Int
    
    :param: defaultValue default value if convertion fails
    
    :returns: uint of the string
    */
    public func toUInt(#defaultValue: UInt) -> UInt {
        let i = toInt()
        if let i = i {
            return UInt(i)
        } else {
            return defaultValue
        }
    }

    
}