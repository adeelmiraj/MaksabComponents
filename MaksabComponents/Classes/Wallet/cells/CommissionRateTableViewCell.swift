//
//  CommissionRateTableViewCell.swift
//  Maksab Driver
//
//  Created by Incubasys on 23/08/2017.
//  Copyright © 2017 Incubasys. All rights reserved.
//

import UIKit
import StylingBoilerPlate

public class CommissionRateTableViewCell: UITableViewCell, NibLoadableView {

    @IBOutlet weak var staticLabelCommissionRate: UILabel!
    @IBOutlet weak var staticLabelRank: UILabel!
    @IBOutlet weak var commissionRate: UILabel!
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.backgroundColor = UIColor.appColor(color: .Dark)
        staticLabelCommissionRate.text = "Commission Rate"
        staticLabelRank.text = "Rank:"
    }

    override public func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func config(comissionRate: Double)  {
        commissionRate.text = "\(comissionRate)%"
    }
    
}
