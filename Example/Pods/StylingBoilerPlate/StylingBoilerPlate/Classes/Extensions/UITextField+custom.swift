
//
//  UITextField+custom.swift
//  71stStreet
//
//  Created by Pantera Engineering on 22/11/2016.
//  Copyright © 2016 Incubasys IT Solutions. All rights reserved.
//

import Foundation
import UIKit

public protocol Shakeable {}

public extension Shakeable where Self: UIView{
    public func shake() {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        animation.duration = 1
        animation.values = [-20.0, 20.0, -20.0, 20.0, -10.0, 10.0, -5.0, 5.0, 0.0 ]
        self.layer.add(animation, forKey: "shake")
    }
}
public enum RegularExpressions: String{
     case email = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
     case password = ""
}

extension UITextField:Shakeable{
    
    
    public func isValid(exp:RegularExpressions) -> Bool{
        if let emailTest = NSPredicate(format:"SELF MATCHES %@", exp.rawValue) as NSPredicate? {
            return emailTest.evaluate(with: self.text)
        }
        return false
    }
    
//    public func shake() {
//        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
//        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
//        animation.duration = 1
//        animation.values = [-20.0, 20.0, -20.0, 20.0, -10.0, 10.0, -5.0, 5.0, 0.0 ]
//        self.layer.add(animation, forKey: "shake")
//    }
}
