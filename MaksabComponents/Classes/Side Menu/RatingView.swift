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

        let bundle = Bundle(for: type(of: self))
        let starEmpty = UIImage(named: "star-empty", in: bundle, compatibleWith: nil)
        let starFilled = UIImage(named: "star-filled", in: bundle, compatibleWith: nil)
        settings.emptyImage = starEmpty
        settings.filledImage = starFilled
        settings.starMargin = 0
        settings.totalStars = 5
        
        
    }
    
    open override func prepareForInterfaceBuilder() {
        update()

        super.prepareForInterfaceBuilder()
    }
}
