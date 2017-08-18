//
//  RoundImageVIew.swift
//  Pods
//
//  Created by Incubasys on 16/08/2017.
//
//

import UIKit

public class RoundImageView: UIImageView {
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    @IBInspectable var showBorder: Bool = true
    @IBInspectable var lightBorder: Bool = false
    
    override public func awakeFromNib() {
        var color = UIColor.appColor(color: .Dark)
        if lightBorder{
            color = UIColor.appColor(color: .Light)
        }
        
        if showBorder{
            self.layer.borderWidth = 1
            self.layer.borderColor = color.cgColor
        }
        self.backgroundColor = UIColor.appColor(color: .Medium)
    }
    override public func layoutSubviews() {
        self.layer.cornerRadius = self.frame.size.height/2
    }
}
