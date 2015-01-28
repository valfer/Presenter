//
//  PresentedVC.swift
//  Presenter
//
//  Created by Valerio Ferrucci on 28/01/15.
//  Copyright (c) 2015 Valerio Ferrucci. All rights reserved.
//

import UIKit

class PresentedVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // The space we need when presented inside a popover
        self.preferredContentSize = CGSizeMake(300, 280)
    }
    
    @IBAction func dismiss(sender: AnyObject) {
        
        Presenter.sharedInstance.dismiss(self);
    }
}
