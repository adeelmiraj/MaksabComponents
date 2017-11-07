//
//  PayMaksabTableViewCell.swift
//  Maksab Driver
//
//  Created by Incubasys on 23/08/2017.
//  Copyright © 2017 Incubasys. All rights reserved.
//

import UIKit
import StylingBoilerPlate
@objc public protocol CurrentBalanceTableViewCellDelegate {
    func currentBalanceAction()
    @objc optional func showInfo()
}

public class CurrentBalanceTableViewCell: UITableViewCell, NibLoadableView {

    @IBOutlet weak public var labelTitle: UILabel!
    @IBOutlet weak var staticLabelPriceUnit: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak public var btnInfo: UIButton!
    @IBOutlet weak public var btnPayNow: UIButton!
    
    var delegate: CurrentBalanceTableViewCellDelegate?
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.backgroundColor = UIColor.appColor(color: .Dark)
        staticLabelPriceUnit.text = "SAR"
        btnInfo.tintColor = UIColor.appColor(color: .Secondary)
    }

    override public func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func config(title: String, amount: Double, delegate: CurrentBalanceTableViewCellDelegate, hideInfoBtn: Bool = true)  {
        self.labelTitle.text = title
        self.delegate = delegate
        btnInfo.isHidden = hideInfoBtn
        price.text = String(format:"%.2f",amount)
    }
    
    @IBAction func actPayNow(){
        delegate?.currentBalanceAction()
    }
    
    @IBAction func actShowInfo(){
        delegate?.showInfo?()
    }
}
