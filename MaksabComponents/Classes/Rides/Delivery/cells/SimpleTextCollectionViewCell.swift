//
//  SimpleTextCollectionViewCell.swift
//  Pods
//
//  Created by Incubasys on 12/08/2017.
//
//

import UIKit
import StylingBoilerPlate

class SimpleTextCollectionViewCell: UICollectionViewCell, NibLoadableView {

    @IBOutlet weak public var labelTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
