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
    @IBOutlet weak public var comissionRate: UILabel!
    @IBOutlet weak public var earnings: UILabel!
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        hideDefaultSeparator()
        configView()
    }

    
    func configView()  {
        self.backgroundColor = UIColor.appColor(color: .Dark)
        badgeImg.setImg(named: "badge")
        staticLabelPeople.text = Bundle.localizedStringFor(key: "wallet-mlm-people")
    }
    
    override public func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func config(level: Int, peoples: Int, comissionRate: Double, earnings: Double)  {
        labelLevel.text = "\(level)"
        noOfPeople.text = "\(peoples)"
        
        let format = Bundle.localizedStringFor(key: "wallet-mlm-commission-rate")
        self.comissionRate.text = String(format: format, round(comissionRate))
        
        let unit = Bundle.localizedStringFor(key: "constant-currency-SAR")
        let formatEarnings = Bundle.localizedStringFor(key: "wallet-mlm-earnings")
        self.earnings.text = String(format: formatEarnings,unit,earnings)
    }
    
}
