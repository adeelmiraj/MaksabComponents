//
//  SimpleTextTableViewCell.swift
//  Pods
//
//  Created by Incubasys on 09/08/2017.
//
//

import UIKit
import StylingBoilerPlate

public class SimpleTextTableViewCell: UITableViewCell, NibLoadableView {

    @IBOutlet weak public var labelTitle: UILabel!
    @IBOutlet weak public var labelSubtitle: UILabel!
    @IBOutlet weak var subtitleLeading: NSLayoutConstraint!
    
    @IBOutlet weak var accessoryViewWidth: NSLayoutConstraint!
    @IBOutlet weak var accessoryViewImg: UIImageView!
    @IBOutlet weak var accessoryViewTrailing: NSLayoutConstraint!
    
    @IBOutlet weak var separatorView: UIView!
    
    public var isLight: Bool = true{
        didSet{
            if isLight{
                self.backgroundColor = UIColor.appColor(color: .Light)
                self.labelTitle.textColor = UIColor.appColor(color: .DarkText)
                self.labelSubtitle.textColor = UIColor.appColor(color: .DarkText)
                accessoryViewImg.tintColor = UIColor.appColor(color: .Dark)
            }else{
                self.backgroundColor = UIColor.appColor(color: .Dark)
                self.labelTitle.textColor = UIColor.appColor(color: .LightText)
                self.labelSubtitle.textColor = UIColor.appColor(color: .LightText)
                accessoryViewImg.tintColor = UIColor.appColor(color: .Light)
            }
        }
    }
    
    public var hideSeparator: Bool = false{
        didSet{
            if hideSeparator{
                separatorView.isHidden = true
            }else{
                 separatorView.isHidden = false
            }
        }
    }
    public var hasSubtitle: Bool = false{
        didSet{
            if hasSubtitle{
                subtitleLeading.constant = 12
            }else{
                subtitleLeading.constant = 0
            }
        }
    }
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.layoutMargins = UIEdgeInsets.zero
        self.hideDefaultSeparator()
        separatorView.backgroundColor = UIColor.appColor(color: .Header)
        removeAccessoryView()
    }

    override public func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
       
    }
    
    public func addAccessoryView(img: UIImage?)  {
        accessoryViewWidth.constant = 16
        accessoryViewTrailing.constant = 12
        accessoryViewImg.image = img?.withRenderingMode(.alwaysTemplate)
    }
    
    public func removeAccessoryView()  {
        accessoryViewTrailing.constant = 0
        accessoryViewWidth.constant = 0
    }

    public func config(title: String, subtitle: String = "") {
        labelTitle.text = title
        labelSubtitle.text = subtitle
        self.hasSubtitle = !subtitle.isEmpty
    }
    
}
