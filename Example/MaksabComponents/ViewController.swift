//
//  ViewController.swift
//  MaksabComponents
//
//  Created by zainincubasys on 07/19/2017.
//  Copyright (c) 2017 zainincubasys. All rights reserved.
//

import UIKit
import MaksabComponents

class ViewController: RegisterationTemplateViewController, RegisterationTemplateViewControllerDataSource, RegisterationTemplateViewControllerDelegate {

    var registerationViewType = RegisterationViewType.PhoneNumber
    
    override open func loadView() {
        let name = "RegisterationTemplateViewController"
//        let bundle = Bundle(for: type(of: self))
        let bundle = Bundle(for: RegisterationTemplateViewController.classForCoder())
        guard let view = bundle.loadNibNamed(name, owner: self, options: nil)?.first as? UIView else {
            fatalError("Nib not found.")
        }
        self.view = view
        dataSource = self
        delegate = self
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        switch registerationViewType {
        case .PhoneNumber:
            fieldSecond.placeholder = "Enter Phone Number"
        case .VerificationCode:
            labelTitle.text = "Verification Code"
            fieldSecond.placeholder = "Enter here"
        case .NameAndEmail:
            labelTitle.text = "Name & Email"
            fieldFirst.placeholder = "Name"
            fieldSecond.placeholder = "Email"
        case.Password:
            labelTitle.text = "Password"
            fieldSecond.placeholder = "Password"
        case .PasswordAndConfirmPassword:
            labelTitle.text = "Password"
            fieldFirst.placeholder = "Password"
            fieldSecond.placeholder = "Confirm Password"
        case .InviteCode:
            labelTitle.text = "Invite Code"
            labelSubtitle.text = "Enter Invite Code and earn 25% Discount on first ride"
            fieldSecond.placeholder = "Invite Code"
        }
//        switch registerationViewType {
//        case .PhoneNumber:
//            congfigFields(title: "", subtitle: "", firstField: ["Enter Phone Number",""], secondField: [], actionButtonTitle: "", actionButtonImage: nil, showToolTip: false)
//        case .VerificationCode:
//            
//        default:
//            print("default")
//        }
    
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        let vc = RegisterationTemplateViewController.createController(_for: .PhoneNumber)
//        vc.dataSource = self
//        self.present(vc, animated: true, completion: nil)
    }
    
    func viewType() -> RegisterationViewType{
        return registerationViewType
    }

    //required
    func actionNext(sender: UIButton) {
        let vc = ViewController()
        if registerationViewType == .InviteCode{
            print("Show Home")
            return
        }
        let type = registerationViewType.next()!
        
        vc.registerationViewType = type
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }

}

