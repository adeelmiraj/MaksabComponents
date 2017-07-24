//
//  UICollectionView+UITableView.swift
//  Managin Bundles
//
//  Created by Incubasys on 07/07/2017.
//  Copyright © 2017 Incubasys. All rights reserved.
//

import UIKit

//Pop
public protocol NibLoadableView {}
public protocol ReuseableView {}

public extension NibLoadableView where Self: UIView{
    public static var nibName: String{
        return String(describing: self)
    }
}

public extension NibLoadableView where Self: UIViewController{
    public static var nibName: String{
        return String(describing: self)
    }
}

public extension ReuseableView where Self: UIView{
    public static var reuseId: String{
        return String(describing: self)
    }
}

//Table
extension UITableViewCell:ReuseableView{}

public extension UITableView{
    public func register<T: UITableViewCell>(_ :T.Type) where T:ReuseableView, T: NibLoadableView{
        let nib = UINib(nibName: T.nibName, bundle: .main)
        register(nib, forCellReuseIdentifier: T.reuseId)
    }
    
    public func dequeCell<T: UITableViewCell>(indexPath:IndexPath) -> T where T: ReuseableView  {
        guard  let cell = dequeueReusableCell(withIdentifier: T.reuseId, for: indexPath) as? T else {
            fatalError("Could not deque cell with identifier:\(T.reuseId)")
        }
        return cell
    }
}


//Collection
extension UICollectionViewCell: ReuseableView{}

public extension UICollectionView{
    public func register<T: UICollectionViewCell>(_ :T) where T: ReuseableView, T: NibLoadableView{
        let nib = UINib(nibName: T.nibName, bundle: .main)
        register(nib, forCellWithReuseIdentifier: T.reuseId)
    }
    
    public func dequeCell<T: UICollectionViewCell>(indexPath: IndexPath) -> T where T: ReuseableView {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.reuseId, for: indexPath) as? T else {
            fatalError("Could not deque cell with identifier\(T.reuseId)")
        }
        return cell
    }
}
