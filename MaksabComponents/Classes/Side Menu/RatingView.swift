//
//  RatingView.swift
//  Pods
//
//  Created by Incubasys on 26/07/2017.
//
//

import UIKit
import Cosmos

@IBDesignable open class RatingView: CosmosView{
    
    override open func awakeFromNib() {
        super.awakeFromNib()
        let starEmpty = BundleHelper.getImageFromMaksabComponent(name: "star-empty", _class: RatingView.self)
        let starFilled = BundleHelper.getImageFromMaksabComponent(name: "star-filled", _class: RatingView.self)
        settings.emptyImage = starEmpty
        settings.filledImage = starFilled
        settings.starMargin = 0
        settings.totalStars = 5
    }
    
    open override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        update()
    }
}
