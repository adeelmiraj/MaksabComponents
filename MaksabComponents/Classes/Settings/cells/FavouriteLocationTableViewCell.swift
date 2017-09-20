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
    @IBOutlet weak var leftImageView: UIImageView!
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        configView()
        hideDefaultSeparator()
    }

    func configView()  {
        let bh = BundleHelper(resourceName: Constants.resourceName)
        leftImageView.tintColor = UIColor.appColor(color: .Light)
        leftImageView.image = bh.getImageFromMaksabComponent(name: "arrow-left", _class: FavouriteLocationTableViewCell.self).withRenderingMode(.alwaysTemplate)
        icon.tintColor = UIColor.appColor(color: .Light)
        self.backgroundColor = UIColor.appColor(color: .Dark)
    }
    
    override public func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func config(icon: UIImage, title: String){
        self.icon.image = icon
        self.locationTitle.text = title
        address.text = "Riyadh"
    }
    
}
