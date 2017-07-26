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
//        let name = "RegisterationTemplateViewController"
//        let bundle = Bundle(for: type(of: self))
        let bundle = Bundle(for: RegisterationTemplateViewController.classForCoder())
        guard let view = bundle.loadNibNamed(RegisterationTemplateViewController.nibName, owner: self, options: nil)?.first as? UIView else {
            fatalError("Nib not found.")
        }
        self.view = view
        dataSource = self
        delegate = self
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
       configViews(type: registerationViewType)
    
        if registerationViewType == .VerificationCode{
            configPrimaryButton(image: #imageLiteral(resourceName: "resend"))
        }else if registerationViewType == .InviteCode || registerationViewType == .NameAndEmail{
            configPrimaryButton(image: #imageLiteral(resourceName: "skip"))
        }else if registerationViewType == .Password || registerationViewType == .ForgotPassword{
            configPrimaryButton(image: #imageLiteral(resourceName: "help"))
        }
    }

    
    func viewType() -> RegisterationViewType{
        return registerationViewType
    }

    func assests() -> RegisterationAssets {
        return RegisterationAssets(logo:#imageLiteral(resourceName: "logo"), tooltip:#imageLiteral(resourceName: "help") , btnNext: #imageLiteral(resourceName: "arrow-thin-right"), facebook:#imageLiteral(resourceName: "facebook"),twitter: #imageLiteral(resourceName: "twitter"), google: #imageLiteral(resourceName: "google"))
    }
    
    //required
    func actionNext(sender: UIButton) {
        let customSideMenu = self.storyboard?.instantiateViewController(withIdentifier: CustomSideMenuViewController.sceneName)
        UIApplication.shared.windows.first?.rootViewController = customSideMenu!
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
    
//    func showHome()  {
//        let homeController = self.storyboard?.instantiateViewController(withIdentifier: HomeViewController.sceneName)
//        let rootNavController = RootNavigationViewController(rootViewController: homeController!)
////        sideMenuTableViewController.dataSource = rootNavController
////        sideMenuTableViewController.delegate = rootNavController
//        UIApplication.shared.windows.first?.rootViewController = rootNavController
//  
//    }

}

