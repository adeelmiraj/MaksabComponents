
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

extension UITextField: Shakeable{
    
    
    public func isValid(exp:RegularExpressions) -> Bool{
        return UITextField.isValid(text: self.text ?? "", forExp: exp)
    }

	static public func isValid(text: String, forExp exp: RegularExpressions) -> Bool {
		if let emailTest = NSPredicate(format:"SELF MATCHES %@", exp.rawValue) as NSPredicate? {
			return emailTest.evaluate(with: text)
		}
		return false
	}
}

extension UITextField{
    
    public func addActivityIndicatory()  {
        let ind = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 12, height: 12))
        ind.activityIndicatorViewStyle = .gray
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 15))
        view.addSubview(ind)
        self.rightViewMode = .always
        ind.startAnimating()
        self.rightView = view
    }
    
    public func removeActivityIndicator()  {
        self.rightView = nil
        self.rightViewMode = .never
    }
}
