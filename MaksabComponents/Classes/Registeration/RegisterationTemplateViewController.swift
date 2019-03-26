//
//  RegisterationTemplateViewController.swift
//  Pods
//
//  Created by Incubasys on 19/07/2017.
//
//

import UIKit
import StylingBoilerPlate

public enum RegisterationViewType: Int {
    case PhoneNumber = 0
    case VerificationCode = 1
    case NameAndEmail = 2
    case Password = 3
    case PasswordAndConfirmPassword = 4
    case InviteCode = 5
    case ForgotPassword = 6
    case BasicInfo = 7
    case AddVehicleDetails = 8
    case ResetPassUsingPhone = 9
    
    public func next() -> RegisterationViewType? {
        return RegisterationViewType(rawValue: self.rawValue+1)
    }
}

public struct RegisterationAssets {
    var _logo:UIImage
    var _tooltip: UIImage?
    var _btnNext: UIImage
    var _facebook: UIImage?
    var _twitter: UIImage?
    var _google: UIImage?
    
    public init(logo:UIImage, tooltip:UIImage?, btnNext: UIImage, facebook:UIImage?,twitter:UIImage?, google:UIImage?) {
        _logo = logo
        _tooltip = tooltip
        _btnNext = btnNext
        _facebook = facebook
        _twitter = twitter
        _google = google
    }
}

/*
public struct EmailOrPhoneAsset {
    public let isResetUsingEmail: Bool
    public let emailorPhone: String
    init(isResetUsingEmail: Bool, emailorPhone: String) {
        self.isResetUsingEmail = isResetUsingEmail
        self.emailorPhone = emailorPhone
    }
}*/

public struct ResetPassUsingPhoneAsset {
    public let pass: String
    public let confirmPass: String
    public let verificationCode: String
    init(pass: String, confirmPass: String, verificationCode: String) {
        self.pass = pass
        self.confirmPass = confirmPass
        self.verificationCode = verificationCode
    }
}

public struct BasicInfo{
    public var name: String
    public var email: String?
    public var city: String
    public var isSaudiNational: Bool
	public var selectedGenderIndex: Int
	public var dateOfBirth: Date
	public var iqamaOrSaudiId: String
	public var isHijriDob: Bool

	init() {
		name = ""
		email = nil
		city = ""
		isSaudiNational = true
		selectedGenderIndex = 0
		dateOfBirth = Date()
		iqamaOrSaudiId = ""
		isHijriDob = true
	}
}

public struct VehicleDetails{
    public var make: String
    public var model: String
    public var year: Int
	public var plateType: Int
    public var licensePlate: String
	public var sequenceNo: String
    public var selectedCapacityIndex: Int

	init() {
		make = ""
		model = ""
		year = 0
		plateType = 0
		licensePlate = ""
		sequenceNo = ""
		selectedCapacityIndex = 0
	}
}

public protocol RegisterationTemplateViewControllerDataSource{
    func viewType() -> RegisterationViewType
    func assests() -> RegisterationAssets
}

@objc public protocol RegisterationTemplateViewControllerDelegate{
    func actionNext(sender: UIButton)
    @objc optional func actionPrimary(sender: UIButton)
    @objc optional func actionGoogleLogin(sender: UIButton)
    @objc optional func actionFacbookLogin(sender: UIButton)
    @objc optional func actionTwitterLogin(sender: UIButton)
    @objc optional func actionTooltipBottom(sender: UIButton)
    @objc optional func actionTooltipTop(sender: UIButton)
    @objc optional func actionBackToSignup(sender: UIButton)
    @objc optional func showCitiesList()
}

open class RegisterationTemplateViewController: UIViewController, NibLoadableView {
    
    //    override open func loadView() {
    //        let name = "RegisterationTemplateViewController"
    //        let bundle = Bundle(for: type(of: self))
    //        guard let view = bundle.loadNibNamed(name, owner: self, options: nil)?.first as? UIView else {
    //            fatalError("Nib not found.")
    //        }
    //        self.view = view
    //    }
    //
    static public let minValidYear = 1997
    public var dataSource: RegisterationTemplateViewControllerDataSource!
    public var delegate: RegisterationTemplateViewControllerDelegate?
    
    
    @IBOutlet weak var socialLoginsView: UIView!
    @IBOutlet weak var fieldsView: UIView!
    @IBOutlet weak var logoView: UIView!
    
    @IBOutlet weak public var logo: UIImageView!
    @IBOutlet weak public var orLoginWithLabel: UILabel!
    //Fields View
    @IBOutlet weak var phoneCodeWidth: NSLayoutConstraint!
    @IBOutlet weak var fieldSecondLeading: NSLayoutConstraint!
    @IBOutlet weak var firstFieldHeight: NSLayoutConstraint!
    @IBOutlet weak var thirdFieldHeight: NSLayoutConstraint!
    @IBOutlet weak var fourthFieldHeight: NSLayoutConstraint!
    @IBOutlet weak var fifthFieldHeight: NSLayoutConstraint!
	@IBOutlet weak var sixthFieldHeight: NSLayoutConstraint!
	@IBOutlet weak var seventhFieldHeight: NSLayoutConstraint!
    @IBOutlet weak var stackViewHeight: NSLayoutConstraint!
    @IBOutlet weak var stackViewReqHeight: NSLayoutConstraint!
    @IBOutlet weak var subtitleHeight: NSLayoutConstraint!
    @IBOutlet weak var titleViewHeight: NSLayoutConstraint!
    @IBOutlet weak var actionButtonHeight: NSLayoutConstraint!
    @IBOutlet weak var driverNationalityViewHeight: NSLayoutConstraint!
    @IBOutlet weak var vehicleRegisterationContainerHeight: NSLayoutConstraint!
    
    @IBOutlet weak public var labelTitle: HeadlineLabel!
    @IBOutlet weak public var labelSubtitle: CaptionLabel!
    @IBOutlet weak var btnTooltip: UIButton!
    @IBOutlet weak var fieldPhoneCode: BottomBorderTextField!
    @IBOutlet weak public var fieldFirst: BottomBorderTextField!
    @IBOutlet weak public var fieldSecond: BottomBorderTextField!
    @IBOutlet weak public var fieldThird: BottomBorderTextField!
    @IBOutlet weak public var fieldFourth: BottomBorderTextField!
    @IBOutlet weak public var fieldFifth: BottomBorderTextField!
	@IBOutlet weak public var fieldSixth: BottomBorderTextField!
	@IBOutlet weak public var fieldSeventh: BottomBorderTextField!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var btnAction: UIButton!
    
    @IBOutlet weak var btnBackToSigup: UIButton!
    @IBOutlet weak var driverNationalitySwitch: UISwitch!
    @IBOutlet weak var labelDriverNationality: UILabel!
    @IBOutlet weak var driverNationalityView: UIView!
    public var vehicleRegisterationView: VehicleRegisterationView!
    @IBOutlet weak var vehicleRegisterationContainerView: UIView!
	var genderPickerView: UIPickerView?
	var plateTypePickerView: UIPickerView?
    
    //Social Logins View
    @IBOutlet weak public var btnFacbook: UIButton!
    @IBOutlet weak public var btnGoogle: UIButton!
//    @IBOutlet weak public var btnTwitter: UIButton!
    @IBOutlet weak var btnBottomTooltip: UIButton!
    
    public var activityIndicatoryFb:UIActivityIndicatorView!
    public var activityIndicatoryGoogle:UIActivityIndicatorView!
//    public var activityIndicatoryTwitter:UIActivityIndicatorView!
    
    var type: RegisterationViewType = .PhoneNumber
    var capacityArray = [String]()
	var gendersArray = [Bundle.localizedStringFor(key: "Male"),Bundle.localizedStringFor(key: "Female")]

	var plateTypeArray = [PlateType]()
	var selectedGenderIndex = 0
    var selectedCapacityIndex: Int = 0
	var selectedPlateTypeIndex: Int = 0
	var driverDOB: Date?
	var isHijriDob = true
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(actionHideKeyboard))
        self.view.addGestureRecognizer(tapGesture)
        
        //text fields delegate
        fieldFirst.delegate = self
        fieldSecond.delegate = self
        fieldThird.delegate = self
        fieldFourth.delegate = self
        fieldFifth.delegate = self
        fieldPhoneCode.delegate = self
		fieldSixth.delegate = self
        
        btnTooltip.isHidden = true
		
        fieldFirst.returnKeyType = .done
        fieldSecond.returnKeyType = .done
        fieldThird.returnKeyType = .done
        fieldFourth.returnKeyType = .done
        fieldFifth.returnKeyType = .done
		fieldSixth.returnKeyType = .done
        
        self.navigationController?.navigationBar.topItem?.title = ""
        
        guard let type = dataSource?.viewType() else {
            fatalError("Missing registeration view controller datasource method viewType")
        }
        
        guard let assets = dataSource?.assests() else {
            fatalError("Missing registeration view controller datasource assets")
        }
        
        config(type: type, assets: assets)
        
        configViews(type: type)
        
        addTargets()
        
        configurationsCompleted()

		orLoginWithLabel.text = Bundle.localizedStringFor(key: "or Login with")
        
    }
    
    open func configurationsCompleted()  { }
    
    func actionHideKeyboard()  {
        self.view.endEditing(true)
    }
    
    func config(type: RegisterationViewType, assets:RegisterationAssets)  {
        self.type = type
        self.logo.image = assets._logo.withRenderingMode(.alwaysTemplate)
        self.logo.tintColor = UIColor.appColor(color: .Primary)
//        btnTooltip.setImage(assets._tooltip, for: .normal)
        btnBottomTooltip.setImage(assets._tooltip, for: .normal)
        btnNext.setImage(assets._btnNext, for: .normal)
        btnGoogle.setImage(assets._google, for: .normal)
        btnFacbook.setImage(assets._facebook, for: .normal)
//        btnTwitter.setImage(assets._twitter, for: .normal)
        btnAction.tintColor = UIColor.appColor(color: .Secondary)
        if type != .PasswordAndConfirmPassword  && type != .AddVehicleDetails && type != .BasicInfo && type != .ResetPassUsingPhone && type != .NameAndEmail{
            removeFirstField()
        }
        if type != .PhoneNumber{
            removeSocialLoginsView()
        }else{
            addActivityIndicatorsOverSocialLogins()
            self.socialLoginsView.isHidden = false
            removeTitleView()
        }
        if type == .PasswordAndConfirmPassword || type == .PhoneNumber || type == .AddVehicleDetails || type == .BasicInfo || type == .ForgotPassword || type == .NameAndEmail{
            removeActionButton()
        }
        if type != .InviteCode && type != .ForgotPassword{
            removeSubtitle()
        }
        if type == .VerificationCode{
//            btnTooltip.isHidden = false
        }
        if type == .AddVehicleDetails{
            addThirdField()
            addFourthField()
            addFifthField()
			addSixthField()
			addSeventhField()
        }
        if type == .BasicInfo{
            addThirdField()
			addFourthField()
			addFifthField()
			addSixthField()
            addDriverNationalityView()
        }
        if type == .ResetPassUsingPhone{
            addThirdField()
        }
        self.logoView.isHidden = false
        self.fieldsView.isHidden = false
        
    }
    
    public func configViews(type: RegisterationViewType)  {
        btnBackToSigup.setTitle(Bundle.localizedStringFor(key: "auth-btn-back-to-signup"), for: .normal)
        switch type {
        case .PhoneNumber:
            showPhoneNoCode()
            fieldPhoneCode.text = Bundle.localizedStringFor(key: "auth-country-code")
            fieldSecond.placeholder = Bundle.localizedStringFor(key: "Phone Number i.e. 5xxxxxxxxx")
            fieldSecond.keyboardType = .numberPad
        case .VerificationCode:
            labelTitle.text = Bundle.localizedStringFor(key: "auth-verification-code")
            fieldSecond.placeholder = Bundle.localizedStringFor(key: "auth-enter-here")
            btnAction.setTitle(Bundle.localizedStringFor(key: "auth-resend-code"), for: .normal)
            fieldSecond.keyboardType = .numberPad
            btnBackToSigup.isHidden = false
        case .NameAndEmail:
			labelTitle.text = Bundle.localizedStringFor(key: "Name")
			fieldFirst.placeholder = Bundle.localizedStringFor(key: "Name")
			fieldSecond.placeholder = Bundle.localizedStringFor(key: "Gender")
			genderPickerView = showGenderPicker()
			fieldSecond.inputView = genderPickerView
			//            fieldSecond.placeholder = Bundle.localizedStringFor(key: "auth-email")
		//            fieldSecond.keyboardType = .emailAddress
        case.Password:
            labelTitle.text = Bundle.localizedStringFor(key: "auth-password")
            fieldSecond.placeholder = Bundle.localizedStringFor(key: "auth-password")
            btnAction.setTitle(Bundle.localizedStringFor(key: "auth-btn-forgot-pass"), for: .normal)
            fieldSecond.isSecureTextEntry = true
        case .PasswordAndConfirmPassword:
            labelTitle.text = Bundle.localizedStringFor(key: "auth-password")
            fieldFirst.placeholder = Bundle.localizedStringFor(key: "Password (must be 6 digits)")
            fieldSecond.placeholder = Bundle.localizedStringFor(key: "auth-password-confirm")
            fieldFirst.isSecureTextEntry = true
            fieldSecond.isSecureTextEntry = true
        case .InviteCode:
            labelTitle.text = Bundle.localizedStringFor(key: "auth-invite-code")
            labelSubtitle.text = Bundle.localizedStringFor(key: "auth-invite-code-msg")
            fieldSecond.placeholder = Bundle.localizedStringFor(key: "auth-invite-code")
            btnAction.setTitle(Bundle.localizedStringFor(key: "auth-skip"), for: .normal)
        case .ForgotPassword:
            labelTitle.text = Bundle.localizedStringFor(key: "auth-forgot-pass")
            labelSubtitle.text = Bundle.localizedStringFor(key: "auth-forgot-pass-msg")
            fieldSecond.placeholder = Bundle.localizedStringFor(key: "Phone Number i.e. 5xxxxxxxxx")
            fieldSecond.keyboardType = .numberPad
        case .AddVehicleDetails:
            labelTitle.text = Bundle.localizedStringFor(key: "auth-add-vehicle-details")
            fieldFirst.placeholder = Bundle.localizedStringFor(key: "auth-make")
            fieldSecond.placeholder = Bundle.localizedStringFor(key: "auth-model")
            fieldThird.placeholder = Bundle.localizedStringFor(key: "auth-year")
			fieldFourth.placeholder = Bundle.localizedStringFor(key: "Plate Type")
            fieldFifth.placeholder = Bundle.localizedStringFor(key: "auth-license-plate")
				.appending("(ى-و-ھ-١٢٣٤)")
			fieldSixth.placeholder = Bundle.localizedStringFor(key: "Sequence Number")
            fieldSeventh.placeholder = Bundle.localizedStringFor(key: "auth-capacity")
            addVehicleRegisterationView()
            fieldThird.keyboardType = .numberPad
			fieldSixth.keyboardType = .numberPad
            capacityArray = carCapcaityArray()
			plateTypePickerView = showPlateTypePicker()
			fieldFourth.inputView = plateTypePickerView
			plateTypeArray = createPlateTypeArray()
			fieldFourth.text = plateTypeArray[selectedPlateTypeIndex].title
			fieldSeventh.inputView = showPicker()
            fieldSeventh.text = capacityArray[selectedCapacityIndex]
        case .BasicInfo:
            labelTitle.text = Bundle.localizedStringFor(key: "auth-basic-info")
            fieldFirst.placeholder = Bundle.localizedStringFor(key: "Name")
            fieldSecond.placeholder = Bundle.localizedStringFor(key: "auth-email")
            fieldThird.placeholder = Bundle.localizedStringFor(key: "auth-city")
			fieldFourth.placeholder = Bundle.localizedStringFor(key: "Gender")
			fieldFifth.placeholder = Bundle.localizedStringFor(key: "Date Of Birth")
			fieldSixth.placeholder = Bundle.localizedStringFor(key: "Saudi Id/Iqama Id")
			fieldSixth.keyboardType = .numberPad
			let datePickerView = DatePickerView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 170))
			datePickerView.dateUpdateCallback = { [weak self] (date,isHijri) in
				let dateFormatter = DateFormatter()
				dateFormatter.dateFormat = "MMMM  dd  YYYY"
				if isHijri{
					dateFormatter.calendar = Calendar(identifier: .islamicUmmAlQura)
				}else {
					dateFormatter.calendar = Calendar(identifier: .gregorian)
				}
				let dateString = dateFormatter.string(from: date)
				self?.fieldFifth.text =  dateString
				self?.driverDOB = date
				self?.isHijriDob = isHijri
			}

			fieldFifth.inputView = datePickerView
            labelDriverNationality.text = Bundle.localizedStringFor(key: "auth-saudi-national")
            fieldSecond.keyboardType = .emailAddress
			genderPickerView = showGenderPicker()
			fieldFourth.inputView = genderPickerView
        case .ResetPassUsingPhone:
            labelTitle.text = Bundle.localizedStringFor(key: "auth-reset-pass")
            fieldFirst.placeholder = Bundle.localizedStringFor(key: "auth-password")
            fieldSecond.placeholder = Bundle.localizedStringFor(key: "auth-password-confirm")
            fieldFirst.isSecureTextEntry = true
            fieldSecond.isSecureTextEntry = true
            fieldThird.keyboardType = .numberPad
            fieldThird.placeholder = Bundle.localizedStringFor(key: "auth-verification-code")
            btnAction.setTitle(Bundle.localizedStringFor(key: "auth-resend-code"), for: .normal)
        }
    }
    
    open func carCapcaityArray() -> [String]{
        return [String]()
    }

	public struct PlateType {
		var title: String
		var id: Int
	}

	private func localisedValue(for key: String) -> String {
		return Bundle.localizedStringFor(key: key)
	}

	public func createPlateTypeArray() -> [PlateType] {
		var arr = [PlateType]()

		arr.append(PlateType(title: localisedValue(for: "Private Car"), id: 1))
		arr.append(PlateType(title: localisedValue(for: "Public Transport"), id: 2))
		arr.append(PlateType(title: localisedValue(for: "Private Transport"), id: 3))
		arr.append(PlateType(title: localisedValue(for: "Public Bus"), id: 4))
		arr.append(PlateType(title: localisedValue(for: "Private Bus"), id: 5))
		arr.append(PlateType(title: localisedValue(for: "Taxi"), id: 6))
		arr.append(PlateType(title: localisedValue(for: "Heavy equipment"), id: 7))
		arr.append(PlateType(title: localisedValue(for: "Export"), id: 8))
		arr.append(PlateType(title: localisedValue(for: "Diplomatic"), id: 9))
		arr.append(PlateType(title: localisedValue(for: "Motorcycle"), id: 10))
		arr.append(PlateType(title: localisedValue(for: "Temporary"), id: 11))
		return arr
	}

    public func setFirstFieldText(text: String){
        guard fieldFirst != nil else {
            return
        }
        fieldFirst.text = text
    }
    public func setSecondFieldText(text: String){
        guard fieldSecond != nil else {
            return
        }
        fieldSecond.text = text
    }
    public func setThirdFieldText(text: String){
        guard fieldThird != nil else {
            return
        }
        fieldThird.text = text
    }
    public func setFouthFieldText(text: String){
        guard fieldFourth != nil else {
            return
        }
        fieldFourth.text = text
    }
    public func setFifthFieldText(text: String){
        guard fieldFifth != nil else {
            return
        }
        fieldFifth.text = text
    }
    
    func addActivityIndicatorsOverSocialLogins(){
        activityIndicatoryFb = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        activityIndicatoryFb.hidesWhenStopped = true
        activityIndicatoryFb.center = btnFacbook.center
        btnFacbook.addSubview(activityIndicatoryFb)
        
        activityIndicatoryGoogle = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        activityIndicatoryGoogle.hidesWhenStopped = true
        activityIndicatoryGoogle.center = btnGoogle.center
        btnGoogle.addSubview(activityIndicatoryGoogle)
        
//        activityIndicatoryTwitter = UIActivityIndicatorView(activityIndicatorStyle: .gray)
//        activityIndicatoryTwitter.hidesWhenStopped = true
//        activityIndicatoryTwitter.center = btnTwitter.center
//        btnTwitter.addSubview(activityIndicatoryTwitter)
    }
    
    func addTargets()  {
        btnAction.addTarget(self, action: #selector(actPrimary(sender:)), for: .touchUpInside)
        btnNext.addTarget(self, action: #selector(actNext(sender:)), for: .touchUpInside)
        btnGoogle.addTarget(self, action: #selector(actGoogleLogin(sender:)), for: .touchUpInside)
        btnFacbook.addTarget(self, action: #selector(actFacebookLogin(sender:)), for: .touchUpInside)
//        btnTwitter.addTarget(self, action: #selector(actTwitterLogin(sender:)), for: .touchUpInside)
        btnTooltip.addTarget(self, action: #selector(actTooltipTop(sender:)), for: .touchUpInside)
        btnBottomTooltip.addTarget(self, action: #selector(actBottomTooltip(sender:)), for: .touchUpInside)
        btnBackToSigup.addTarget(self, action: #selector(actBackToSignup(sender:)), for: .touchUpInside)
    }
    
    func removeFirstField()  {
        firstFieldHeight.constant = 0
        stackViewHeight.constant = 76-30
        stackViewReqHeight.constant = 64-30
        fieldFirst.isHidden = true
    }
    
    func removeTitleView()  {
        titleViewHeight.constant = 0
    }
    
    func removeSubtitle()  {
        subtitleHeight.constant = 0
    }
    
    func removeActionButton()  {
        actionButtonHeight.constant = 0
    }
    
    func showPhoneNoCode()  {
        fieldSecondLeading.constant = 12
        phoneCodeWidth.constant = 40
        fieldPhoneCode.clearButtonMode = .never
    }
    
    func addThirdField()  {
        thirdFieldHeight.constant = 30
        fieldThird.isHidden = false
        
        stackViewHeight.constant = 76+30
        stackViewReqHeight.constant = 64+30
    }
    
    func addFourthField()  {
        fourthFieldHeight.constant = 30
        fieldFourth.isHidden = false
        
        stackViewHeight.constant = 76+30+30
        stackViewReqHeight.constant = 64+30+30
    }
    
    func addFifthField()  {
        fifthFieldHeight.constant = 30
        fieldFifth.isHidden = false
        
        stackViewHeight.constant = 76+30+30+30
        stackViewReqHeight.constant = 64+30+30+30
    }

	func addSixthField()  {
		sixthFieldHeight.constant = 30
		fieldSixth.isHidden = false

		stackViewHeight.constant = 76+30+30+30+30
		stackViewReqHeight.constant = 64+30+30+30+30
	}

	func addSeventhField()  {
		seventhFieldHeight.constant = 30
		fieldSixth.isHidden = false

		stackViewHeight.constant = 76+150
		stackViewReqHeight.constant = 64+150
	}
    
    func addVehicleRegisterationView()  {
        vehicleRegisterationContainerHeight.constant = 30
        vehicleRegisterationContainerView.isHidden = false
        vehicleRegisterationView = VehicleRegisterationView(frame: CGRect(x: 0, y: 0, width: 210, height: 30))
        vehicleRegisterationContainerView.addSubview(vehicleRegisterationView)
        stackViewHeight.constant = 76+30+30+30+30
        stackViewReqHeight.constant = 64+30+30+30+30
    }
    
    func addDriverNationalityView()  {
        driverNationalityViewHeight.constant = 30
        driverNationalityView.isHidden = false
        stackViewHeight.constant = 76+30+30
        stackViewReqHeight.constant = 64+30+30
    }
    
    public func removeSocialLoginsView()  {
        self.socialLoginsView.removeFromSuperview()
        //        let bottom = NSLayoutConstraint(item: self.view, attribute: .bottom, relatedBy: .greaterThanOrEqual, toItem: self.fieldsView, attribute: .bottom, multiplier: 1, constant: 44)
        let centerY = NSLayoutConstraint(item: fieldsView, attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1, constant: 0)
        self.view.addConstraint(centerY)
        //        self.view.addConstraint(bottom)
    }
    
    
    public func configPrimaryButton(btnTitle:String? = nil,image:UIImage? = nil){
        if let _btnTitle = btnTitle{
            self.btnAction.setTitle(_btnTitle, for: .normal)
        }
        if let _img = image{
            self.btnAction.setImage(_img, for: .normal)
        }
    }
    
    //MARK:- Actions
    func actNext(sender: UIButton)  {
        delegate?.actionNext(sender: sender)
    }
    
    func actPrimary(sender: UIButton)  {
        delegate?.actionPrimary?(sender: sender)
    }
    
    func actGoogleLogin(sender: UIButton)  {
        delegate?.actionGoogleLogin?(sender: sender)
    }
    
    func actFacebookLogin(sender: UIButton)  {
        delegate?.actionFacbookLogin?(sender: sender)
    }
    
//    func actTwitterLogin(sender: UIButton)  {
//        delegate?.actionTwitterLogin?(sender: sender)
//    }
    
    func actBottomTooltip(sender: UIButton)  {
        delegate?.actionTooltipBottom?(sender: sender)
    }
    
    func actTooltipTop(sender: UIButton)  {
        delegate?.actionTooltipTop?(sender: sender)
    }
    
    func actBackToSignup(sender: UIButton)  {
        delegate?.actionBackToSignup?(sender: sender)
    }
}
//MARK:- Handle TextField delegates
extension RegisterationTemplateViewController: UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate  {
    public func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == fieldSeventh && type == .AddVehicleDetails{
            let picker = fieldSeventh.inputView as! UIPickerView
            picker.selectRow(selectedCapacityIndex, inComponent: 0, animated: false)
        }else if textField == fieldThird && type == .BasicInfo{
            delegate?.showCitiesList?()
            return false
		}else if (textField == fieldSecond && type == .NameAndEmail)  {
			let picker = fieldSecond.inputView as! UIPickerView
			picker.selectRow(selectedGenderIndex, inComponent: 0, animated: false)
			textField.text = gendersArray[selectedGenderIndex]
		}else if (textField == fieldFourth && type == .BasicInfo) {
			let picker = fieldFourth.inputView as! UIPickerView
			picker.selectRow(selectedGenderIndex, inComponent: 0, animated: false)
			textField.text = gendersArray[selectedGenderIndex]
		}
		
        return true
    }
    
    
    //MARK:- Picker
    func showPicker() -> UIPickerView {
        let picker = UIPickerView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 100))
        picker.dataSource = self
        picker.delegate = self
        return picker
    }

	func showGenderPicker() -> UIPickerView {
		let picker = UIPickerView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 100))
		picker.dataSource = self
		picker.delegate = self
		return picker
	}

	func showDatePicker(calendarIdentifier: Calendar.Identifier) -> UIDatePicker {
		let picker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 200))
		picker.datePickerMode = .date
		picker.date = Date()
		picker.calendar = Calendar(identifier: calendarIdentifier)
		picker.addTarget(self, action: #selector(dateChanged(_:)), for: .valueChanged)
//		picker.autoresizingMask = UIViewAutoresizing.flexibleRightMargin
		return picker
	}

	func showPlateTypePicker() -> UIPickerView {
		let picker = UIPickerView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 200))
		picker.dataSource = self
		picker.delegate = self
		return picker
	}

	func dateChanged(_ datePicker: UIDatePicker)  {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "MMMM  dd  YYYY"
		dateFormatter.calendar = Calendar(identifier: .islamicUmmAlQura)
//		dateFormatter.locale = Locale.init(identifier: "en_GB")
		let dateString = dateFormatter.string(from: datePicker.date)
		fieldFifth.text =  dateString
		driverDOB = datePicker.date
	}
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
		if pickerView == genderPickerView {
			return gendersArray.count
		}else if pickerView == plateTypePickerView {
			return plateTypeArray.count
		}
        return capacityArray.count
    }
    
    public func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 22
    }
    
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
		if pickerView == genderPickerView {
			return gendersArray[row]
		}else if pickerView == plateTypePickerView {
			return plateTypeArray[row].title
		}
        return  capacityArray[row]
    }
    
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
		if pickerView == genderPickerView {
			selectedGenderIndex = row
			if type == .NameAndEmail {
				fieldSecond.text = gendersArray[row]
			}else if type == .BasicInfo {
				fieldFourth.text = gendersArray[row]
			}
		}else if pickerView == plateTypePickerView {
			selectedPlateTypeIndex = row
			fieldFourth.text = plateTypeArray[row].title
		}else {
        	selectedCapacityIndex = row
        	fieldSeventh.text = capacityArray[row]
		}
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        switch type {
        case .PhoneNumber:
            if textField == fieldPhoneCode{
                return RegisterationTemplateViewController.handlePhoneCode(textField: textField, shouldChangeCharactersIn: range, replacementString: string)
            }
            return RegisterationTemplateViewController.handlePhoneNumber(textField: textField, shouldChangeCharactersIn: range, replacementString: string)
        case .VerificationCode:
            return !(textField.text!.count > 3 && (string.count) > range.length)
        case .ForgotPassword:
//            guard fieldSecond.placeholder?.caseInsensitiveCompare("Email") != .orderedSame else {
//                return true
//            }
            return RegisterationTemplateViewController.handlePhoneNumber(textField: textField, shouldChangeCharactersIn: range, replacementString: string)
        case .ResetPassUsingPhone:
            if textField == fieldThird{
                return !(textField.text!.count > 5 && (string.count) > range.length)
            }
            return true
        case .AddVehicleDetails:
            if textField == fieldThird{
                return !(textField.text!.count > 3 && (string.count) > range.length)
			}else if textField == fieldFifth {
				return handleLicencePlate(textField: textField,shouldChangeCharactersInRange: range, replacementString: string)
			}else if textField == fieldFourth {
				return false
			} else if textField == fieldSeventh {
				return false
			}
        case .BasicInfo:
            if textField == fieldFirst{
                return handleName(textField: textField,shouldChangeCharactersIn: range, replacementString: string)
			}else if textField == fieldFourth {
				return false
			}else if textField == fieldSixth {
				 return handleIqamaId(textField: textField,shouldChangeCharactersIn: range, replacementString: string)
			}
		case .NameAndEmail:
			if textField == fieldSecond {
				return false
			}
        default:
            return !(textField.text!.count > 119 && (string.count) > range.length)
        }
        return !(textField.text!.count > 119 && (string.count) > range.length)
    }
    
    
    func handleName(textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool{
        if string == " "{
            return !(textField.text!.count > 119 && (string.count) > range.length)
        }else if  string.count > 0 {
            let lettersOnly = CharacterSet.letters
            guard let scalar = UnicodeScalar.init(string) else{
                return false
            }
            let strValid = lettersOnly.contains(scalar)
            return strValid && !(textField.text!.count > 119 && (string.count) > range.length)
        }
        return true
    }

	public func handleIqamaId(textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
		return !(textField.text!.count > 9 && (string.count) > range.length)
	}

	public func handleLicencePlate(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
		// check the chars length dd -->2 at the same time calculate the dd-MM --> 5
		let replaced = (textField.text! as NSString).replacingCharacters(in: range, with: string)
		if replaced.count <= 5 && !isLicenceInitialCharacter(string: string) && !(string == "") {
			return false
		}else if replaced.count > 5 && !isArabicNumber(string: string) && !(string == "") {
			return false
		}
		if (textField.text!.count == 1) || (textField.text!.count == 3 ) || (textField.text!.count == 5) {
			//Handle backspace being pressed
			if !(string == "") {
				// append the text
				textField.text = textField.text! + "-"
			}
		}
		return !(textField.text!.count > 9 && (string.count ) > range.length)
	}

	private func isLicenceInitialCharacter(string: String) -> Bool {
		let allowedCharacters = ["ا", "ب", "ح", "د", "ر", "س", "ص", "ط", "ع", "ق", "ك", "ل", "م", "ن", "ھ", "و", "ى"]
		for ch in allowedCharacters {
			if ch == string {
				return true
			}
		}
		return false
	}

	private func isArabicNumber(string: String) -> Bool {
		let allowedCharacters = ["٠", "١", "٢", "٣", "٤", "٥", "٦", "٧", "٨", "٩"]
		for ch in allowedCharacters {
			if ch == string {
				return true
			}
		}
		return false
	}
    public static func handlePhoneCode(textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return !(textField.text!.count > 3 && (string.count) > range.length)
    }
    
    public static func handlePhoneNumber(textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        if textField.text!.count == 0 && string == "0"{
//            textField.text! = "92"
//            return false
//        }else if textField.text!.count == 2 && string == "" {
//            textField.text! = ""
//        }
        return !(textField.text!.count > 9 && (string.count) > range.length)
    }
}

//MARK:- Validations
public extension RegisterationTemplateViewController{
    
    public func getPhoneNo() -> String? {
        let phoneNo = RegisterationTemplateViewController.getValidPhoneNoFrom(fieldCode: fieldPhoneCode, fieldPhoneNo: fieldSecond)
        if phoneNo == nil{
            Alert.showMessage(viewController: self, title: Bundle.localizedStringFor(key: "Invalid Input"), msg:   Bundle.localizedStringFor(key: "auth-phone-must-be-twelve-digits"))
        }else{
            self.view.endEditing(true)
        }
        return phoneNo
    }
    
    public static func getValidPhoneNoFrom(fieldCode: UITextField, fieldPhoneNo: UITextField) -> String? {
        var isValid = true
        var code = fieldCode.text ?? Bundle.localizedStringFor(key: "auth-country-code")
        if !code.isEmpty{
            code.remove(at: code.startIndex)
        }
        
        var noWithoutCode = fieldPhoneNo.text ?? ""
        if noWithoutCode.count == 10 && noWithoutCode.first! == "0"{
            noWithoutCode = noWithoutCode.substring(from: noWithoutCode.index(after: noWithoutCode.startIndex))
        }
        
        let phoneNumber = "\(code)\(noWithoutCode)"
        
        if phoneNumber.isEmpty {
            isValid = false
        }else if phoneNumber.count != 12{
            isValid = false
        }
        
        if !isValid{
            return nil
        }else{
            return phoneNumber
        }
    }
    
	public func getNameAndGender() -> (name: String, gender: Int)?{
		let name = fieldFirst.text ?? ""
		let gender = fieldSecond.text ?? ""
		if name.isEmpty{
			Alert.showMessage(viewController: self, title: Bundle.localizedStringFor(key: "Invalid Input"), msg: Bundle.localizedStringFor(key: "auth-name-is-required"))
			return nil
		}else if  gender.isEmpty {
			Alert.showMessage(viewController: self, title: Bundle.localizedStringFor(key: "Invalid Input"), msg: Bundle.localizedStringFor(key: "auth-fill-all-fields"))
			return nil
		}else {
			self.view.endEditing(true)
			return (name,selectedGenderIndex)
		}/*else if email.isEmpty{
		Alert.showMessage(viewController: self, title: Bundle.localizedStringFor(key: "constant-invalid-input"), msg: Bundle.localizedStringFor(key: "auth-email-is-required"))
		return nil
		}else if !fieldSecond.isValid(exp: .email){
		Alert.showMessage(viewController: self, title: Bundle.localizedStringFor(key: "constant-invalid-input"), msg: Bundle.localizedStringFor(key: "auth-enter-valid-email"))
		return nil
		}*/
	}
    
    public func getPasswordAndConfirmPassword() -> [String]? {
        let pass = fieldFirst.text ?? ""
        let confirmPass = fieldSecond.text ?? ""
        
        var msg = ""
        if pass.count <= 5{
            msg = Bundle.localizedStringFor(key: "Password must be more than 5 characters")
        }else if pass.compare(confirmPass) != .orderedSame{
            msg = Bundle.localizedStringFor(key: "auth-pass-and-confirm-pass-donot-match")
        }
        
        if msg.isEmpty{
            self.view.endEditing(true)
            return [pass,confirmPass]
        }else{
            Alert.showMessage(viewController: self, title: Bundle.localizedStringFor(key: "Invalid Input"), msg: msg)
            return nil
        }
    }
    
    public func getPin() -> String? {
        let pin = fieldSecond.text ?? ""
        if pin.count == 4 {
            self.view.endEditing(true)
            return pin
        }else{
            Alert.showMessage(viewController: self, title: Bundle.localizedStringFor(key: "Invalid Pin"), msg: Bundle.localizedStringFor(key: "Pin must have 4 digits"))
            return nil
        }
    }
    
    public func getPassword() -> String? {
        let pass = fieldSecond.text ?? ""
        if pass.count <= 5{
            Alert.showMessage(viewController: self, title: Bundle.localizedStringFor(key: "Invalid Input"), msg: Bundle.localizedStringFor(key: "Password must be more than 5 characters"))
            return nil
        }else{
            self.view.endEditing(true)
            return pass
        }
    }
    
    func getResetPassUsingPhoneAsset() -> ResetPassUsingPhoneAsset? {
        let passAndConfirmPass = getPasswordAndConfirmPassword()
        let verificationCode = fieldThird.text ?? ""
        if passAndConfirmPass == nil{
            return nil
        }else if verificationCode.count != 4{
            Alert.showMessage(viewController: self, title: Bundle.localizedStringFor(key: "Invalid Pin"), msg: Bundle.localizedStringFor(key: "Pin must have 4 digits"))
            return nil
        }else{
            self.view.endEditing(true)
            return ResetPassUsingPhoneAsset(pass: passAndConfirmPass![0], confirmPass: passAndConfirmPass![1], verificationCode: verificationCode)
        }
    }
    
    public func getInviteCode() -> String? {
        let pin = fieldSecond.text ?? ""
        if pin.count == 0 {
            Alert.showMessage(viewController: self, title: Bundle.localizedStringFor(key:"auth-invalid-invite-code-title"), msg: Bundle.localizedStringFor(key:"auth-invalid-invite-code-msg"))
            return nil
        }else{
            self.view.endEditing(true)
            return pin
        }
    }

	public func getBasicInfo() -> BasicInfo? {
		var email: String?
		if let emailString = fieldSecond.text, !emailString.isEmpty {
			email = emailString
		}
		let isSaudiNational = driverNationalitySwitch.isOn
		if (fieldFirst.text ?? "").isEmpty || (fieldThird.text ?? "").isEmpty || (fieldFourth.text ?? "" ).isEmpty || driverDOB == nil  || (fieldSixth.text ?? "").count != 10 {
			Alert.showMessage(viewController: self, title: Bundle.localizedStringFor(key: "Invalid Input"), msg: Bundle.localizedStringFor(key: "auth-fill-all-fields"))
			return nil
		}else if let emailString = email, !UITextField.isValid(text: emailString, forExp: .email){
			Alert.showMessage(viewController: self, title: Bundle.localizedStringFor(key: "Invalid Input"), msg: Bundle.localizedStringFor(key: "auth-fill-all-fields"))
			return nil
		} else{
			self.view.endEditing(true)
			var info = BasicInfo()
			info.name = fieldFirst.text ?? ""
			info.email = email
			info.city = fieldThird.text ?? ""
			info.isSaudiNational = isSaudiNational
			info.selectedGenderIndex = selectedGenderIndex
			info.dateOfBirth = driverDOB ?? Date()
			info.isHijriDob = isHijriDob
			info.iqamaOrSaudiId = fieldSixth.text ?? ""
			return info
		}
	}
    
    public func getVehicleDetails() -> VehicleDetails? {
        let make = fieldFirst.text ?? ""
        let model = fieldSecond.text ?? ""
        let yearString = fieldThird.text ?? ""
        let licensePlate = fieldFifth.text ?? ""
		let plateType = fieldFourth.text ?? ""
		let sequenceNo = fieldSixth.text ?? ""
        let currentYear = getCurrentYear()
        guard let year = Int(yearString),year <= currentYear  else {
            Alert.showMessage(viewController: self, title: Bundle.localizedStringFor(key: "Invalid Input"), msg: Bundle.localizedStringFor(key: "auth-invalid-year"))
            return nil
        }
        if year < RegisterationTemplateViewController.minValidYear{
            let format = Bundle.localizedStringFor(key: "auth-year-must-be-greater-than")
            let minValue = RegisterationTemplateViewController.minValidYear - 1
            Alert.showMessage(viewController: self, title: Bundle.localizedStringFor(key: "Invalid Input"), msg: String(format: format,minValue))
            return nil
        }else if make.isEmpty || model.isEmpty || plateType.isEmpty || sequenceNo.isEmpty || licensePlate.count != 10 {
            Alert.showMessage(viewController: self, title: Bundle.localizedStringFor(key: "Invalid Input"), msg: Bundle.localizedStringFor(key: "auth-fill-all-fields"))
            return nil
        }else{
            self.view.endEditing(true)
			var info = VehicleDetails()
			info.make = make
			info.model = model
			info.year = year
			info.plateType = plateTypeArray[selectedPlateTypeIndex].id
			info.licensePlate = licensePlate
			info.sequenceNo = sequenceNo
			info.selectedCapacityIndex = selectedCapacityIndex
            return info
        }
    }

    
    func getCurrentYear() -> Int {
        let date = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year], from: date)
        return components.year ?? 0
    }
}


class DatePickerView: UIView {

	var selectedIndex = 0 {
		didSet {
			if selectedIndex == 0 {
				gregorianPicker.isHidden = true
				hijriPicker.isHidden = false
			}else {
				gregorianPicker.isHidden = false
				hijriPicker.isHidden = true
			}
		}
	}

	var segmentedControl: UISegmentedControl!
	var hijriPicker: UIDatePicker!
	var gregorianPicker: UIDatePicker!
	var date = Date()
	var isHijriDate = true
	var dateUpdateCallback: ((Date,Bool) ->Void)?

	override init(frame: CGRect) {
		super.init(frame: frame)
		customizeUI()
	}

	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		customizeUI()
	}

	//MARK: UI
	private func customizeUI () {

//		segmentedControl = DarkBorderSegmentedControl()
//		segmentedControl.insertSegment(withTitle: "Hijri", at: 0, animated: false)
//		segmentedControl.insertSegment(withTitle: "Gregorian", at: 1, animated: false)
		segmentedControl = UISegmentedControl(items: ["Hijri", "Gregorian"])
		segmentedControl.tintColor = UIColor.appColor(color: .Primary)
		segmentedControl.selectedSegmentIndex = selectedIndex
		segmentedControl.addTarget(self, action: #selector(segmentUpdated(_:)), for: .valueChanged)
		add(segmentedControl: segmentedControl, to: self)

		hijriPicker = createDatePicker(calendarIdentifier: .islamicUmmAlQura)
		hijriPicker.addTarget(self, action: #selector(dateUpdated(_:)), for: .valueChanged)
		add(datePicker: hijriPicker, to: self, topView: segmentedControl)

		gregorianPicker = createDatePicker(calendarIdentifier: .gregorian)
		gregorianPicker.addTarget(self, action: #selector(dateUpdated(_:)), for: .valueChanged)
		add(datePicker: gregorianPicker, to: self, topView: segmentedControl)

		selectedIndex = segmentedControl.selectedSegmentIndex

//		self.backgroundColor = UIColor.black
	}

	private func add(segmentedControl child: UISegmentedControl, to parent: UIView) {
		child.translatesAutoresizingMaskIntoConstraints = false
		parent.addSubview(child)

		child.heightAnchor.constraint(equalToConstant: 30).isActive = true
		child.leadingAnchor.constraint(equalTo: parent.leadingAnchor).isActive = true
		parent.trailingAnchor.constraint(equalTo: child.trailingAnchor).isActive = true
	}

	private func add(datePicker child: UIDatePicker, to parent: UIView, topView: UISegmentedControl) {
		child.translatesAutoresizingMaskIntoConstraints = false
		parent.addSubview(child)

		child.heightAnchor.constraint(equalToConstant: 140).isActive = true
		child.topAnchor.constraint(equalTo: topView.bottomAnchor).isActive = true
		child.leadingAnchor.constraint(equalTo: parent.leadingAnchor).isActive = true
		parent.trailingAnchor.constraint(equalTo: child.trailingAnchor).isActive = true
		parent.bottomAnchor.constraint(equalTo: child.bottomAnchor).isActive = true
	}

	func createDatePicker(calendarIdentifier: Calendar.Identifier) -> UIDatePicker {
		let picker = UIDatePicker()
		picker.datePickerMode = .date
		picker.date = Date()
		picker.calendar = Calendar(identifier: calendarIdentifier)
		return picker
	}

	@objc private func segmentUpdated(_ sender: UISegmentedControl) {
		selectedIndex = sender.selectedSegmentIndex
	}

	@objc private func dateUpdated(_ sender: UIDatePicker) {
		if sender == hijriPicker {
			isHijriDate = true
		}else if sender == gregorianPicker {
			isHijriDate = false
		}
		date = sender.date
		dateUpdateCallback?(sender.date,isHijriDate)
	}

}
