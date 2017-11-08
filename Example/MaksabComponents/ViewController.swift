
import UIKit

import UIKit
import StylingBoilerPlate
import MaksabComponents

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func showNextScene(){
        let createIssueScene = CreateIssueViewController()
        self.navigationController?.pushViewController(createIssueScene, animated: true)
    }
    
    @IBAction func showInviteFriendsScene(){
        let inviteFriendsScene =  InviteFriendsViewController()
        self.navigationController?.pushViewController(inviteFriendsScene, animated: true)
    }
  
}

