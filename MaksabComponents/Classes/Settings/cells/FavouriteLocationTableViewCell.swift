//
//  FavouriteLocationTableViewCell.swift
//  Pods
//
//  Created by Incubasys on 20/09/2017.
//
//

import UIKit
import StylingBoilerPlate
public class FavouriteLocationTableViewCell: UITableViewCell, NibLoadableView {

    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var locationTitle: TitleLabel!
    @IBOutlet weak var address: TextLabel!
    @IBOutlet weak public var leftImageView: UIImageView!
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        configView()
        hideDefaultSeparator()
    }

    func configView()  {
        leftImageView.tintColor = UIColor.appColor(color: .Dark)
        icon.tintColor = UIColor.appColor(color: .Dark)
        self.backgroundColor = UIColor.appColor(color: .Light)
        locationTitle.minimumScaleFactor = 0.7
        locationTitle.adjustsFontSizeToFitWidth = true
    }
    
    override public func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func config(icon: UIImage, title: String, address: String){
        self.icon.image = icon
        self.locationTitle.text = title
        self.address.text = address
    }
    
    public func hideAccessoryView()  {
        leftImageView.isHidden = true
    }
    
}
