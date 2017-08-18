//
//  TermsAndConditionsViewController.swift
//  MaksabComponents
//
//  Created by Incubasys on 24/07/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit
import MaksabComponents

class TermsAndConditionsViewController: TermsAndConditionsTemplateViewController {

    override func loadView() {
        super.loadView()
        //        let bundle = Bundle(for: type(of: self))
        let bundle = Bundle(for: TermsAndConditionsTemplateViewController.classForCoder())
        guard let view = bundle.loadNibNamed(TermsAndConditionsTemplateViewController.nibName, owner: self, options: nil)?.first as? UIView else {
            fatalError("Nib not found.")
        }
        self.view = view
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()

        let agreeItem = UIBarButtonItem(title: "Agree", style: .plain, target: self, action: #selector(actionAgree))
        let attr = agreeItem.titleTextAttributes(for: .normal)
        print(attr ?? "abc")
        agreeItem.setTitleTextAttributes([NSFontAttributeName: UIFont.boldSystemFont(ofSize: 17)], for: .normal)
        self.navigationItem.rightBarButtonItem = agreeItem
    }
    
    func actionAgree()  {
        
    }

}
