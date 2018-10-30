//
//  MLMLevelDetailsTableViewCell.swift
//  Pods
//
//  Created by Incubasys on 03/10/2017.
//
//

import UIKit
import StylingBoilerPlate

public class MLMLevelDetailsTableViewCell: UITableViewCell, NibLoadableView {

    @IBOutlet weak var badgeImg: UIImageView!
    @IBOutlet weak var labelLevel: UILabel!
    @IBOutlet weak var noOfPeople: UILabel!
    @IBOutlet weak public var staticLabelPeople: UILabel!
    @IBOutlet weak public var validity: UILabel!
    @IBOutlet weak public var earnings: UILabel!
    
    @IBOutlet weak var lockedBadge: UIImageView!
    override public func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        hideDefaultSeparator()
        configView()
    }

    
    func configView()  {
        self.backgroundColor = UIColor.appColor(color: .Light)
        
        badgeImg.tintColor = UIColor.appColor(color: .Primary)
        badgeImg.setImg(named: "badge",redneringMode: .alwaysTemplate)
        
        lockedBadge.setLocalizedImg(named: "mlm-locked-badge")
        
        staticLabelPeople.text = Bundle.localizedStringFor(key: "wallet-mlm-people")
        staticLabelPeople.textColor = UIColor.appColor(color: .Primary)
        staticLabelPeople.font = TextLabel.font()
        
        noOfPeople.textColor = UIColor.appColor(color: .Primary)
        noOfPeople.font = ShoutnoteLabel.font()
        
        earnings.font = TextLabel.font()
        earnings.textColor = UIColor.appColor(color: .Primary)
    }
    
    override public func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func config(level: Int, peoples: Int, earnings: Double, expiryDateString: String?, isUnlocked: Bool)  {
        let format = Bundle.localizedStringFor(key: "wallet-mlm-level")
        labelLevel.text = String(format: format,level)
        noOfPeople.text = "\(peoples)"
        
        //Earnings
        let unitFormat = Bundle.localizedStringFor(key: "constant-currency-SAR")
        let unit = String(format: unitFormat,earnings)
        let formatEarnings = Bundle.localizedStringFor(key: "wallet-mlm-earnings")
        self.earnings.text = String(format: formatEarnings,unit)
        
        //validity
        if isUnlocked{
            let format = Bundle.localizedStringFor(key: "wallet-mlm-unlocked-until")
            validity.text = String(format:format,expiryDateString ?? "")
            validity.textColor = UIColor.appColor(color: .Secondary)
            lockedBadge.isHidden = true
        }else{
            validity.text = Bundle.localizedStringFor(key: "wallet-mlm-take-more-rides-to-unlock")
            validity.textColor = UIColor.appColor(color: .Secondary)
            lockedBadge.isHidden = false
        }
    }
    
}
