//
//  RoundTextField.swift
//  Pods
//
//  Created by Incubasys on 18/07/2017.
//
//

import UIKit

public class RoundTextField: UITextField, Configurable{

    override public func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 16, dy: 0)
    }
    
    override public func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 16, dy: 0)
    }
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        config()
    }
    
    func config() {
        self.layer.cornerRadius = 18
        self.backgroundColor = UIColor.init(netHex: 0xE8E6E6)
        self.clearButtonMode = .whileEditing
        self.borderStyle = .none
        
        self.clipsToBounds = true
        
        self.layoutMargins = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
        
        self.font = UIFont.appFont(font: .RubikRegular, pontSize: 14)
        setupPlaceHolder()
    }
    
    func setupPlaceHolder() -> Void {
        let attrPlaceholder = NSMutableAttributedString.init(string: self.placeholder!)
        let font = UIFont.appFont(font: .RubikRegular, pontSize: 14)
        
        attrPlaceholder.addAttributes([NSFontAttributeName:font, NSForegroundColorAttributeName:UIColor.appColor(color: .Medium)], range: NSMakeRange(0, placeholder!.characters.count))
        
        self.attributedPlaceholder = attrPlaceholder
    }

}
