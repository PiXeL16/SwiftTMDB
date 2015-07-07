//
//  UIViewControllerProgressExtensions.swift
//  swifttmdb
//
//  Created by Christopher Jimenez on 7/7/15.
//  Copyright (c) 2015 greenpixels. All rights reserved.
//

import UIKit
import MBProgressHUD

extension UIViewController {
    
    
    //Show a progress indicator in the view
    func showProgressIndicator() {
        let loading = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        loading.mode = MBProgressHUDMode.Indeterminate
       
    }
    
    
    //Hide the progress indicator in the view
    func hideProgressIndicator() {
        
        MBProgressHUD.hideAllHUDsForView(self.view, animated: true)
    }
   
}
