//
//  CardView.swift
//  Cap
//
//  Created by Pantera Engineering on 21/12/2016.
//  Copyright © 2016 Incubasys IT Solutions. All rights reserved.
//

import UIKit

class CardView: UIView {
    
    
    @IBInspectable var cornerRadius: CGFloat = 6
    
    @IBInspectable var shadowOffsetWidth: Int = 0
    @IBInspectable var shadowOffsetHeight: Int = 1
    @IBInspectable var shadowColor: UIColor? = UIColor.black.withAlphaComponent(0.24)
    @IBInspectable var shadowOpacity: Float = 1
    
    override func awakeFromNib() {
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
  
    override func layoutSubviews() {
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
