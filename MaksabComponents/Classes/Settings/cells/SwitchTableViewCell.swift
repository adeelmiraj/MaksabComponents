//
//  SwitchTableViewCell.swift
//  Pods
//
//  Created by Incubasys on 24/08/2017.
//
//

import UIKit
import StylingBoilerPlate

public protocol ToggleableSetting{
    var title: String{get set}
    var isOn: Bool{get set}
}

public protocol SwitchTableViewCellDelegate {
    func settingToggled(state: Bool, atIndexPath: IndexPath)
}

public class SwitchTableViewCell: UITableViewCell, NibLoadableView {

    @IBOutlet public weak var labelTitle: UILabel!
    @IBOutlet public weak var switchOption: UISwitch!
   
    public var delegate: SwitchTableViewCellDelegate?
    public var indexPath: IndexPath?
    
    public var isLight: Bool = true{
        didSet{
            if isLight{
                self.backgroundColor = UIColor.appColor(color: .Light)
                labelTitle.textColor = UIColor.appColor(color: .DarkText)
            }else{
                self.backgroundColor = UIColor.appColor(color: .Dark)
                labelTitle.textColor = UIColor.appColor(color: .LightText)
            }
        }
    }
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        layoutMargins = UIEdgeInsets.zero
        hideDefaultSeparator()
    }

    override public func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func config<T>(_ setting:T, delegate: SwitchTableViewCellDelegate, indexPath: IndexPath) where T:ToggleableSetting {
        self.delegate = delegate
        self.indexPath = indexPath
        labelTitle.text = setting.title
        switchOption.isOn = setting.isOn
    }
    
    @IBAction func actSwitchStateChanged(_ sender: UISwitch) {
        guard let index = indexPath else {
            return
        }
        delegate?.settingToggled(state: sender.isOn, atIndexPath: index)
    }
    
}
