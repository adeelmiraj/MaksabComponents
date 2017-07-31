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
    
    
    @IBOutlet weak var labelBottom: NSLayoutConstraint!
    @IBOutlet weak var subtitleHeight: NSLayoutConstraint!
    @IBOutlet weak var rightViewWidth: NSLayoutConstraint!
    
    var delegate: LeftIconTableViewCellDelegate?
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.hideDefaultSeparator()
        
        labelTitle.textColor = UIColor.appColor(color: .LightText)
        labelSubtitle.textColor = UIColor.appColor(color: .LightText)
    }

    override public func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func config(icon: UIImage, title:String, subtitle:String?, rightButtonTitle:String?, delegate:LeftIconTableViewCellDelegate?)  {
        self.icon.image = icon
        self.labelTitle.text = title
        if subtitle != nil{
            labelSubtitle.removeConstraint(subtitleHeight)
            labelSubtitle.text = subtitle
        }
        if rightButtonTitle != nil{
            rightViewWidth.constant = 114
            rightButton.setTitle(rightButtonTitle, for: .normal)
        }
        self.delegate = delegate
    }
    
}
