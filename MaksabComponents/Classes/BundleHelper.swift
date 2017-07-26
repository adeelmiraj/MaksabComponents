//
//  BundleHelper.swift
//  Pods
//
//  Created by Incubasys on 26/07/2017.
//
//

import Foundation

class BundleHelper{

    static func getImageFromMaksabComponent(name: String, _class :AnyClass) -> UIImage {
        let podBundle = Bundle(for: _class)
        if let url = podBundle.url(forResource: "MaksabComponents", withExtension: "bundle") {
            let bundle = Bundle(url: url)
            return UIImage(named: name, in: bundle, compatibleWith: nil)!
        }
        return UIImage()
    }
}
