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

    @IBOutlet weak public var btnInvite: UIButton!
    @IBOutlet weak public var staticLabelInviteFriends: UILabel!
    var delegate: InviteMoreFriendsTableViewCellDelegate?
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.backgroundColor = UIColor.appColor(color: .Light)
//        btnInvite.tintColor = UIColor.appColor(color: .Light)
//        btnInvite.titleLabel?.font = UIFont.appFont(font: .RubikRegular, pontSize: 15)
        
        let dir = Locale.characterDirection(forLanguage: Locale.current.languageCode ?? "en")
        if dir == .leftToRight {
            let btnleading = NSLayoutConstraint(item: btnInvite, attribute: .leading, relatedBy: .equal, toItem: staticLabelInviteFriends, attribute: .leading, multiplier: 1, constant: 0)
            self.addConstraint(btnleading)
        }else {
            let btntrailing = NSLayoutConstraint(item: btnInvite, attribute: .trailing, relatedBy: .equal, toItem: staticLabelInviteFriends, attribute: .trailing, multiplier: 1, constant: 16)
            self.addConstraint(btntrailing)
        }
//        btnInvite.setTitle(Bundle.localizedStringFor(key: "wallet-cell-invite-btn-title"), for: .normal)
        staticLabelInviteFriends.text = Bundle.localizedStringFor(key: "wallet-cell-invite-more-friends")
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
