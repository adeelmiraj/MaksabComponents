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
        
       configViews(type: registerationViewType)
        
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

    func assests() -> RegisterationAssets {
        return RegisterationAssets(logo:#imageLiteral(resourceName: "logo"), tooltip:#imageLiteral(resourceName: "help") , btnNext: #imageLiteral(resourceName: "arrow-thin-right"), facebook:#imageLiteral(resourceName: "facebook"),twitter: #imageLiteral(resourceName: "twitter"), google: #imageLiteral(resourceName: "google"))
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

