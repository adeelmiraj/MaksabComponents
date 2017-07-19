//
//  BottomBorderTextField.swift
//  Pods
//
//  Created by Incubasys on 18/07/2017.
//
//

import UIKit

public class BottomBorderTextField: UITextField, Configurable{
    
    @IBInspectable public var bottomBorderWidth : CGFloat = 1
    @IBInspectable public var bottomBorderColor =  UIColor.appColor(color:.Dark)
    

    
    override public func awakeFromNib() {
        super.awakeFromNib()
        
        config() 
    }
    
    func config() {
        self.backgroundColor = UIColor.clear
        self.clearButtonMode = .whileEditing
        self.borderStyle = .none
        self.font = UIFont.appFont(font: .RubikRegular, pontSize: 15)
        
        self.setupPlaceHolder()
    }
    
    override public func draw(_ rect: CGRect) {
        let h = rect.height
        let w = rect.width
        let color:UIColor = bottomBorderColor
        
        let drect = CGRect(x: 0, y: h-bottomBorderWidth, width: w, height: bottomBorderWidth)
        let bpath:UIBezierPath = UIBezierPath(rect: drect)
        
        color.set()
        bpath.stroke()
    }
    
    func setupPlaceHolder() -> Void {
        let attrPlaceholder = NSMutableAttributedString.init(string: self.placeholder!)
        let font = UIFont.appFont(font: .RubikRegular, pontSize: 15)
        
        attrPlaceholder.addAttributes([NSFontAttributeName:font, NSForegroundColorAttributeName:UIColor.appColor(color: .Medium)], range: NSMakeRange(0, placeholder!.characters.count))
        
        self.attributedPlaceholder = attrPlaceholder
    }
    

}
