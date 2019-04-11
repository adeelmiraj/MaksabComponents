//
//  PageLoadingView.swift
//  71stStreet
//
//  Created by Pantera Engineering on 13/01/2017.
//  Copyright © 2017 Incubasys IT Solutions. All rights reserved.
//
/*
    Used for pagination
    This view is used to show loading at bottom when loading next page
 
 */
import Foundation
import UIKit

public class PageLoadingView : UIView, NibLoadableView, CustomView{
    
    @IBOutlet public var labelMsg: UILabel!
    
    var contentView: UIView!
	let bundle = Bundle(for: PageLoadingView.classForCoder())
    override required public init(frame: CGRect) {
        super.init(frame: frame)
        contentView = commonInit(bundle: bundle)
//        configView()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        contentView = commonInit(bundle: bundle)
//        configView()
    }

    
}
