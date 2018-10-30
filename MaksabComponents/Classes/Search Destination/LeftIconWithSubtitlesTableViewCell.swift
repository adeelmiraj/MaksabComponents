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
    func actionLeftButton(indexPath: IndexPath)
}

public class LeftIconWithSubtitlesTableViewCell: UITableViewCell, NibLoadableView{

    @IBOutlet weak public var icon: UIImageView!
    @IBOutlet weak public var labelTitle: UILabel!
    @IBOutlet weak public var labelSubtitle: UILabel!
    @IBOutlet weak var rightButton: UIButton!
	@IBOutlet weak var subtitleHeight: NSLayoutConstraint!
	@IBOutlet weak var subtitleTop: NSLayoutConstraint!
	
    @IBOutlet weak var accessoryImageView: UIImageView!
    @IBOutlet weak var rightViewWidth: NSLayoutConstraint!
    
    var delegate: LeftIconWithSubtitlesCellDelegate?
    var indexPath: IndexPath?
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        self.hideDefaultSeparator()
        
        labelTitle.textColor = UIColor.appColor(color: .DarkText)
        labelSubtitle.textColor = UIColor.appColor(color: .DarkText)
        self.backgroundColor = UIColor.appColor(color: .Light)
        self.icon.tintColor = UIColor.appColor(color: .Dark)
        
    }
    
    override public func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    public func config(icon: UIImage, title:String, subtitle:String, rightButtonTitle:String?, delegate:LeftIconWithSubtitlesCellDelegate?,indexPath: IndexPath?)  {
        self.indexPath = indexPath
        self.icon.image = icon.withRenderingMode(.alwaysTemplate)
        self.labelTitle.text = title
        self.labelSubtitle.text = subtitle
        showSubtitle()
        if rightButtonTitle != nil{
            rightButton.isHidden = true
            rightViewWidth.constant = 114
            rightButton.setTitle(rightButtonTitle, for: .normal)
        }
        self.delegate = delegate
    }

	public func hideSubtitle(){
		subtitleHeight.constant = 0
		subtitleTop.constant = 0
	}

	public func showSubtitle(){
		subtitleHeight.constant = 90
		subtitleTop.constant = 3
	}
	
    @IBAction func actRightButton(_ sender: PrimaryButton) {
        guard let index = self.indexPath else {
            return
        }
        delegate?.actionLeftButton(indexPath: index)
    }
    
    public func addLeftView(img: UIImage?)  {
        rightButton.isHidden = true
        rightViewWidth.constant = 16+12+12
        accessoryImageView.image = img
        
    }
    
    public func removeLeftView()  {
        rightViewWidth.constant = 0
    }
    
}
