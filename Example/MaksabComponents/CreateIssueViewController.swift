//
//  CreateIssueViewController.swift
//  MaksabComponents_Example
//
//  Created by Mansoor Ali on 08/11/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit
import StylingBoilerPlate
import MaksabComponents
class CreateIssueViewController: CreateIssueTemplateViewController, CreateIssueDelegate {
    
    var issueId: Int?
    var rideId: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    
    //MARK:- CreateIssueDelegate
    func selectIssue() {
    }
    
    func selectRide() {
    }
    
    func seekHelp() {
        
    }
    
    func configCell(indexPath: IndexPath, cell: SimpleTextTableViewCell) -> SimpleTextTableViewCell{
        return cell
    }
    
}
