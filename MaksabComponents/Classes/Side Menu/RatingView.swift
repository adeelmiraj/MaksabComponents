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
        
//        print(Constants.bundleIdentifier)
        let bundleHelper = BundleHelper(resourceName: Constants.resourceName)
        let starEmpty = bundleHelper.getImageFromMaksabComponent(name: "star-empty", _class: RatingView.self)
        let starFilled = bundleHelper.getImageFromMaksabComponent(name: "star-filled", _class: RatingView.self)
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
