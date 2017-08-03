//
//  ResponseError.swift
//  The Grid
//
//  Created by Pantera Engineering on 19/09/2016.
//  Copyright © 2016 Incubasys. All rights reserved.
//

import Foundation
import UIKit

struct ServerCustomError{
    var type: Int = -1
    var errors = [String]()
    
    init(type:Int = -1, errors:[String]) {
        self.type = type
        self.errors = errors
    }
}

open class ResponseError {
    public var statusCode = -1
    public var reason = ""
    public var errorTitle = "Error"
    public var error:Error?
    
    public init(){}
    
    static public func getCode(errorString:String?)->Int?{
        guard let error = errorString else{
            return nil
        }
        let index = error.index(error.startIndex, offsetBy: 44)
        let index2 = error.index(error.startIndex, offsetBy: 49)
        let range = Range<String.Index>.init(uncheckedBounds: (lower: index, upper: index2))
        let a = error.substring(with: range)
        return Int(a)
    }
    /*
    static public  func parseErrorData(data:Data?)->String?{
        guard data != nil else {
            return nil
        }
        do{
            let json = try JSONSerialization.jsonObject(with: data! , options: []) as! [String:Any]
                        print(json.description)
            if let error = json["error"] as? String{
                return error
            }else if let errors = json["errors"] as? [String]{
                return errors[0]
            }else if let errors = json["errors"] as? [String:Any] {
                                print(errors.description)
                if let msg = errors["full_messages"] as? [String]{
                                        print(msg[0])
                    return msg[0]
                }
                return nil
            }
        }catch{
            print("json parsing error")
        }
        return nil
    }*/

    class func parseErrorData(data:Data?)->ServerCustomError?{
        
        var customError = ServerCustomError(type: -1, errors: [])
        
        guard data != nil else {
            return nil
        }
        do{
            let json = try JSONSerialization.jsonObject(with: data! , options: []) as! [String:Any]
            print(json.description)
            if let type = json["type"] as? Int{
                customError.type = type
            }
            if let error = json["error"] as? String{
                customError.errors.append(error)
            }else if let errors = json["errors"] as? [String]{
                customError.errors = errors
            }else if let errors = json["errors"] as? [String:Any] {
                if let msg = errors["full_messages"] as? [String]{
                    customError.errors = msg
                }
                return nil
            }
        }catch{
            print("json parsing error")
            return nil
        }
        return customError
    }
    
    public convenience init(error:Error){
        self.init()
        let nsError = ((error as Any) as! NSError)
        
        if let statusCode = nsError.userInfo["StatusCode"]{
            self.statusCode = statusCode as! Int
        }else{
            self.statusCode = nsError.code
        }
        if let failureReason = nsError.userInfo["NSLocalizedDescription"]{
            self.reason = failureReason as! String
        }
        
        //handle error
        handleError()
    }//init
    
    public convenience init(statusCode:Int,error:Error?){
        self.init()
        self.statusCode = statusCode
        self.error = error
        handleError()
    }
    
    public func handleError(){
        //Handling errors
        switch self.statusCode{
        case -1009:
            errorTitle = "Internet not connected"
            reason = "The Internet connection appears to be offline."
        case -1004:
            errorTitle = "Internet is not available"
            reason = ""
        case -1001:
            errorTitle = "Slow internet connection"
            reason = "The request timed out."
        case 500:
            errorTitle = "Server Error"
        case 401:
            errorTitle = "Please Login"
        case 403:
            errorTitle = "UnAuthorized"
        case 404:
            errorTitle = "Error 404"
            reason = "Not found"
        case 500:
            errorTitle = "Internal Server Error"
        case 422:
            errorTitle = "Unprocessable Entity"
            reason = "unable to process the contained instructions"
        default:
            errorTitle = "Error!"
            print("error is in data")
        }
    }
    
    func showAlert(viewController:UIViewController?,actionRetry:UIAlertAction?,actionCancel:UIAlertAction? = nil,showDefaultCancel:Bool = true) {
        guard viewController != nil else {
            return
        }
        let alert = UIAlertController(title: errorTitle, message: reason, preferredStyle: .alert)
        
        //dismiss button check
        if actionCancel == nil && showDefaultCancel{
            let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alert.addAction(cancel)
//            viewController.present(alert, animated: true, completion: nil)
//            return
        }else if actionCancel != nil{
            alert.addAction(actionCancel!)
        }
        
        if actionRetry != nil{
            alert.addAction(actionRetry!)
        }//if
        viewController!.present(alert, animated: true, completion: nil)
    }//showError
    
    //handle error
    /*
    func showAlert(viewControllerToShowAlert:UIViewController?,actions:[UIAlertAction]?,enableDefaultCancelButton:Bool = false,defaultCancelButtonTitle:String = "Cancel")->UIAlertController?{

        //create alert
        let errorAlert = UIAlertController(title: errorTitle, message: self.reason, preferredStyle: .Alert)
        //add default cancel button if required
        if enableDefaultCancelButton{
            let cancelAction = UIAlertAction(title: defaultCancelButtonTitle, style: .Cancel, handler: nil)
            errorAlert.addAction(cancelAction)
        }
        //add actions
        if actions != nil{
            for action in actions!{
                errorAlert.addAction(action)
            }
        }
        //show alert
        viewControllerToShowAlert!.presentViewController(errorAlert, animated: true, completion: nil)
        
        return errorAlert
    }
     */
    
}
