

import UIKit

public class DarkBorderTextField: UITextField, Configurable{
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        config()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        config()
    }
    
    func config() {
        self.backgroundColor = UIColor.appColor(color: .Light)
        self.font = UIFont.appFont(font: .RubikRegular, pontSize: 15)
        
        self.layer.cornerRadius = 5
        self.layer.borderColor = UIColor.appColor(color: .Dark).cgColor
        self.layer.borderWidth = 1
        
    }
    
    public override func textRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x+8, y: bounds.origin.y, width: bounds.size.width-16, height: bounds.size.height)
    }
    
    public override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x+8, y: bounds.origin.y, width: bounds.size.width-16, height: bounds.size.height)
    }
}
