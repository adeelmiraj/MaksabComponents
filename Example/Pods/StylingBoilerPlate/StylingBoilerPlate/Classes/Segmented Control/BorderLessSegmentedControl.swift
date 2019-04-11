//
//  BorderLessSegmentedControl.swift
//  Pods
//
//  Created by Incubasys on 09/08/2017.
//
//

import UIKit

public class BorderLessSegmentedControl: UISegmentedControl {
    
//    @IBInspectable public var isLightBackground: Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    override init(items: [Any]?) {
        super.init(items: items)
        setup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    public override func awakeFromNib() {
        setup()
    }
    
    
    //setup
    func setup()  {
        var normalTextColor: UIColor!
//        if isLightBackground{
            normalTextColor = UIColor.appColor(color: .DarkText)
//        }else{
//            normalTextColor = UIColor.appColor(color: .LightText)
//        }
        sharpCornersStyle(normalBackgroudColor: UIColor.white, selectedBackggroundColor: UIColor.appColor(color: .Primary), tintColor: UIColor.appColor(color: .Primary), normalTextColor: normalTextColor, selectedTextColor: UIColor.appColor(color: .Light))
    }
    
    func sharpCornersStyle(normalBackgroudColor:UIColor,selectedBackggroundColor:UIColor,tintColor:UIColor,normalTextColor: UIColor, selectedTextColor:UIColor) {
        
        let img = UIImage.getImageFromColor(color: normalBackgroudColor, size: CGSize(width: 200, height: 200))
        self.setBackgroundImage(img, for: UIControlState.normal, barMetrics: .default)
        
        let imgFocused = UIImage.getImageFromColor(color: selectedBackggroundColor.withAlphaComponent(0.2), size: CGSize(width: 200, height: 200))
//        setBackgroundImage(imgFocused, for: .focused, barMetrics: .default)
        setBackgroundImage(imgFocused, for: .highlighted, barMetrics: .default)
//        setBackgroundImage(img, for: ., barMetrics: <#T##UIBarMetrics#>)
        
        self.setBackgroundImage(UIImage.getImageFromColor(color: selectedBackggroundColor, size: CGSize(width: 200, height: 200)), for: UIControlState.selected, barMetrics: .default)
        
        self.tintColor = tintColor
        
        let img2 = UIImage.getImageFromColor(color: selectedBackggroundColor, size: CGSize(width: 1, height: self.frame.size.height))
        self.setDividerImage(img2, forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)
        
        let titleTextAttributes = [NSForegroundColorAttributeName: selectedTextColor]
        let normalTitleTextAttributes = [NSForegroundColorAttributeName: normalTextColor]
        self.setTitleTextAttributes(titleTextAttributes, for: .selected)
        self.setTitleTextAttributes(normalTitleTextAttributes, for: .normal)
        
        self.backgroundColor = normalBackgroudColor
        
        self.layer.borderWidth = 0
        self.layer.cornerRadius = 0
        self.layer.borderColor = selectedBackggroundColor.cgColor
        
    }
    
}

