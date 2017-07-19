//
//  DashedBorderButton.swift
//  Managin Bundles
//
//  Created by Incubasys on 13/07/2017.
//  Copyright © 2017 Incubasys. All rights reserved.
//

import UIKit

public class DashedBorderButton: UIButton,Configurable {

    public override func awakeFromNib() {
        config()
    }

    func config() {
        addBorder()
        self.titleLabel?.font = UIFont.appFont(font: .RubikRegular, pontSize: 14)
        self.tintColor = UIColor.appColor(color: .Secondary)
        self.setTitleColor(UIColor.appColor(color: .Secondary), for: .normal)
    }
    
    func addBorder()  {
        let borderLayer = CAShapeLayer()
        borderLayer.fillColor = nil
        borderLayer.strokeColor = UIColor.appColor(color: .Secondary).cgColor
        borderLayer.lineDashPattern = [3, 3]
        borderLayer.lineJoin = kCALineJoinRound
        borderLayer.frame = self.bounds
        borderLayer.path = UIBezierPath(rect: self.bounds).cgPath
        self.layer.addSublayer(borderLayer)
    }
}
