//
//  File.swift
//  MaksabComponents
//
//  Created by Mansoor Ali on 08/11/2017.
//

import Foundation

extension Bundle{
    
    public static func maksabComponentsBundle() -> Bundle{
        return Bundle(for: InviteFriendsTemplateViewController.classForCoder())
    }
    
    public static func maksabComponentsAssetBundle() -> Bundle{
        let bundleResourcePath = Bundle.maksabComponentsBundle().resourcePath!
        let assetPath = bundleResourcePath.appending("/MaksabComponents.bundle")
        return Bundle(path: assetPath)!
    }
    
    static func localizedStringFor(key: String) -> String{
        return NSLocalizedString(key, tableName: "LocalizedStrings", bundle: Bundle.maksabComponentsAssetBundle(), value: "ABC", comment: "Localized string")
    }
}
