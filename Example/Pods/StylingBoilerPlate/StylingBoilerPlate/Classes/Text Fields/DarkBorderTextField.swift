

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
    
    public func addActivityIndicatory()  {
        let ind = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 12, height: 12))
        ind.activityIndicatorViewStyle = .gray
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 15))
        view.addSubview(ind)
        self.rightViewMode = .always
        ind.startAnimating()
        self.rightView = view
    }
    
    public func removeActivityIndicator()  {
        self.rightView = nil
        self.rightViewMode = .never
    }
}
