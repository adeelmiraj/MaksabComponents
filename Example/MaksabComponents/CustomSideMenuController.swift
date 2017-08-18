//
//  CustomSideMenuController.swift
//  MaksabComponents
//
//  Created by Incubasys on 25/07/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit
import SideMenuController
import MaksabComponents
import StylingBoilerPlate
import Cosmos

class CustomSideMenuViewController: SideMenuController, StoryBoardLoadableView {
    
    required init?(coder aDecoder: NSCoder) {
        SideMenuController.preferences.drawing.menuButtonImage = UIImage(named: "menu")
        SideMenuController.preferences.drawing.sidePanelPosition = .overCenterPanelLeft
        SideMenuController.preferences.drawing.sidePanelWidth = 245
        SideMenuController.preferences.drawing.centerPanelShadow = true
        SideMenuController.preferences.animating.statusBarBehaviour = .slideAnimation
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let sideMenuTableViewController = SideMenuTableViewController()
        sideMenuTableViewController.dataSource = self
        sideMenuTableViewController.delegate = self
        self.embed(sideViewController: sideMenuTableViewController)
        
        let homeViewController = self.storyboard?.instantiateViewController(withIdentifier: HomeViewController.sceneName)
        self.embed(centerViewController: UINavigationController(rootViewController: homeViewController!))
    }
}

extension CustomSideMenuViewController: SideMenuDataSource, SideMenuDelegate{
    
    func appType() -> AppType{
        return AppType.Rider
    }
    func viewForHeader() -> UIView? {
        let profileView = ProfileView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 109-20))
        return profileView
    }
    
    func sideMenuItems() -> [SideMenuItem] {
        var items = [SideMenuItem]()
        for _ in 0...6{
            let item = SideMenuItem(icon: UIImage(named: "home")!, title: "Home")
            items.append(item)
        }
        return items
    }
    
    func showProfile(){
        
    }
    func showHome(){
        
    }
    
    func showWallet(){
        
    }
    func showHelp(){
        
    }
    func showSettings(/*sideMenu:SideMenuTableViewController*/){
        
    }
    func showInviteFriends(){
        
    }
    
    //For Rider Only
    func showPayment(){
        
    }
    func showMyTrips(){
        
    }
}
