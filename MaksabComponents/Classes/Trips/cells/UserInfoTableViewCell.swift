//
//  UserInfoTableViewCell.swift
//  Maksab
//
//  Created by Incubasys on 16/08/2017.
//  Copyright © 2017 Incubasys. All rights reserved.
//

import UIKit
import StylingBoilerPlate

public class UserInfoTableViewCell: UITableViewCell, NibLoadableView {

    @IBOutlet weak public var userPhoto: RoundImageView!
    @IBOutlet weak public var userName: UILabel!
    @IBOutlet weak public var carName: UILabel!
    @IBOutlet weak public var licencsePlate: UILabel!
    @IBOutlet weak public var ratingView: RatingView!
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.backgroundColor = UIColor.appColor(color: .Dark)
        hideDefaultSeparator()
    }

    override public func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func config(name: String, carName: String,carLicensePlate: String, rating: Double)  {
        userName.text = name
        self.carName.text = carName
        licencsePlate.text = carLicensePlate
        ratingView.rating = rating
    }
    
}
