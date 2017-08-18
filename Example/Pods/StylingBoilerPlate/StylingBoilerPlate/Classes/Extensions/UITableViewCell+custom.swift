//
//  UITableViewCell+custom.swift
//  Pods
//
//  Created by Incubasys on 24/07/2017.
//
//

import UIKit

public extension UITableViewCell{
     public func hideDefaultSeparator(){
        let indent_large_enought_to_hidden:CGFloat = 10000
        separatorInset = UIEdgeInsetsMake(0, indent_large_enought_to_hidden, 0, 0)
        indentationWidth = indent_large_enought_to_hidden * -1
        indentationLevel = 1
    }
}
