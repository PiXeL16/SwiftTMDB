//
//  SwiftTMDBTabBarController.swift
//  swifttmdb
//
//  Created by Christopher Jimenez on 7/7/15.
//  Copyright (c) 2015 greenpixels. All rights reserved.
//

import UIKit

class SwiftTMDBTabBarController: UITabBarController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Change tabs tint color, for some reason I am not able to do it from StoryBoard
        self.tabBar.tintColor = UIColor.tintColor();

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
