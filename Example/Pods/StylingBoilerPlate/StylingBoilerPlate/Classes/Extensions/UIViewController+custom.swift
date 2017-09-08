//
//  UIViewController+custom.swift
//  Pods
//
//  Created by Incubasys on 24/07/2017.
//
//

import UIKit

public extension UIViewController {
    public var isModal: Bool {
        if let index = navigationController?.viewControllers.index(of: self), index > 0 {
            return false
        } else if presentingViewController != nil {
            return true
        } else if navigationController?.presentingViewController?.presentedViewController == navigationController  {
            return true
        } else if tabBarController?.presentingViewController is UITabBarController {
            return true
        } else {
            return false
        }
    }
}
