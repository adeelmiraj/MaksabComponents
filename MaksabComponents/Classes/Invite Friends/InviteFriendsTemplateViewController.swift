//
//  InviteFriendsTemplateViewController.swift
//  Pods
//
//  Created by Incubasys on 25/08/2017.
//
//

import UIKit
import StylingBoilerPlate

open class InviteFriendsTemplateViewController: UIViewController, NibLoadableView {

    @IBOutlet weak public var staticLabelInviteFriends: UILabel!
    @IBOutlet weak public var staticLabelInviteCode: UILabel!
    @IBOutlet weak public var inviteFriendImg: UIImageView!
    @IBOutlet weak public var inviteCode: UILabel!
    @IBOutlet weak public var btnShare: UIButton!

    @IBOutlet weak var inviteCodeContainer: UIView!
    override open func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configView()
    }
    
    func configView()  {
        self.view.backgroundColor = UIColor.appColor(color: .Light)
        inviteFriendImg.setImg(named: "invite")
        staticLabelInviteCode.text = Bundle.localizedStringFor(key: "invite-friend-invite-code")
        staticLabelInviteFriends.text = Bundle.localizedStringFor(key: "invite-friend-msg")
        btnShare.setTitle(Bundle.localizedStringFor(key:"invite-friend-btn-share"), for: .normal)
        
        inviteCodeContainer.layer.borderWidth = 1
        inviteCodeContainer.layer.borderColor = UIColor.appColor(color: .Dark).cgColor
    }

    public func setInviteCode(code: String){
        inviteCode.text = code
    }
}
