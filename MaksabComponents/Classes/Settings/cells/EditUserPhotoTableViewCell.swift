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

    @IBOutlet weak public var userPhoto: UIImageView!
    @IBOutlet weak public var userName: TitleLabel!
    @IBOutlet weak public var phoneNo: UILabel!
    @IBOutlet weak public var emailId: TextLabel!
    @IBOutlet weak var editIcon: UIImageView!
    
    public var delegate: EditUserPhotoTableViewCellDelegate?
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        configView()
    }

    func configView()  {
        phoneNo.font = UIFont.appFont(font: .RubikRegular, pontSize: 16)
        phoneNo.textColor = UIColor.appColor(color: .DarkText)
        userPhoto.backgroundColor = UIColor.appColor(color: .Medium)
        self.backgroundColor = UIColor.appColor(color: .Light)
        editIcon.backgroundColor = UIColor.clear
        editIcon.setImg(named: "edit-profile", redneringMode: .alwaysTemplate)
        editIcon.tintColor = UIColor.appColor(color: .Light)
        //editIcon.layer.cornerRadius = editIcon.frame.size.height / 2
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(actUserPhotoTapped))
//        userPhoto.addGestureRecognizer(tapGesture)
    }
    
    override public func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func config(userName: String, phone: String, email: String, delegate: EditUserPhotoTableViewCellDelegate)  {
        self.delegate = delegate
        self.userName.text = userName
        phoneNo.text = phone
        emailId.text = email
    }
    
    @IBAction func editPhoto(_ sender: UIButton) {
        delegate?.editImage()
    }
//    func actUserPhotoTapped(){
//        
//    }
    
}
