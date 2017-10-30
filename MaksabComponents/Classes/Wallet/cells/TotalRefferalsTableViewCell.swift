//
//  TotalRefferalsTableViewCell.swift
//  Maksab Driver
//
//  Created by Incubasys on 23/08/2017.
//  Copyright © 2017 Incubasys. All rights reserved.
//

import UIKit
import StylingBoilerPlate

public protocol TotalRefferalsTableViewCellDelegate {
    func viewMlmSummary()
}

public class TotalRefferalsTableViewCell: UITableViewCell, NibLoadableView {

    @IBOutlet weak var staticLabelTotalRefferals: UILabel!
    @IBOutlet weak var totalRefferals: UILabel!
    @IBOutlet weak public var btnMlmSummary: UIButton!
    
    var delegate: TotalRefferalsTableViewCellDelegate?
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.backgroundColor = UIColor.appColor(color: .Dark)
        staticLabelTotalRefferals.text = "Total Refferrals"
        btnMlmSummary.setTitle("View MLM Summary", for: .normal)
    }

    override public func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func config(refferals: Int, delegate: TotalRefferalsTableViewCellDelegate)  {
        totalRefferals.text = "\(refferals)"
        self.delegate = delegate
    }
    
    
    @IBAction func actViewMlmSummary(){
        delegate?.viewMlmSummary()
    }
}
