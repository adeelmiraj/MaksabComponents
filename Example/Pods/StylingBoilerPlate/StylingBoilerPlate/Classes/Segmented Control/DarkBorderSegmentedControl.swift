import UIKit

public class DarkBorderSegmentedControl: UISegmentedControl {
    
    
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
        sharpCornersStyle(normalBackgroudColor: UIColor.clear, selectedBackggroundColor: UIColor.appColor(color: .Secondary), tintColor: UIColor.appColor(color: .Secondary), selectedTextColor: UIColor.appColor(color: .Light))
    }
    
    func sharpCornersStyle(normalBackgroudColor:UIColor,selectedBackggroundColor:UIColor,tintColor:UIColor,selectedTextColor:UIColor) {
        
//        let img = UIImage.getImageFromColor(color: normalBackgroudColor, size: CGSize(width: 200, height: 200))
//        self.setBackgroundImage(img, for: UIControlState.normal, barMetrics: .default)
        
//        self.setBackgroundImage(UIImage.getImageFromColor(color: selectedBackggroundColor, size: CGSize(width: 200, height: 200)), for: UIControlState.selected, barMetrics: .default)
        
        self.tintColor = tintColor
        
        let img = UIImage.getImageFromColor(color: UIColor.init(netHex: 0x979797), size: CGSize(width: 1, height: self.frame.size.height))
        self.setDividerImage(img, forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)
        
        let titleTextAttributes = [NSForegroundColorAttributeName: selectedTextColor]
        self.setTitleTextAttributes(titleTextAttributes, for: .selected)
        self.setTitleTextAttributes(titleTextAttributes, for: .normal)
        
        self.backgroundColor = normalBackgroudColor
        
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 5
        self.layer.borderColor = UIColor.init(netHex: 0x979797).cgColor
    }
    

}
