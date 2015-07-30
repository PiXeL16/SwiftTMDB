//
//  MoviesNavigationController.swift
//  swifttmdb
//
//  Created by Christopher Jimenez on 7/27/15.
//  Copyright (c) 2015 greenpixels. All rights reserved.
//

import UIKit


/// Custom Navigation controller that sets tint color and title color
class MoviesNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationBar.barStyle = UIBarStyle.BlackTranslucent
        self.navigationBar.tintColor = UIColor.tintColor()
        
        self.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.tintColor()]
        
        // Do any additional setup after loading the view.
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
