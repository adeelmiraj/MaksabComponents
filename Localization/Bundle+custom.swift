//
//  File.swift
//  MaksabComponents
//
//  Created by Mansoor Ali on 08/11/2017.
//

import Foundation
//+ (NSBundle *)jsq_messagesBundle
//    {
//        return [NSBundle bundleForClass:[JSQMessagesViewController class]];
//    }
//
//    + (NSBundle *)jsq_messagesAssetBundle
//        {
//            NSString *bundleResourcePath = [NSBundle jsq_messagesBundle].resourcePath;
//            NSString *assetPath = [bundleResourcePath stringByAppendingPathComponent:@"JSQMessagesAssets.bundle"];
//            return [NSBundle bundleWithPath:assetPath];
//        }
//
//        + (NSString *)jsq_localizedStringForKey:(NSString *)key
//{
//    return NSLocalizedStringFromTableInBundle(key, @"JSQMessages", [NSBundle jsq_messagesAssetBundle], nil);
//}

extension Bundle{
    static func maksabComponentsBundle() -> Bundle {
        return Bundle(for: InviteFriendsTemplateViewController.classForCoder())
    }
    
    static func maksabComponentsAssetBundle() -> Bundle {
        let bundleReqourcePath = Bundle.maksabComponentsBundle().resourcePath
        let assetPath = bundleReqourcePath!.appending("/MaksabComponents.bundle")
        return Bundle(path: assetPath)!
    }
    
    static func localizedStringForKey(key: String) -> String {
        return NSLocalizedString(key, tableName: "LocalizedStrings", bundle: Bundle.maksabComponentsAssetBundle(), comment: "comment for localized string")
    }
}
