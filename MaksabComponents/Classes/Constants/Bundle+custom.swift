//
//  File.swift
//  MaksabComponents
//
//  Created by Mansoor Ali on 08/11/2017.
//

import Foundation

extension Bundle{
    
//    + (NSBundle *)jsq_messagesBundle
//    {
//    return [NSBundle bundleForClass:[JSQMessagesViewController class]];
//    }
//
//    + (NSBundle *)jsq_messagesAssetBundle
//    {
//    NSString *bundleResourcePath = [NSBundle jsq_messagesBundle].resourcePath;
//    NSString *assetPath = [bundleResourcePath stringByAppendingPathComponent:@"JSQMessagesAssets.bundle"];
//    return [NSBundle bundleWithPath:assetPath];
//    }
//
//    + (NSString *)jsq_localizedStringForKey:(NSString *)key
//    {
//    return NSLocalizedStringFromTableInBundle(key, @"JSQMessages", [NSBundle jsq_messagesAssetBundle], nil);
//    }
    
    static func maksabComponentsBundle() -> Bundle{
        return Bundle(for: InviteFriendsTemplateViewController.classForCoder())
    }
    
    static func maksabComponentsAssetBundle() -> Bundle{
        let bundleResourcePath = Bundle.maksabComponentsBundle().resourcePath!
        let assetPath = bundleResourcePath.appending("/MaksabComponents.bundle")
        return Bundle(path: assetPath)!
    }
    
    static func localizedStringFor(key: String) -> String{
        return NSLocalizedString(key, tableName: "LocalizedStrings", bundle: Bundle.maksabComponentsAssetBundle(), value: "ABC", comment: "Localized string")
    }
}
