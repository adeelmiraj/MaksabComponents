//
//  File.swift
//  Pods
//
//  Created by Incubasys on 09/08/2017.
//
//

import UIKit
import StylingBoilerPlate

public protocol ScheduledRideViewDelegate{
    func addScheduleRide(date: Date, daysSelected: [DayInfo])
}

public struct DayInfo {
    let title: String
    let day: Day
    var isSelected: Bool
    
    init(title: String, day: Day, isSelected: Bool) {
        self.title = title
        self.day = day
        self.isSelected = isSelected
    }
    
    static func getDaysArray() -> [DayInfo] {
        let arr = ["Sunday","Monday","Tuesday","Thursday","Friday","Saturday"]
        var daysArray = [DayInfo]()
        for i in 0..<arr.count {
            let dayInfo = DayInfo(title:arr[i], day: Day(rawValue: i)!, isSelected: false)
            daysArray.append(dayInfo)
        }
        return daysArray
    }
}

public enum Day: Int{
    case Sun = 0
    case Mon = 1
    case Tue = 2
    case Wed = 3
    case Thu = 4
    case Fri = 5
    case Sat = 6
}

public class ScheduledRideView: UIView, CustomView, NibLoadableView, SlidableView{
    
    
    public static let heightForFirstSegment: CGFloat = 311
    //323
    public static let heightForSecondSegment: CGFloat = UIScreen.main.bounds.height - 64
    
    let bundle = Bundle(for: ScheduledRideView.classForCoder())
    
    @IBOutlet weak public var datePicker: UIDatePicker!
    @IBOutlet weak public var segmentedControl: BorderLessSegmentedControl!
    @IBOutlet weak var btnDone: UIButton!
    @IBOutlet weak var separatorView: UIView!
    
    var contentView: UIView!
    var delegate: ScheduledRideViewDelegate?
    var templateView: RidesActionViewTemplate!
    
    var tableView: UITableView!
    var tableSectionHeaderView: UIView!
    
    var daysArray = DayInfo.getDaysArray()
    let bh = BundleHelper(resourceName: Constants.resourceName)
    
    static public func createInstance(x: CGFloat, y: CGFloat = UIScreen.main.bounds.height - ScheduledRideView.heightForFirstSegment, width: CGFloat, delegate: ScheduledRideViewDelegate) -> ScheduledRideView{
        let inst = ScheduledRideView(frame: CGRect(x: x, y: y, width: width, height: ScheduledRideView.heightForFirstSegment))
        inst.delegate = delegate
        return inst
    }
    
    
    public override required init(frame: CGRect) {
        super.init(frame: frame)
        contentView = commonInit(bundle: bundle)
        configView()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        contentView = commonInit(bundle: bundle)
        configView()
    }
    
    public func commonInit(bundle: Bundle) -> UIView {
        let nib = bundle.loadNibNamed(ScheduledRideView.nibName, owner: self, options: nil)
        let tempView = nib?.first as? UIView
        guard (tempView) != nil else {
            fatalError("unable to load custom view")
        }
        tempView!.frame = self.bounds
        tempView!.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        self.addSubview(tempView!)
        return tempView!
    }
    
    func configView()  {
        tableView = UITableView(frame: CGRect(x: 0, y: 234, width: self.frame.size.width, height: 0))
        tableView.tableFooterView = UIView()
        self.addSubview(tableView)
        self.bringSubview(toFront: separatorView)
        
        tableView.register(SimpleTextTableViewCell.self, bundle: bundle)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 44
        tableView.sectionHeaderHeight = 52
        tableView.allowsMultipleSelection = true
        creatTableSectionHeaderView()
        
        btnDone.setTitle("Done", for: .normal)
        
        segmentedControl.setTitle("One Time", forSegmentAt: 0)
        segmentedControl.setTitle("Recurring", forSegmentAt: 1)
        
        let calendar = Calendar.current
        datePicker.date = calendar.date(byAdding: .minute, value: 15, to: Date())!
        datePicker.minimumDate = datePicker.date
        
        hide(animated: false)
    }
    
    func creatTableSectionHeaderView()  {
        tableSectionHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: 52))
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: 52))
        label.textAlignment = .center
        label.text = "Start date and ride time"
        label.font = UIFont.appFont(font: .RubikMedium, pontSize: 16)
        tableSectionHeaderView.addSubview(label)
        let view = UIView(frame: CGRect(x: 0, y: 51, width: self.frame.size.width, height: 1))
        view.backgroundColor = UIColor(netHex: 0x535353)
        tableSectionHeaderView.addSubview(view)
    }
    
    @IBAction func actSegmentChanged(_ sender: BorderLessSegmentedControl) {
        
        var frame: CGRect!
        let btnFrame: CGRect!
        let tableFrame: CGRect!
        let changeInHeight = ScheduledRideView.heightForSecondSegment - ScheduledRideView.heightForFirstSegment
        let separatorViewAlpha: CGFloat!
        if sender.selectedSegmentIndex == 0{
            frame = CGRect(x: self.frame.origin.x, y: UIScreen.main.bounds.height - ScheduledRideView.heightForFirstSegment, width: self.frame.width, height: ScheduledRideView.heightForFirstSegment)
            
            let tableHeight = tableView.frame.size.height - changeInHeight
            tableFrame = CGRect(x: tableView.frame.origin.x, y: tableView.frame.origin.y, width: tableView.frame.size.width, height: tableHeight)
            
            let y = btnDone.frame.origin.y - changeInHeight
            btnFrame = CGRect(x: btnDone.frame.origin.x, y: y, width: 290, height: 48)
            
            separatorViewAlpha = 0
            
        }else{
            frame = CGRect(x: self.frame.origin.x, y: UIScreen.main.bounds.height - ScheduledRideView.heightForSecondSegment, width: self.frame.width, height: ScheduledRideView.heightForSecondSegment)
            
            let tableHeight = tableView.frame.size.height + changeInHeight
            tableFrame = CGRect(x: tableView.frame.origin.x, y: tableView.frame.origin.y, width: tableView.frame.size.width, height: tableHeight)
            
            let y = btnDone.frame.origin.y + changeInHeight
            btnFrame = CGRect(x: btnDone.frame.origin.x, y: y, width: 290, height: 48)
            
            separatorViewAlpha = 1
        }
        
        //        self.tableContainerView.frame = CGRect(x: 0, y: self.tableContainerView.frame.origin.y, width: self.tableContainerView.frame.size.width, height: height)
        
        
        UIView.animate(withDuration: 0.5) {
            self.tableView.frame = tableFrame
            self.frame = frame
            self.btnDone.frame = btnFrame
            self.separatorView.alpha = separatorViewAlpha
        }
        
    }

    
    @IBAction func actDone(_ sender: PrimaryButton) {
        var daysSelected = [DayInfo]()
        for dayInfo in daysArray{
            if dayInfo.isSelected{
                daysSelected.append(dayInfo)
            }
        }
        delegate?.addScheduleRide(date: datePicker.date, daysSelected: daysSelected)
    }
    
}

extension ScheduledRideView: UITableViewDataSource, UITableViewDelegate{
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return daysArray.count
    }
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return tableSectionHeaderView
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeCell(indexPath: indexPath) as SimpleTextTableViewCell
        let dayInfo = daysArray[indexPath.row]
        cell.config(dayInfo: dayInfo)
        
        if dayInfo.isSelected{
            let img = bh.getImageFromMaksabComponent(name: "checkmark", _class: ScheduledRideView.self)
            cell.addAccessoryView(img: img.imageWithColor(color1: UIColor.appColor(color: .Secondary)))
        }else{
            cell.removeAccessoryView()
        }
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        toggleCellSelection(indexPath: indexPath)
    }
    
    public func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        toggleCellSelection(indexPath: indexPath)
    }
    
    func toggleCellSelection(indexPath: IndexPath)  {
        let cell = tableView.cellForRow(at: indexPath) as? SimpleTextTableViewCell
        daysArray[indexPath.row].isSelected = !daysArray[indexPath.row].isSelected
        if daysArray[indexPath.row].isSelected{
            let img = bh.getImageFromMaksabComponent(name: "checkmark", _class: ScheduledRideView.self)
            cell?.addAccessoryView(img: img.imageWithColor(color1: UIColor.appColor(color: .Secondary)))
        }else{
            cell?.removeAccessoryView()
        }
    }
}
