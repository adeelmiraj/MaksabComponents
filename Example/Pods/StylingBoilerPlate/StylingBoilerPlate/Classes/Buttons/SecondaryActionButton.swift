//
//  SecondaryActionButton.swift
//  Managin Bundles
//
//  Created by Incubasys on 11/07/2017.
//  Copyright © 2017 Incubasys. All rights reserved.
//

import UIKit

//height=20, aspectRatio = 34:5
public class SecondaryActionButton: UIButton, Configurable  {
    public override func awakeFromNib() {
        config()
    }
    
    func config()  {
        self.backgroundColor = UIColor.clear
        self.tintColor = UIColor.appColor(color: .Secondary)
        
        self.titleLabel?.font = UIFont.appFont(font: .RubikRegular, pontSize: 16)
        self.titleEdgeInsets.left = 8
        self.setTitleColor(UIColor.appColor(color: .Secondary), for: .normal)
        
        
    }

}
