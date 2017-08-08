//
//  UserInfoWithTwoBtnsTableViewCell.swift
//  Pods
//
//  Created by Incubasys on 07/08/2017.
//
//

import UIKit
import StylingBoilerPlate

public protocol UserInfoWithTwoBtnsDelegate {
    func actPrimary(sender: PrimaryButton, indexPath: IndexPath)
    func actSecondary(sender: DestructiveButton, indexPath: IndexPath)
}

public class UserInfoWithTwoBtnsTableViewCell: UITableViewCell, NibLoadableView {

    
    @IBOutlet weak public var userPhoto: UIImageView!
    @IBOutlet weak public var userName: TitleLabel!
    @IBOutlet weak public var carName: TextLabel!
    @IBOutlet weak public var price: TextLabel!
    @IBOutlet weak public var ratingView: RatingView!
    @IBOutlet weak var btnPrimary: PrimaryButton!
    @IBOutlet weak var btnSecondary: DestructiveButton!
    
    var delegate: UserInfoWithTwoBtnsDelegate?
    var indexPath: IndexPath?
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.hideDefaultSeparator()
        self.layoutMargins = UIEdgeInsets.zero
        
        btnPrimary.addTarget(self, action: #selector(actionPrimary(sender:)), for: .touchUpInside)
        btnSecondary.addTarget(self, action: #selector(actionSecondary(sender:)), for: .touchUpInside)
        
        btnPrimary.setTitle("Accept", for: .normal)
        btnSecondary.setTitle("Reject", for: .normal)
        
        btnSecondary.backgroundColor = UIColor.appColor(color: .Destructive)
        
        userPhoto.backgroundColor = UIColor.appColor(color: .Medium)
        userPhoto.layer.cornerRadius = userPhoto.frame.size.height / 2
    }

    override public func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func configButtons(btnPrimaryTitle: String, btnSecondaryTitle: String){
        btnPrimary.setTitle(btnPrimaryTitle, for: .normal)
        btnSecondary.setTitle(btnSecondaryTitle, for: .normal)
    }
    
    public func config(indexPath: IndexPath, delegate: UserInfoWithTwoBtnsDelegate)  {
        self.delegate = delegate
        self.indexPath = indexPath
        userName.text = "Mohammed Ali "
        carName.text = "Mercedes S63 AMG"
        price.text = "SAR 40"
        ratingView.rating = 3
        
    }
    
    func actionPrimary(sender: PrimaryButton)  {
        guard let index = indexPath else{
            return
        }
        delegate?.actPrimary(sender: sender, indexPath: index)
    }
    
    func actionSecondary(sender: DestructiveButton)  {
        guard let index = indexPath else{
            return
        }
        delegate?.actSecondary(sender: sender, indexPath: index)
    }
}
