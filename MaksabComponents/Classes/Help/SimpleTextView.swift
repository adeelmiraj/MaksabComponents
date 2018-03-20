        //
//  SImpleTextView.swift
//  Pods
//
//  Created by Incubasys on 19/09/2017.
//
//

import UIKit
import StylingBoilerPlate

public protocol  SimpleTextViewDelegate{
    func onTapped(tag: Int, view: SimpleTextView)
}
public class SimpleTextView: UIView, NibLoadableView, CustomView {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var leftIcon: UIImageView!
    
    @IBOutlet weak var separatorView: UIView!
    @IBOutlet weak var leftIconWidth: NSLayoutConstraint!
    
    @IBOutlet weak var leftIconTrailing: NSLayoutConstraint!
    
    let bundle = Bundle(for: SimpleTextView.classForCoder())
    var contentView: UIView!
    public var delegate: SimpleTextViewDelegate?
    
    public var isLight: Bool = true{
        didSet{
            if isLight{
                self.backgroundColor = UIColor.appColor(color: .Light)
                leftIcon.tintColor = UIColor.appColor(color: .Dark)
                title.textColor = UIColor.appColor(color: .DarkText)
            }else{
                self.backgroundColor = UIColor.appColor(color: .Dark)
                leftIcon.tintColor = UIColor.appColor(color: .Light)
                title.textColor = UIColor.appColor(color: .LightText)
            }
        }
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override public required init(frame: CGRect) {
        super.init(frame: frame)
        contentView = commonInit(bundle: bundle)
        configView()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        contentView = commonInit(bundle: bundle)
        configView()
    }
    
    func configView()  {
        contentView.backgroundColor = UIColor.clear
        isLight = true
        separatorView.backgroundColor = UIColor.appColor(color: .Header)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(actViewTapped))
        self.addGestureRecognizer(tapGesture)
    }
    
    public func config(title:String)  {
        self.title.text = title
    }
    
    public func addLeftView(img: UIImage?)  {
        leftIcon.image = img
        leftIconWidth.constant = 16
        leftIconTrailing.constant = 12
    }
    
    public func removeLeftView()  {
        leftIconWidth.constant = 16
        leftIconTrailing.constant = 12
        leftIcon.image = nil
    }
    
    func actViewTapped()  {
        delegate?.onTapped(tag: self.tag, view: self)
    }

}
