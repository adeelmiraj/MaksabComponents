//
//  CardView.swift
//  Cap
//
//  Created by Pantera Engineering on 21/12/2016.
//  Copyright © 2016 Incubasys IT Solutions. All rights reserved.
//

import UIKit

open class CardView: UIView {
    
    
    @IBInspectable public var cornerRadius: CGFloat = 6
    
    @IBInspectable public var shadowOffsetWidth: Int = 0
    @IBInspectable public var shadowOffsetHeight: Int = 1
    @IBInspectable public var shadowColor: UIColor? = UIColor.black.withAlphaComponent(0.24)
    @IBInspectable public var shadowOpacity: Float = 1
    
    override open func awakeFromNib() {
//        layer.cornerRadius = cornerRadius
//        let rect = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width-24, height: bounds.height)
//        let shadowPath = UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius)
//        
//        layer.masksToBounds = false
//        layer.shadowColor = shadowColor?.cgColor
//        layer.shadowOffset = CGSize(width: shadowOffsetWidth, height: shadowOffsetHeight);
//        layer.shadowOpacity = shadowOpacity
//        layer.shadowPath = shadowPath.cgPath
    }
  
    override open func layoutSubviews() {
        layer.cornerRadius = cornerRadius
        let shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: cornerRadius)
        
        layer.masksToBounds = false
//        layer.borderWidth = 1
//        layer.borderColor = UIColor.black
        layer.cornerRadius = cornerRadius
        layer.shadowColor = shadowColor?.cgColor
        layer.shadowOffset = CGSize(width: shadowOffsetWidth, height: shadowOffsetHeight);
        layer.shadowOpacity = shadowOpacity
        layer.shadowPath = shadowPath.cgPath
    }
    
    
    
}
