//
//  ToggleButton.swift
//  Managin Bundles
//
//  Created by Incubasys on 12/07/2017.
//  Copyright © 2017 Incubasys. All rights reserved.
//

import UIKit

//height=48, aspectRatio = 17:6
public class ToggleButton: UIButton, Configurable  {
    
    @IBInspectable public var stateSelected: Bool = false{
        didSet{
          toggleState(state: stateSelected)
        }
    }
    @IBInspectable public var selectedStateImage: UIImage!
    @IBInspectable public var unSelectedStateImage: UIImage!
    
    private func toggleState(state:Bool){
        print("state:\(state)")
        if state{
            self.setTitleColor(UIColor.appColor(color: .Primary), for: .normal)
            self.setImage(selectedStateImage.withRenderingMode(.alwaysOriginal), for: .normal)
        }else{
            self.setTitleColor(UIColor.appColor(color: .Dark), for: .normal)
            self.setImage(unSelectedStateImage.withRenderingMode(.alwaysOriginal), for: .normal)
        }
    }
    
    public override func awakeFromNib() {
        config()
    }
    
    func config()  {

        self.titleLabel?.font = UIFont.appFont(font: .RubikRegular, pontSize: 16)
        self.titleEdgeInsets.left = 8
        self.titleLabel?.lineBreakMode = .byWordWrapping
        
        self.imageView?.contentMode = .scaleAspectFit
        
        if selectedStateImage == nil || unSelectedStateImage == nil{
            fatalError("selected and Unselected Images are required for ToggleBottomTitelButtona")
        }
        toggleState(state: stateSelected)
        
        self.addTarget(self, action: #selector(actionToggle), for: .touchUpInside)
    }
    
    @objc private func actionToggle()  {
        stateSelected = !stateSelected
    }
}
