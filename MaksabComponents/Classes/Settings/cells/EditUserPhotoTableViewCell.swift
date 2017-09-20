//
//  EditUserPhotoTableViewCell.swift
//  Pods
//
//  Created by Incubasys on 20/09/2017.
//
//

import UIKit
import StylingBoilerPlate

public protocol EditUserPhotoTableViewCellDelegate {
    func editImage()
}

public class EditUserPhotoTableViewCell: UITableViewCell, NibLoadableView {

    @IBOutlet weak var userPhoto: UIImageView!
    @IBOutlet weak var userName: TitleLabel!
    @IBOutlet weak var phoneNo: UILabel!
    @IBOutlet weak var emailId: TextLabel!
    @IBOutlet weak var editIcon: UIImageView!
    
    var delegate: EditUserPhotoTableViewCellDelegate?
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        configView()
    }

    func configView()  {
        phoneNo.font = UIFont.appFont(font: .RubikRegular, pontSize: 16)
        phoneNo.textColor = UIColor.appColor(color: .LightText)
        userPhoto.backgroundColor = UIColor.appColor(color: .Medium)
        self.backgroundColor = UIColor.appColor(color: .Dark)
        editIcon.backgroundColor = UIColor.appColor(color: .Light)
        let bh = BundleHelper(resourceName: Constants.resourceName)
        editIcon.image = bh.getImageFromMaksabComponent(name: "edit-profile", _class: EditUserPhotoTableViewCell.self)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(actUserPhotoTapped))
        userPhoto.addGestureRecognizer(tapGesture)
    }
    
    override public func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func config(delegate: EditUserPhotoTableViewCellDelegate)  {
        self.delegate = delegate
        userName.text = "Abc"
        phoneNo.text = "123456789"
        emailId.text = "abc@gmail.com"
    }
    
    func actUserPhotoTapped(){
        delegate?.editImage()
    }
    
}
