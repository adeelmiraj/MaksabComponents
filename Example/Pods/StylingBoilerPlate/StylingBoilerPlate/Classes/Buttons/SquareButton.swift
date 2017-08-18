//
//  SquareButton.swift
//  Managin Bundles
//
//  Created by Incubasys on 11/07/2017.
//  Copyright © 2017 Incubasys. All rights reserved.
//

import UIKit

protocol Configurable {
    func config()
}

public class SquareBotton: UIButton,Configurable {
    
    @IBInspectable public var hasTitle: Bool = false
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        config()
    }
    
    func config() {
        self.setImage(self.imageView?.image?.withRenderingMode(.alwaysOriginal), for: .normal)
        
        if hasTitle{
            self.setTitleColor(UIColor.appColor(color: .Dark), for: .normal)
            centerVertically()
        }else{
            self.setTitle("", for: .normal)
        }
    }
    
    func centerVertically()  {
        centerVerticallyWithPadding(padding:6.0)
    }
    
    func centerVerticallyWithPadding(padding: CGFloat)  {
        
        let imageSize = self.imageView!.frame.size;
        let titleSize = self.titleLabel!.frame.size;
        
        let totalHeight = (imageSize.height + titleSize.height + padding);
        
        self.imageEdgeInsets = UIEdgeInsetsMake(-(totalHeight - imageSize.height), CGFloat(0.0), CGFloat(0.0),
                                                  -titleSize.width)
        
        self.titleEdgeInsets = UIEdgeInsetsMake(CGFloat(0.0), -imageSize.width, -(totalHeight - titleSize.height),
                                                  CGFloat(0.0))
        
        self.contentEdgeInsets = UIEdgeInsetsMake(CGFloat(0.0), CGFloat(0.0), titleSize.height, CGFloat(0.0))
    }
}

//height=48, aspectRatio = 1:1
/*
class SquareButton: UIButton, Configurable {

    
    override func awakeFromNib() {
        config()
    }
    
    func config()  {
        self.backgroundColor = UIColor.appColor(color: .Light)
        self.tintColor = UIColor.appColor(color: .Dark)
        
        self.layer.borderColor = UIColor.appColor(color: .Dark).cgColor
        self.layer.borderWidth = 1
        
        self.layer.cornerRadius = 5
        
        self.setTitle("", for: .normal)
        
    }
    
    func setTitleToBottom()  {
        var f = self.imageView!.frame
        let originX = truncf(Float((self.bounds.size.width - f.size.width) / 2))
        f = CGRect(x: CGFloat(originX), y: 0.0, width: f.size.width, height: f.size.height)
        self.imageView?.frame = f
        
        f = self.titleLabel!.frame
        let titleOriginX = truncf(Float((self.bounds.size.width - f.size.width) / 2))
        f = CGRect(x: CGFloat(titleOriginX),y: self.bounds.size.height - f.size.height,width: f.size.width,height: f.size.height)
        self.titleLabel?.frame = f
    }
}*/
