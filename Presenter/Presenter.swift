//
//  Presenter.swift
//  iDoctorsMedici
//
//  Created by Valerio Ferrucci on 15/01/15.
//  Copyright (c) 2015 Valerio Ferrucci. All rights reserved.
//

import UIKit

class Presenter {
    
    // only on iOS7 we explicitely use a popover controller
    var popoverController : UIPopoverController?
    
    // system version
    let version:NSString = UIDevice.currentDevice().systemVersion as NSString;
    // device (needed only for iOS7)
    let idiom = UIDevice.currentDevice().userInterfaceIdiom
    
    class var sharedInstance: Presenter {
        
        struct Static {
            static var instance: Presenter?
            static var token: dispatch_once_t = 0
        }
        
        dispatch_once(&Static.token) {
            Static.instance = Presenter()
        }
        
        return Static.instance!
    }
    
    func present(controller : UIViewController, fromView : UIView, inController : UIViewController) {
        
        // iOS8 adaptive presentation
        if version.doubleValue >= 8 {
            
            // set the presentation style to popover
            controller.modalPresentationStyle = UIModalPresentationStyle.Popover
            
            // get the popover presentation controller (to set characteristics of the popover presentation)
            let popoverPresentationController = controller.popoverPresentationController
            
            // result is an optional (but should not be nil if modalPresentationStyle is popover)
            if let _popoverPresentationController = popoverPresentationController {
                
                // set the view from which to pop up
                _popoverPresentationController.sourceView = fromView
                
                // present (id iPhone it is a modal automatic full screen)
                inController.presentViewController(controller, animated: true, completion: nil)
            }
        } else {     // iOS7 dobbiamo gestire noi le differenze
        
            if idiom == UIUserInterfaceIdiom.Pad {
                
                // instantiate the popover controller
                popoverController = UIPopoverController(contentViewController: controller)
                if let _popoverController = popoverController {
                    
                    // present the popover
                    _popoverController.presentPopoverFromRect(fromView.frame, inView:inController.view, permittedArrowDirections: UIPopoverArrowDirection.Any, animated:true)
                }
            } else {
             
                // full screen modal
                inController.presentViewController(controller, animated: true, completion: nil)
            }
            
        }
    }
    
    func dismiss(controller : UIViewController) {
        
        if version.doubleValue >= 8 {
            
            controller.dismissViewControllerAnimated(true, completion: nil);
        } else {
            
            if idiom == UIUserInterfaceIdiom.Pad {
                if let _popoverController = popoverController {
                    _popoverController.dismissPopoverAnimated(true)
                    popoverController = nil // now we are showing nothing
                }
            } else {
                controller.dismissViewControllerAnimated(true, completion: nil);
            }
        }
    }
}
