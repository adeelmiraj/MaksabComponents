//
//  ComplaintInquiryTableViewCell.swift
//  Maksab
//
//  Created by Incubasys on 16/08/2017.
//  Copyright © 2017 Incubasys. All rights reserved.
//

import UIKit
import StylingBoilerPlate

public protocol ComplainCellDelegete {
    func actComplain()
    func rideAgain(state: Bool)
}
public class ComplaintInquiryTableViewCell: UITableViewCell, NibLoadableView {

    @IBOutlet weak public var btnComplain: PrimaryButton!
    @IBOutlet weak public var rideAgainSwitch: UISwitch!
    @IBOutlet weak public var labelRideAgain: TextLabel!
    
    public var delegate: ComplainCellDelegete?
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        hideDefaultSeparator()
        self.backgroundColor = UIColor.appColor(color: .Light)
        labelRideAgain.text = ""
       btnComplain.setTitle(Bundle.localizedStringFor(key: "trip-cell-complain-btn-title"), for: .normal)
    }

    override public func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func config(userName: String)  {
        let format = Bundle.localizedStringFor(key: "trip-cell-complain-ride-again")
        labelRideAgain.text = String(format: format,userName)
    }
    
    @IBAction func actComplain(_ sender: PrimaryButton) {
        delegate?.actComplain()
    }
    @IBAction func actRideAgain(_ sender: UISwitch) {
        delegate?.rideAgain(state: sender.isOn)
    }
}
