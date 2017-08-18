//
//  TermsAndConditionsTemplateViewController.swift
//  Pods
//
//  Created by Incubasys on 24/07/2017.
//
//

import UIKit
import StylingBoilerPlate

open class TermsAndConditionsTemplateViewController: UIViewController, NibLoadableView{

    @IBOutlet weak public var labelTitle: UILabel!
    @IBOutlet weak public var textViewDetails: UITextView!
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        labelTitle.text = "Terms & Conditions"
        textViewDetails.font = UIFont.appFont(font: .RubikRegular, pontSize: 14)
        
    }


}
