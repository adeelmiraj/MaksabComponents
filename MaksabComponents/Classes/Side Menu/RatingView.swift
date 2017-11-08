//
//  RatingView.swift
//  Pods
//
//  Created by Incubasys on 26/07/2017.
//
//

import UIKit
import Cosmos
import StylingBoilerPlate
open class RatingView: CosmosView{
    
    override open func awakeFromNib() {
        super.awakeFromNib()

        settings.emptyImage = UIImage.image(named: "star-empty")
        settings.filledImage = UIImage.image(named: "star-filled")
        settings.starMargin = 0
        settings.totalStars = 5
        self.backgroundColor = UIColor.clear
    }
    
    open override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        update()
    }
}
