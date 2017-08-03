//
//  LeftIconWithSubtitlesTableViewCell.swift
//  Pods
//
//  Created by Incubasys on 01/08/2017.
//
//

import UIKit
import StylingBoilerPlate

public protocol LeftIconWithSubtitlesCellDelegate{
    func actionLeftButton(sender: UIButton)
}

public class LeftIconWithSubtitlesTableViewCell: UITableViewCell, NibLoadableView{

    @IBOutlet weak public var icon: UIImageView!
    @IBOutlet weak public var labelTitle: UILabel!
    @IBOutlet weak public var labelSubtitle: UILabel!
    @IBOutlet weak var rightButton: UIButton!
    
    @IBOutlet weak var rightViewWidth: NSLayoutConstraint!
    
    var delegate: LeftIconWithSubtitlesCellDelegate?
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        self.hideDefaultSeparator()
        
        labelTitle.textColor = UIColor.appColor(color: .LightText)
        labelSubtitle.textColor = UIColor.appColor(color: .LightText)
        self.backgroundColor = UIColor.appColor(color: .Dark)
        self.icon.tintColor = UIColor.appColor(color: .Light)
        
    }
    
    override public func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    public func config(icon: UIImage, title:String, subtitle:String, rightButtonTitle:String?, delegate:LeftIconWithSubtitlesCellDelegate?)  {
        self.icon.image = icon.withRenderingMode(.alwaysTemplate)
        self.labelTitle.text = title
        self.labelSubtitle.text = subtitle
        
        if rightButtonTitle != nil{
            rightViewWidth.constant = 114
            rightButton.setTitle(rightButtonTitle, for: .normal)
        }
        self.delegate = delegate
    }

    
}
