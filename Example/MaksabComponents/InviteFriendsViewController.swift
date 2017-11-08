//
//  InviteFriendsViewController.swift
//  MaksabComponents_Example
//
//  Created by Mansoor Ali on 08/11/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit
import MaksabComponents
import StylingBoilerPlate

class InviteFriendsViewController: InviteFriendsTemplateViewController {
    
    override func loadView() {
        //        let bundle = Bundle(for: type(of: self))
        let bundle = Bundle(for: InviteFriendsTemplateViewController.classForCoder())
        guard let view = bundle.loadNibNamed(InviteFriendsTemplateViewController.nibName, owner: self, options: nil)?.first as? UIView else {
            fatalError("Nib not found.")
        }
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func share()  {
        
    }
}
