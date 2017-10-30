//
//  TripRatingAndSourceDestinationTableViewCell.swift
//  Maksab
//
//  Created by Incubasys on 16/08/2017.
//  Copyright © 2017 Incubasys. All rights reserved.
//

import UIKit
import StylingBoilerPlate
import MaksabComponents

public class TripRatingAndSourceDestinationTableViewCell: UITableViewCell, NibLoadableView{

    @IBOutlet weak public var source: TextLabel!
    @IBOutlet weak public var destination: TextLabel!
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
    
    public func config(startAddress: String, endAddress: String, rideRating: Double)  {
        source.text = startAddress
        destination.text = endAddress
        ratingView.rating = rideRating
    }
    
}
