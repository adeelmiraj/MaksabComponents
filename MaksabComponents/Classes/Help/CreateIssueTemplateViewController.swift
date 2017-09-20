//
//  CreateIssueTemplateViewController.swift
//  Pods
//
//  Created by Incubasys on 19/09/2017.
//
//

import UIKit
import StylingBoilerPlate
import KMPlaceholderTextView

public protocol CreateIssueDelegate{
    func selectRide()
    func selectIssue()
    func seekHelp()
}

open class CreateIssueTemplateViewController: UIViewController, NibLoadableView, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textView: KMPlaceholderTextView!
    @IBOutlet weak var btnSeekHelp: UIButton!
    
    public var delegate: CreateIssueDelegate?
    
    open override func loadView() {
        let name = CreateIssueTemplateViewController.nibName
        let bundle = Bundle(for: CreateIssueTemplateViewController.classForCoder())
        guard let view = bundle.loadNibNamed(name, owner: self, options: nil)?.first as? UIView else {
            fatalError("Nib not found.")
        }
        self.view = view
    }
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        configView()
    }
    
    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let index = tableView.indexPathForSelectedRow{
            tableView.deselectRow(at: index, animated: false)
        }
    }
    
    func configView()  {
        self.view.backgroundColor = UIColor.appColor(color: .Dark)
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(SimpleTextTableViewCell.self, bundle: Bundle(for: SimpleTextTableViewCell.classForCoder()))
        textView.layer.cornerRadius = 5
        textView.placeholder = "Details"
        btnSeekHelp.setTitle("Seek Help", for: .normal)
    }
    
    //MARK:- tableView
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeCell(indexPath: indexPath) as SimpleTextTableViewCell
        cell.isLight = true
        cell.separatorView.backgroundColor = UIColor.appColor(color: .Dark)
        if indexPath.row == 0{
            cell.config(title: "Select a Ride")
        }else{
            cell.config(title: "Select an Issue")
        }
        let bh = BundleHelper(resourceName: Constants.resourceName)
        cell.addAccessoryView(img: bh.getImageFromMaksabComponent(name: "arrow-left", _class: ExpandableSectionsTemplateViewController.self))
        cell.selectionStyle = .default
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0{
            delegate?.selectRide()
        }else if indexPath.row == 1{
            delegate?.selectIssue()
        }
    }

    //MARK:- Seek Help
    @IBAction func actSeekHelp(){
        delegate?.seekHelp()
    }
}
