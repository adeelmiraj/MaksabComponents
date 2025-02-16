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
    @IBOutlet weak public var textView: KMPlaceholderTextView!
    @IBOutlet weak public var btnSeekHelp: UIButton!
    
    public var delegate: CreateIssueDelegate?
    public var showSelectRide: Bool = true
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    let bundle = Bundle(for: CreateIssueTemplateViewController.classForCoder())
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
        self.view.backgroundColor = UIColor.appColor(color: .Light)
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(SimpleTextTableViewCell.self, bundle: Bundle(for: SimpleTextTableViewCell.classForCoder()))
        if !showSelectRide{
            tableViewHeight.constant = 50
        }
        textView.layer.cornerRadius = 5
        textView.placeholder = Bundle.localizedStringFor(key: "help-details")
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.appColor(color: .Dark).cgColor
        textView.textColor = UIColor.appColor(color: .DarkText)
        btnSeekHelp.setTitle(Bundle.localizedStringFor(key: "help-btn-seek-help"), for: .normal)
    }
    
    //MARK:- tableView
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if showSelectRide{
            return 2
        }else {
            return 1
        }
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeCell(indexPath: indexPath) as SimpleTextTableViewCell
        cell.isLight = true
        cell.selectionStyle = .default
        if indexPath.row == 0 && showSelectRide{
            cell.config(title: Bundle.localizedStringFor(key: "help-cell-select-ride"))
        }else{
            cell.config(title: Bundle.localizedStringFor(key: "help-cell-select-issue"))
        }
        cell.addAccessoryView(img: UIImage.localizedImage(named: "arrow-right"))
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if showSelectRide && indexPath.row == 0{
            delegate?.selectRide()
        }else{
            delegate?.selectIssue()
        }
    }

    //MARK:- Seek Help
    @IBAction func actSeekHelp(){
        delegate?.seekHelp()
    }
}
