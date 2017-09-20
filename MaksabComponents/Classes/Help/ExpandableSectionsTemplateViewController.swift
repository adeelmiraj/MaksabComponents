//
//  ExpandableSectionsViewController.swift
//  Pods
//
//  Created by Incubasys on 19/09/2017.
//
//

import UIKit
import StylingBoilerPlate

public protocol ExpandableSectionsDataSource{
    func sectionsCount() -> Int
    func configHeaderView(view: SimpleTextView, section: Int) -> SimpleTextView
    func configCell(simpleTextCell: SimpleTextTableViewCell, indexPath: IndexPath) -> SimpleTextTableViewCell
    func numberOfRowsForSection(section: Int) -> Int
    
}
open class ExpandableSectionsTemplateViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, SimpleTextViewDelegate {
    
    public var tableView: UITableView!
    var expandedSection: Int = 0
    public var dataSource: ExpandableSectionsDataSource?
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        guard dataSource != nil else {
            fatalError("ExpandableSectionsViewController dataSource not set")
        }
        configView()
        registerCell()
    }
    
    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let index = tableView.indexPathForSelectedRow{
            tableView.deselectRow(at: index, animated: false)
        }
    }
    
    open func configView()  {
        self.view.backgroundColor = UIColor.appColor(color: .Dark)
        let frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height - 64)
        tableView = UITableView(frame: frame)
        self.view.addSubview(tableView)
        
        tableView.backgroundColor = UIColor.appColor(color: .Dark)
        tableView.dataSource = self
        tableView.delegate = self
        let footerView = UIView()
        footerView.backgroundColor = UIColor.appColor(color: .Dark)
        tableView.tableFooterView = footerView
    }
    
    public func registerCell()  {
        tableView.register(SimpleTextTableViewCell.self, bundle: Bundle(for: SimpleTextTableViewCell.classForCoder()))
    }
    
    //MARK:- tableView
    public func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource!.sectionsCount()
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == expandedSection{
            return dataSource!.numberOfRowsForSection(section: section)
        }else{
            return 0
        }
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let simpleTextView = SimpleTextView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 50))
        simpleTextView.delegate = self
        simpleTextView.tag = section
        let bh = BundleHelper(resourceName: Constants.resourceName)
        if expandedSection == section{
            simpleTextView.addLeftView(img: bh.getImageFromMaksabComponent(name: "arrow-down", _class: ExpandableSectionsTemplateViewController.self))
        }else{
            simpleTextView.addLeftView(img: bh.getImageFromMaksabComponent(name: "arrow-up", _class: ExpandableSectionsTemplateViewController.self))
        }
        return dataSource!.configHeaderView(view: simpleTextView, section: section)
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeCell(indexPath: indexPath) as SimpleTextTableViewCell
        cell.isLight = false
        return dataSource!.configCell(simpleTextCell: cell, indexPath: indexPath)
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    //
    func getExpandedSections() -> Int {
        return expandedSection
    }
    
    public func onTapped(tag: Int, view: SimpleTextView) {
        let bh = BundleHelper(resourceName: Constants.resourceName)
        
        if expandedSection == tag{
            expandedSection = -1
        }else{
            expandedSection = tag
        }
        self.tableView.reloadData()
    }
}
