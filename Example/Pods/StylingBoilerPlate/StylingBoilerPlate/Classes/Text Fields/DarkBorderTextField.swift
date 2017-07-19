

import UIKit

public class DarkBorderTextField: UITextField, Configurable{
    
    override init(frame: CGRect) {
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
}
