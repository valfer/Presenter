//
//  ViewController.swift
//  Presenter
//
//  Created by Valerio Ferrucci on 28/01/15.
//  Copyright (c) 2015 Valerio Ferrucci. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBAction func showNewVC(sender: UIButton) {

        // get the controller from the storyboard
        let controller: UIViewController? = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("presentedVC") as? UIViewController
        
        // if found, present it
        if let _controller = controller {
            Presenter.sharedInstance.present(_controller, fromView: sender, inController: self)
        }
    }

}

