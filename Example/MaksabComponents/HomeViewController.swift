//
//  HomeViewController.swift
//  MaksabComponents
//
//  Created by Incubasys on 25/07/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit
import StylingBoilerPlate

class HomeViewController: UIViewController,StoryBoardLoadableView, ServiceResponseViewDelegate {

    var lv: LoadingBackgroundView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        lv = self.view as! LoadingBackgroundView
        
        lv.addServiceReponseView(delegate: self, top: 64, bottom: 0)
        lv.showReponseView(title: "Error!", msg: "abc", img: nil, hideRetryBtn: false)
        
        let item = UIBarButtonItem(title: "hide", style: .plain, target: self, action: #selector(hideLoading))
        let item2 = UIBarButtonItem(title: "show", style: .plain, target: self, action: #selector(showLoading))
        self.navigationItem.rightBarButtonItems = [item2,item]
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        lv.hideLoadingOrMessageView()
    }
    
    func showLoading()  {
        lv.showLoading(toView: self.view, msg: "Loading Data")
    }

    func hideLoading()  {
        lv.hideLoadingOrMessageView()
    }
    
    func actionRetry() {
        lv.hideLoadingOrMessageView()
        self.showLoading()
    }
    
//    static func setAsRoot()  {
//        let storyBoard = UIStoryboard(name: "Main", bundle: .main)
//        let homeScene = storyBoard.instantiateViewController(withIdentifier: HomeViewController.sceneName)
//        let rootNavViewController = RootNavigationViewController(rootViewController: homeScene)
//        UIApplication.shared.keyWindow?.rootViewController = rootNavViewController
//        UIApplication.shared.keyWindow?.makeKeyAndVisible()
//    }

//    func showMenu()  {
//        let sideMenuTableViewController = SideMenuTemplateTableViewController()
//        let sideMenuNavController = UISideMenuNavigationController(rootViewController: sideMenuTableViewController)
////        sideMenuNavController.isNavigationBarHidden = false
//        sideMenuNavController.leftSide = true
////        sideMenuNavController.automaticallyAdjustsScrollViewInsets = false
//        self.navigationController?.present(sideMenuNavController, animated: true, completion: nil)
//    }

}
