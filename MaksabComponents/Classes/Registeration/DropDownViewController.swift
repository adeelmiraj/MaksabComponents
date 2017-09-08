//
//  DropDownViewController.swift
//  Pods
//
//  Created by Incubasys on 28/08/2017.
//
//

import UIKit

public protocol DropDownDelegate{
    func selectedDropDownItem(index: Int, dropDown: DropDownViewController)
}

public protocol DropDownDataSource {
    func data() -> [String]
    func selectedItemIndex () -> Int
}
open class DropDownViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var tableView: UITableView!
    public var delegate: DropDownDelegate?
    public var dataSource: DropDownDataSource?
    
    let bundle = Bundle(for: DropDownViewController.classForCoder())
    public var data = [String]() {
        didSet{
            guard tableView != nil else {
                return
            }
            tableView.reloadData()
        }
    }
    public var selectedItemIndex: Int = 0{
        didSet{
            guard tableView != nil else {
                return
            }
            tableView.reloadData()
        }
    }
    
    override open func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        guard dataSource != nil else {
            fatalError("dataSource of drop down is not implemented")
        }
        
        configView()
        
        data = dataSource!.data()
        selectedItemIndex = dataSource!.selectedItemIndex()
    }

    open func registerCell()  {
        tableView.register(SimpleTextTableViewCell.self, bundle: bundle)
    }
    
    func configView()  {
        tableView = UITableView(frame: self.view.bounds)
        self.view.addSubview(tableView)
        registerCell()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        tableView.rowHeight = rowHeight()
    }

    //MARk:- tableView dataSource and delegate
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rowCount()
    }
    
    open func rowCount() -> Int {
        return data.count
    }
    
    open func rowHeight() -> CGFloat {
        return 40
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return cell(atIndexPath: indexPath)
    }
    
    open func cell(atIndexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeCell(indexPath: atIndexPath) as SimpleTextTableViewCell
        cell.config(title: data[atIndexPath.row])
        cell.hideSeparator = true
        if atIndexPath.row == selectedItemIndex{
            cell.backgroundColor = UIColor.appColor(color: .Medium)
        }else{
            cell.backgroundColor = UIColor.appColor(color: .Light)
        }
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        refreshSelection(atIndexPath: indexPath)
    }
    
    public func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        refreshSelection(atIndexPath: indexPath)
    }
    
    func refreshSelection(atIndexPath: IndexPath)  {
        guard atIndexPath.row != selectedItemIndex else {
            return
        }
        selectedItemIndex = atIndexPath.row
        tableView.reloadData()
        delegate?.selectedDropDownItem(index: selectedItemIndex, dropDown: self)
    }
}
