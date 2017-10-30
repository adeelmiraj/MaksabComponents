//
//  MLMLevelDetailsTableViewCell.swift
//  Pods
//
//  Created by Incubasys on 03/10/2017.
//
//

import UIKit
import StylingBoilerPlate

public class MLMLevelDetailsTableViewCell: UITableViewCell, NibLoadableView {

    @IBOutlet weak var badgeImg: UIImageView!
    @IBOutlet weak var labelLevel: UILabel!
    @IBOutlet weak var noOfPeople: UILabel!
    @IBOutlet weak var staticLabelPeople: UILabel!
    @IBOutlet weak var comissionRate: UILabel!
    @IBOutlet weak var earnings: UILabel!
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        hideDefaultSeparator()
        configView()
    }

    
    func configView()  {
        self.backgroundColor = UIColor.appColor(color: .Dark)
        staticLabelPeople.text = "People"
        let bh = BundleHelper(resourceName: Constants.resourceName)
        badgeImg.image = bh.getImageFromMaksabComponent(name: "badge", _class: MLMLevelDetailsTableViewCell.self)
        
    }
    
    override public func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func config(level: Int, peoples: Int, comissionRate: Double, earnings: Double, earningUnit: String = "SAR" )  {
        labelLevel.text = "\(level)"
        noOfPeople.text = "\(peoples)"
        self.comissionRate.text = "Comission Rate: \(round(comissionRate))%"
        self.earnings.text = "Earnings: \(earningUnit) \(earnings)"
        
    }
    
}
