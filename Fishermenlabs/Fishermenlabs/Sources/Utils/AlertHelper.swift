//
//  AlertHelper.swift
//  Fishermenlabs
//
//  Created by Lusine Hovhannisyan on 9/18/17.
//  Copyright © 2017 Lusine Hovhannisyan. All rights reserved.
//

import UIKit

class AlertHelper {

    static func showOfflineAlert() {
        
        showErrorAlert("Please check your internet connection and try again")
        
    }
    
    static func showUnexpectedErrorAlert() {
        
        showErrorAlert("Oops, something went wrong :(")
        
    }
    
    static fileprivate func showErrorAlert(_ message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        
        let vc = AlertHelper.getTopViewController()
        vc?.present(alert, animated: true, completion: nil)
    }
    
    static func getTopViewController() -> UIViewController? {
        
        var topController = UIApplication.shared.keyWindow?.rootViewController
        if (topController != nil) {
            while let presentedViewController = topController!.presentedViewController {
                topController = presentedViewController
            }
            return topController!
        }
        return nil
    }
}
