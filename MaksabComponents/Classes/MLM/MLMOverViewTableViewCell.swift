//
//  MLMOverViewTableViewCell.swift
//  Pods
//
//  Created by Incubasys on 03/10/2017.
//
//

import UIKit
import StylingBoilerPlate

public protocol  MLMOverViewTableViewCellDelegate {
    func viewMLMTree()
}

public class MLMOverViewTableViewCell: UITableViewCell, NibLoadableView {

    @IBOutlet weak var staticLabelTotalNodes: UILabel!
    @IBOutlet weak var staticLabelTotalEarnings: UILabel!
    @IBOutlet weak var priceUnit: UILabel!
    @IBOutlet weak public var totalNodes: UILabel!
    @IBOutlet weak public var totalEarnings: UILabel!
    @IBOutlet weak public var btnViewMLMTree: UIButton!
    
    var delegate: MLMOverViewTableViewCellDelegate?
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        hideDefaultSeparator()
        configView()
    }

    override public func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configView()  {
        self.backgroundColor = UIColor.appColor(color: .Dark)
        
        staticLabelTotalNodes.text = "Total Nodes"
        staticLabelTotalEarnings.text = "Total Earnings"
        priceUnit.text = "SAR"
        btnViewMLMTree.setTitle("View MLM Tree", for: .normal)
    }
    
    public func config(totalNodes: Int, totalEarnings: Double,delegate: MLMOverViewTableViewCellDelegate){
        self.totalNodes.text = "\(totalNodes)"
        self.totalEarnings.text = String(format: "%.2f", totalEarnings)
        self.delegate = delegate
    }
    
    @IBAction func viewMLMTree(){
        delegate?.viewMLMTree()
    }
}
