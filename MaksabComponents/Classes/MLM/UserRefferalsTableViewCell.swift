//
//  UserRefferalsTableViewCell.swift
//  Pods
//
//  Created by Incubasys on 03/10/2017.
//
//

import UIKit
import StylingBoilerPlate

public class UserRefferalsTableViewCell: UITableViewCell, NibLoadableView {

    @IBOutlet weak public var userPhoto: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var totalRefferals: UILabel!
    @IBOutlet weak var accessoryImgView: UIImageView!
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        configView()
        hideDefaultSeparator()
    }

    override public func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configView()  {
        self.backgroundColor = UIColor.appColor(color: .Light)
        
        userPhoto.backgroundColor = UIColor.appColor(color: .Medium)
        userPhoto.layer.cornerRadius = userPhoto.frame.size.height / 2
        accessoryImgView.tintColor = UIColor.appColor(color: .Dark)
        accessoryImgView.setLocalizedImg(named: "arrow-right",redneringMode: .alwaysTemplate)
    }
    
    public func config(name: String, referrals: Int){
        userName.text = name
        let format = Bundle.localizedStringFor(key: "wallet-mlm-cell-user-refferals")
        totalRefferals.text = String(format: format, referrals)
    }
}
