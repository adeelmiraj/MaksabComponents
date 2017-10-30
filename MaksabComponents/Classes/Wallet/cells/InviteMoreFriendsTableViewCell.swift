//
//  InviteMoreFriendsTableViewCell.swift
//  Maksab Driver
//
//  Created by Incubasys on 23/08/2017.
//  Copyright © 2017 Incubasys. All rights reserved.
//

import UIKit
import StylingBoilerPlate

public protocol InviteMoreFriendsTableViewCellDelegate {
    func inviteFriend()
}

public class InviteMoreFriendsTableViewCell: UITableViewCell, NibLoadableView {

    @IBOutlet weak var btnInvite: UIButton!
    @IBOutlet weak var staticLabelInviteFriends: UILabel!
    var delegate: InviteMoreFriendsTableViewCellDelegate?
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.backgroundColor = UIColor.appColor(color: .Dark)
        staticLabelInviteFriends.text = "            more friends to Earn more."
//        commission
        btnInvite.tintColor = UIColor.appColor(color: .Secondary)
        btnInvite.setTitle("Invite", for: .normal)
        btnInvite.titleLabel?.font = UIFont.appFont(font: .RubikRegular, pontSize: 15)
    }

    override public func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func config(delegate: InviteMoreFriendsTableViewCellDelegate)  {
        self.delegate = delegate
        
    }
    
    @IBAction func actInvite(){
        delegate?.inviteFriend()
    }
}
