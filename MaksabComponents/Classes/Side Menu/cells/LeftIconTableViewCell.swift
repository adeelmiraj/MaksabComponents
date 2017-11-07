//
//  LeftIconTableViewCell.swift
//  Pods
//
//  Created by Incubasys on 25/07/2017.
//
//

import UIKit
import StylingBoilerPlate

public protocol LeftIconTableViewCellDelegate{
    func actionLeftButton(sender: UIButton)
}

public class LeftIconTableViewCell: UITableViewCell, NibLoadableView {

    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelSubtitle: UILabel!
    @IBOutlet weak var rightButton: UIButton!
    
    
    @IBOutlet weak var centerViewLeading: NSLayoutConstraint!
    @IBOutlet weak var labelBottom: NSLayoutConstraint!
    @IBOutlet weak var acessoryImgView: UIImageView!
    @IBOutlet weak var subtitleHeight: NSLayoutConstraint!
    @IBOutlet weak var rightViewWidth: NSLayoutConstraint!
    @IBOutlet weak var iconViewWidth: NSLayoutConstraint!
    @IBOutlet weak var centerViewTrailing: NSLayoutConstraint!
    
    public var hasIcon: Bool = true{
        didSet{
            if hasIcon{
                centerViewLeading.constant = 0
                iconViewWidth.constant = 52
            }else{
                iconViewWidth.constant = 0
                centerViewLeading.constant = 18
            }
        }
    }
    public var hasRightButton: Bool = false{
        didSet{
            if hasRightButton{
                rightViewWidth.constant = 114
            }else{
                rightViewWidth.constant = 0
            }
        }
    }
    
    public var isLight: Bool = true{
        didSet{
            if isLight{
                backgroundColor = UIColor.appColor(color: .Light)
                labelTitle.textColor = UIColor.appColor(color: .DarkText)
                labelSubtitle.textColor = UIColor.appColor(color: .DarkText)
                acessoryImgView.tintColor = UIColor.appColor(color: .DarkText)
                icon.tintColor = UIColor.appColor(color: .DarkText)
            }else{
                backgroundColor = UIColor.appColor(color: .Dark)
                labelTitle.textColor = UIColor.appColor(color: .LightText)
                labelSubtitle.textColor = UIColor.appColor(color: .LightText)
                acessoryImgView.tintColor = UIColor.appColor(color: .LightText)
                icon.tintColor = UIColor.appColor(color: .LightText)
            }
        }
    }
    
    var delegate: LeftIconTableViewCellDelegate?
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.hideDefaultSeparator()
        hasIcon = true
        hasRightButton = false
        isLight = true
    }

    override public func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func addAccessoryView(img: UIImage){
        centerViewTrailing.constant = 50
        acessoryImgView.image = img
        acessoryImgView.isHidden = false
    }
    public func hideAccessoryView(){
        centerViewTrailing.constant = 12
        acessoryImgView.image = nil
        acessoryImgView.isHidden = true
    }
    public func configRightButton(btnTitle:String? , delegate:LeftIconTableViewCellDelegate?){
        rightViewWidth.constant = 114
        rightButton.setTitle(btnTitle, for: .normal)
    }
    
    public func config(icon: UIImage?, title:String, subtitle:String? = nil)  {
        self.icon.image = icon
        self.labelTitle.text = title
        if subtitle != nil{
            labelSubtitle.removeConstraint(subtitleHeight)
            labelSubtitle.text = subtitle
        }
    }
    
}
