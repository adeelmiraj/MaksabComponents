//
//  ToggleBottomTitleButton.swift
//  Managin Bundles
//
//  Created by Incubasys on 13/07/2017.
//  Copyright © 2017 Incubasys. All rights reserved.
//

import UIKit
public protocol Toggleable{
    func onToggle(stateSelected:Bool, sender: UIButton)
}

public class ToggleBottomTitleButton: UIButton, Configurable {

    @IBInspectable public var stateSelected: Bool = false{
        didSet{
            toggleState(state: stateSelected)
        }
    }
    
    public var toggleDelegate:Toggleable?
    
    private func toggleState(state:Bool){
        print("state:\(state)")
        if state {
            self.tintColor = UIColor.appColor(color: .Primary)
            self.setTitleColor(UIColor.appColor(color: .Primary), for: .normal)
        }else {
            self.tintColor = UIColor.appColor(color: .Dark)
            self.setTitleColor(UIColor.appColor(color: .Dark), for: .normal)
        }
    }

    public override func layoutSubviews() {
        super.layoutSubviews()
        config()
    }
    
    func config() {
//        self.setTitleColor(UIColor.appColor(color: .Dark), for: .normal)
        self.titleLabel?.font = UIFont.appFont(font: .RubikRegular, pontSize: 14)
        centerVertically()
        toggleState(state: stateSelected)
         self.addTarget(self, action: #selector(actionToggle), for: .touchUpInside)
    }
    
    func centerVertically()  {
        centerVerticallyWithPadding(padding:6.0)
    }
    
    func centerVerticallyWithPadding(padding: CGFloat)  {
        
        let imageSize = self.imageView!.frame.size;
        let titleSize = self.titleLabel!.frame.size;
        
        let totalHeight = (imageSize.height + titleSize.height + padding);
        let dir = Locale.characterDirection(forLanguage: Locale.current.languageCode ?? "en")
        if dir == .rightToLeft {
            self.imageEdgeInsets = UIEdgeInsetsMake(-(totalHeight - imageSize.height - padding - CGFloat(6.0)), -titleSize.width, CGFloat(0.0), CGFloat(0.0)
                                                    )
            
            self.titleEdgeInsets = UIEdgeInsetsMake(CGFloat(0.0), CGFloat(0.0), -(totalHeight - titleSize.height + padding),
                                                    -imageSize.width)
            
            self.contentEdgeInsets = UIEdgeInsetsMake(CGFloat(0.0), CGFloat(0.0), titleSize.height - padding, CGFloat(0.0))
            
        }else{
            self.imageEdgeInsets = UIEdgeInsetsMake(-(totalHeight - imageSize.height - padding - CGFloat(6.0)), CGFloat(0.0), CGFloat(0.0),
                                                    -titleSize.width)
            
            self.titleEdgeInsets = UIEdgeInsetsMake(CGFloat(0.0), -imageSize.width, -(totalHeight - titleSize.height + padding),
                                                    CGFloat(0.0))
            
            self.contentEdgeInsets = UIEdgeInsetsMake(CGFloat(0.0), CGFloat(0.0), titleSize.height - padding, CGFloat(0.0))
        }
//        self.imageEdgeInsets = UIEdgeInsetsMake(-(totalHeight - imageSize.height - padding - CGFloat(6.0)), CGFloat(0.0), CGFloat(0.0),
//                                                -titleSize.width)
//
//        self.titleEdgeInsets = UIEdgeInsetsMake(CGFloat(0.0), -imageSize.width, -(totalHeight - titleSize.height + padding),
//                                                CGFloat(0.0))
//
//        self.contentEdgeInsets = UIEdgeInsetsMake(CGFloat(0.0), CGFloat(0.0), titleSize.height - padding, CGFloat(0.0))
    }

    @objc private func actionToggle()  {
        stateSelected = !stateSelected
        toggleDelegate?.onToggle(stateSelected: stateSelected, sender: self)
    }
}
