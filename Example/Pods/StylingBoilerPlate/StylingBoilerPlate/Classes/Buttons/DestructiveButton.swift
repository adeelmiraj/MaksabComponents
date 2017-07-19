//
//  DestructiveButton.swift
//  Managin Bundles
//
//  Created by Incubasys on 12/07/2017.
//  Copyright © 2017 Incubasys. All rights reserved.
//

import UIKit

//height=48, aspectRatio = 145:24 LARGE
//height=28, aspectRatio = 45:14 SMALL
public class DestructiveButton: UIButton, Configurable {
    
    @IBInspectable public var isLarge: Bool = true
    
    override public func awakeFromNib() {
        config()
    }
    
    func config() {
        self.backgroundColor = UIColor.appColor(color: .Destructive)
        self.tintColor = UIColor.appColor(color: .Light)
        self.layer.cornerRadius = 6
        
        if isLarge{
            self.titleLabel?.font = UIFont.appFont(font: .RubikMedium, pontSize: 16)
        }else{
            self.titleLabel?.font = UIFont.appFont(font: .RubikMedium, pontSize: 12)
        }
    }
    
}
