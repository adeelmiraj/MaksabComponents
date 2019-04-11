//
//  BundleHelper.swift
//  Pods
//
//  Created by Incubasys on 26/07/2017.
//
//

import Foundation

public struct BundleHelper{
    
    var resourceName = ""
    
    public init(resourceName: String) {
        self.resourceName = resourceName
    }
    
     public func getImageFromMaksabComponent(name: String, _class :AnyClass) -> UIImage {
        let podBundle = Bundle(for: _class)
        if let url = podBundle.url(forResource: resourceName, withExtension: "bundle") {
            let bundle = Bundle(url: url)
            return UIImage(named: name, in: bundle, compatibleWith: nil)!
        }
        return UIImage()
    }
}
