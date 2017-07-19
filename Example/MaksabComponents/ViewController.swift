//
//  ViewController.swift
//  MaksabComponents
//
//  Created by zainincubasys on 07/19/2017.
//  Copyright (c) 2017 zainincubasys. All rights reserved.
//

import UIKit
import MaksabComponents

class ViewController: UIViewController, RegisterationTemplateViewControllerDataSource  {

    override public func viewDidLoad() {
        super.viewDidLoad()
       
//        let podBundle = Bundle(for: RegisterationTemplateViewController.classForCoder())
//        print(podBundle.bundlePath)
//        let podBundle = Bundle(for:UIViewController.self)
//        if let bundleURL = podBundle.url(forResource: "MaksabComponents", withExtension: "bundle") {
//            if let bundle = Bundle(url: bundleURL) {
//                let cellNib = UINib(nibName: "RegisterationTemplateViewController", bundle: bundle)
//                
//            } else {
//                assertionFailure("Could not load the bundle")
//            }
//        } else {
//            assertionFailure("Could not create a path to the bundle")
//        }
//        let vc = RegisterationTemplateViewController.createController(for: .PhoneNumber)
//        let vc = RegisterationTemplateViewController.secondWay(viewController: self)
//        let vc = RegisterationTemplateViewController()
//        let vc = AlertViewController()
//        let nv = UINavigationController(rootViewController: vc)
//        self.present(nv, animated: true, completion: nil)
    
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let vc = RegisterationTemplateViewController.createController(_for: .PhoneNumber)
        vc.dataSource = self
        self.present(vc, animated: true, completion: nil)
    }
    
    func viewType() -> RegisterationViewType{
        return RegisterationViewType.Password
        
    }


}

