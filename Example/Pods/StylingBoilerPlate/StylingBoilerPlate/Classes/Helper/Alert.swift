//
//  Alert.swift
//  Cap
//
//  Created by Pantera Engineering on 20/12/2016.
//  Copyright © 2016 Incubasys IT Solutions. All rights reserved.
//

import UIKit

public class Alert{

    static public func showMessage(viewController:UIViewController?,title:String? = nil,msg:String? = nil,actions:[UIAlertAction]? = nil,showOnlyDismissBtn:Bool=true, dismissBtnTitle: String) {
        
        guard viewController != nil else {
            return
        }
        let alert = createAlert(viewController:viewController,title:title,msg:msg,actions:actions,showOnlyDismissBtn:showOnlyDismissBtn,dismissBtnTitle:dismissBtnTitle)
        viewController!.present(alert, animated: true, completion: nil)
    }//showError
    
    static func createAlert(viewController:UIViewController?,title:String? = nil,msg:String? = nil,actions:[UIAlertAction]? = nil,showOnlyDismissBtn:Bool=true, dismissBtnTitle: String) -> UIAlertController {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        
        //dismiss button check
        if showOnlyDismissBtn {
            let actionDismiss = UIAlertAction(title: dismissBtnTitle, style: .cancel, handler: nil)
            alert.addAction(actionDismiss)
            return alert
        }
        
        if actions != nil{
            for action in actions!{
                alert.addAction(action)
            }
        }//if
        return alert
    }
    

	static public func showImagePickerAlert(viewController:UIViewController,actionPhotoLibrary:UIAlertAction,actionCamera:UIAlertAction,actionRemove:UIAlertAction? = nil, cancelTitle: String, title: String)  {
        let actionCancel = UIAlertAction(title: cancelTitle, style: .cancel, handler: nil)
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .actionSheet)
        alert.addAction(actionCancel)
        alert.addAction(actionCamera)
        alert.addAction(actionPhotoLibrary)
        if actionRemove != nil{
            alert.addAction(actionRemove!)
        }
        viewController.present(alert, animated: true, completion: nil)
    }

}
