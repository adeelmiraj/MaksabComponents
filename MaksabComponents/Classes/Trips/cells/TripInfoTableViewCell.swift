                                                                                                                                                                                                                                                                                                                                                                                                                     //
//  TripInfoTableViewCell.swift
//  Maksab
//
//  Created by Incubasys on 16/08/2017.
//  Copyright © 2017 Incubasys. All rights reserved.
//

import UIKit
import StylingBoilerPlate
public class TripInfoTableViewCell: UITableViewCell, NibLoadableView {
    
    @IBOutlet weak public var dateTime: CaptionLabel!
    @IBOutlet weak public var tripStatus: CaptionLabel!
    @IBOutlet weak public var carName: TextLabel!
    @IBOutlet weak public var price: TextLabel!
    @IBOutlet weak public var webView: UIWebView!
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        hideDefaultSeparator()
        backgroundColor = UIColor.appColor(color: .Medium)
    }
    
    override public func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    public func config(endedTime: String, carName: String, status: String, statusColor: UIColor, actualCost: String)  {
        dateTime.text = endedTime
        self.carName.text = carName
        tripStatus.text = status
        tripStatus.textColor = statusColor
        price.text = actualCost
    }
}
