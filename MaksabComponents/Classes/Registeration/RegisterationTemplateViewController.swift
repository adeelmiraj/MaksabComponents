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
    public var email: String
    public var city: String
    public var isSaudiNational: Bool
}

public struct VehicleDetails{
    public var make: String
    public var model: String
    public var year: Int
    public var licensePlate: String
    public var selectedCapacityIndex: Int
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
    static public let countryCode = "92"
    static public let minValidYear = 1997
    public var dataSource: RegisterationTemplateViewControllerDataSource!
    public var delegate: RegisterationTemplateViewControllerDelegate?
    
    
    @IBOutlet weak var socialLoginsView: UIView!
    @IBOutlet weak var fieldsView: UIView!
    @IBOutlet weak var logoView: UIView!
    
    @IBOutlet weak public var logo: UIImageView!
    
    //Fields View
    @IBOutlet weak var firstFieldHeight: NSLayoutConstraint!
    @IBOutlet weak var thirdFieldHeight: NSLayoutConstraint!
    @IBOutlet weak var fourthFieldHeight: NSLayoutConstraint!
    @IBOutlet weak var fifthFieldHeight: NSLayoutConstraint!
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
    @IBOutlet weak public var fieldFirst: BottomBorderTextField!
    @IBOutlet weak public var fieldSecond: BottomBorderTextField!
    @IBOutlet weak public var fieldThird: BottomBorderTextField!
    @IBOutlet weak public var fieldFourth: BottomBorderTextField!
    @IBOutlet weak public var fieldFifth: BottomBorderTextField!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var btnAction: UIButton!
    
    @IBOutlet weak var btnBackToSigup: UIButton!
    @IBOutlet weak var driverNationalitySwitch: UISwitch!
    @IBOutlet weak var labelDriverNationality: UILabel!
    @IBOutlet weak var driverNationalityView: UIView!
    public var vehicleRegisterationView: VehicleRegisterationView!
    @IBOutlet weak var vehicleRegisterationContainerView: UIView!
    
    
    //Social Logins View
    @IBOutlet weak public var btnFacbook: UIButton!
    @IBOutlet weak public var btnGoogle: UIButton!
    @IBOutlet weak public var btnTwitter: UIButton!
    @IBOutlet weak var btnBottomTooltip: UIButton!
    
    public var activityIndicatoryFb:UIActivityIndicatorView!
    public var activityIndicatoryGoogle:UIActivityIndicatorView!
    public var activityIndicatoryTwitter:UIActivityIndicatorView!
    
    var type:RegisterationViewType = .PhoneNumber
    var capacityArray = [String]()
    var selectedCapacityIndex: Int = 0
    
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
        
        
        fieldFirst.returnKeyType = .done
        fieldSecond.returnKeyType = .done
        fieldThird.returnKeyType = .done
        fieldFourth.returnKeyType = .done
        fieldFifth.returnKeyType = .done
        
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
        
    }
    
    open func configurationsCompleted()  {
        
    }
    
    func actionHideKeyboard()  {
        self.view.endEditing(true)
    }
    
    func config(type: RegisterationViewType, assets:RegisterationAssets)  {
        self.type = type
        self.logo.image = assets._logo
        btnTooltip.setImage(assets._tooltip, for: .normal)
        btnBottomTooltip.setImage(assets._tooltip, for: .normal)
        btnNext.setImage(assets._btnNext, for: .normal)
        btnGoogle.setImage(assets._google, for: .normal)
        btnFacbook.setImage(assets._facebook, for: .normal)
        btnTwitter.setImage(assets._twitter, for: .normal)
        btnAction.tintColor = UIColor.appColor(color: .Secondary)
        if type != .NameAndEmail && type != .PasswordAndConfirmPassword  && type != .AddVehicleDetails && type != .BasicInfo && type != .ResetPassUsingPhone{
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
            btnTooltip.isHidden = false
        }
        if type == .AddVehicleDetails{
            addThirdField()
            addFourthField()
            addFifthField()
        }
        if type == .BasicInfo{
            addThirdField()
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
            fieldSecond.placeholder = Bundle.localizedStringFor(key: "auth-enter-phone-no")
            fieldSecond.keyboardType = .numberPad
        case .VerificationCode:
            labelTitle.text = Bundle.localizedStringFor(key: "auth-verification-code")
            fieldSecond.placeholder = Bundle.localizedStringFor(key: "auth-enter-here")
            btnAction.setTitle(Bundle.localizedStringFor(key: "auth-resend-code"), for: .normal)
            fieldSecond.keyboardType = .numberPad
            btnBackToSigup.isHidden = false
        case .NameAndEmail:
            labelTitle.text = Bundle.localizedStringFor(key: "auth-name-and-email")
            fieldFirst.placeholder = Bundle.localizedStringFor(key: "auth-name")
            fieldSecond.placeholder = Bundle.localizedStringFor(key: "auth-email")
            fieldSecond.keyboardType = .emailAddress
        case.Password:
            labelTitle.text = Bundle.localizedStringFor(key: "auth-password")
            fieldSecond.placeholder = Bundle.localizedStringFor(key: "auth-password")
            btnAction.setTitle(Bundle.localizedStringFor(key: "auth-btn-forgot-pass"), for: .normal)
            fieldSecond.isSecureTextEntry = true
        case .PasswordAndConfirmPassword:
            labelTitle.text = Bundle.localizedStringFor(key: "auth-password")
            fieldFirst.placeholder = Bundle.localizedStringFor(key: "auth-password")
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
            fieldSecond.placeholder = Bundle.localizedStringFor(key: "auth-enter-phone-no")
            fieldSecond.keyboardType = .numberPad
        case .AddVehicleDetails:
            labelTitle.text = Bundle.localizedStringFor(key: "auth-add-vehicle-details")
            fieldFirst.placeholder = Bundle.localizedStringFor(key: "auth-make")
            fieldSecond.placeholder = Bundle.localizedStringFor(key: "auth-model")
            fieldThird.placeholder = Bundle.localizedStringFor(key: "auth-year")
            fieldFourth.placeholder = Bundle.localizedStringFor(key: "auth-license-plate")
            fieldFifth.placeholder = Bundle.localizedStringFor(key: "auth-capacity")
            fieldFifth.inputView = showPicker()
            addVehicleRegisterationView()
            fieldThird.keyboardType = .numberPad
            capacityArray = carCapcaityArray()
            fieldFifth.text = capacityArray[0]
        case .BasicInfo:
            labelTitle.text = Bundle.localizedStringFor(key: "auth-basic-info")
            fieldFirst.placeholder = Bundle.localizedStringFor(key: "auth-name")
            fieldSecond.placeholder = Bundle.localizedStringFor(key: "auth-email")
            fieldThird.placeholder = Bundle.localizedStringFor(key: "auth-city")
            labelDriverNationality.text = Bundle.localizedStringFor(key: "auth-saudi-national")
            fieldSecond.keyboardType = .emailAddress
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
        activityIndicatoryGoogle = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        activityIndicatoryGoogle.hidesWhenStopped = true
        activityIndicatoryGoogle.center = btnGoogle.center
        activityIndicatoryTwitter = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        activityIndicatoryTwitter.hidesWhenStopped = true
        activityIndicatoryTwitter.center = btnTwitter.center
        
        btnFacbook.addSubview(activityIndicatoryFb)
        btnGoogle.addSubview(activityIndicatoryGoogle)
        btnTwitter.addSubview(activityIndicatoryTwitter)
    }
    
    func addTargets()  {
        btnAction.addTarget(self, action: #selector(actPrimary(sender:)), for: .touchUpInside)
        btnNext.addTarget(self, action: #selector(actNext(sender:)), for: .touchUpInside)
        btnGoogle.addTarget(self, action: #selector(actGoogleLogin(sender:)), for: .touchUpInside)
        btnFacbook.addTarget(self, action: #selector(actFacebookLogin(sender:)), for: .touchUpInside)
        btnTwitter.addTarget(self, action: #selector(actTwitterLogin(sender:)), for: .touchUpInside)
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
    
    func removeSocialLoginsView()  {
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
    
    func actTwitterLogin(sender: UIButton)  {
        delegate?.actionTwitterLogin?(sender: sender)
    }
    
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
        if textField == fieldFifth{
            let picker = fieldFifth.inputView as! UIPickerView
            picker.selectRow(selectedCapacityIndex, inComponent: 0, animated: false)
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
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return capacityArray.count
    }
    
    public func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 22
    }
    
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return  capacityArray[row]
    }
    
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedCapacityIndex = row
        fieldFifth.text = capacityArray[row]
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        switch type {
        case .PhoneNumber:
            return RegisterationTemplateViewController.handlePhoneNumber(textField: textField, shouldChangeCharactersIn: range, replacementString: string)
        case .VerificationCode:
            return !(textField.text!.count > 5 && (string.count) > range.length)
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
            }
            return true
        default:
            return !(textField.text!.count > 119 && (string.count) > range.length)
        }
    }
    
    public static func handlePhoneNumber(textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        if textField.text!.count == 0 && string == "0"{
//            textField.text! = "92"
//            return false
//        }else if textField.text!.count == 2 && string == "" {
//            textField.text! = ""
//        }
        return !(textField.text!.count > 11 && (string.count) > range.length)
    }
}

//MARK:- Validations
public extension RegisterationTemplateViewController{
    
    public func getPhoneNo() -> String? {
        var isValid = true
        let phoneNumber = fieldSecond.text ?? ""
        
        if phoneNumber.isEmpty {
            isValid = false
        }else if phoneNumber.count != 12{
            isValid = false
        }
        
        if !isValid{
            Alert.showMessage(viewController: self, title: Bundle.localizedStringFor(key: "constant-invalid-input"), msg:   Bundle.localizedStringFor(key: "auth-phone-must-be-twelve-digits"))
            return nil
        }else{
            self.view.endEditing(true)
            return phoneNumber
        }
    }
    
    public func getNameAndEmail() -> [String]?{
        let name = fieldFirst.text ?? ""
        let email = fieldSecond.text ?? ""
        if name.isEmpty{
            Alert.showMessage(viewController: self, title: Bundle.localizedStringFor(key: "constant-invalid-input"), msg: Bundle.localizedStringFor(key: "auth-name-is-required"))
            return nil
        }else if email.isEmpty{
            Alert.showMessage(viewController: self, title: Bundle.localizedStringFor(key: "constant-invalid-input"), msg: Bundle.localizedStringFor(key: "auth-email-is-required"))
            return nil
        }else if !fieldSecond.isValid(exp: .email){
            Alert.showMessage(viewController: self, title: Bundle.localizedStringFor(key: "constant-invalid-input"), msg: Bundle.localizedStringFor(key: "auth-enter-valid-email"))
            return nil
        }
        self.view.endEditing(true)
        return [name,email]
    }
    
    public func getPasswordAndConfirmPassword() -> [String]? {
        let pass = fieldFirst.text ?? ""
        let confirmPass = fieldSecond.text ?? ""
        
        var msg = ""
        if pass.count < 8{
            msg = Bundle.localizedStringFor(key: "auth-pass-must-be-greater-than-seven-char")
        }else if pass.compare(confirmPass) != .orderedSame{
            msg = Bundle.localizedStringFor(key: "auth-pass-and-confirm-pass-donot-match")
        }
        
        if msg.isEmpty{
            self.view.endEditing(true)
            return [pass,confirmPass]
        }else{
            Alert.showMessage(viewController: self, title: Bundle.localizedStringFor(key: "constant-invalid-input"), msg: msg)
            return nil
        }
    }
    
    public func getPin() -> String? {
        let pin = fieldSecond.text ?? ""
        if pin.count == 6{
            self.view.endEditing(true)
            return pin
        }else{
            Alert.showMessage(viewController: self, title: Bundle.localizedStringFor(key: "auth-invalid-pin-title"), msg: Bundle.localizedStringFor(key: "auth-invalid-pin-msg"))
            return nil
        }
    }
    
    public func getPassword() -> String? {
        let pass = fieldSecond.text ?? ""
        if pass.count < 8{
            Alert.showMessage(viewController: self, title: Bundle.localizedStringFor(key: "constant-invalid-input"), msg: Bundle.localizedStringFor(key: "auth-pass-must-be-greater-than-seven-char"))
            return nil
        }else{
            self.view.endEditing(true)
            return pass
        }
    }
    
    /*
    func getEmailorPhoneNo() -> EmailOrPhoneAsset? {
        let phoneNo = getPhoneNo()
        guard phoneNo != nil else {
            return nil
        }
        self.view.endEditing(true)
        return EmailOrPhoneAsset(isResetUsingEmail: false, emailorPhone: phoneNo!)
        /*
        let placeHolder = fieldSecond.placeholder ?? "Email"
        let result = placeHolder.caseInsensitiveCompare("Email")
        switch result{
        case .orderedSame:
            //Email
            let email = fieldSecond.text!
            if !fieldSecond.isValid(exp: .email){
                Alert.showMessage(viewController: self, title: "Invalid Input", msg: "Please enter a valid email address." )
                return nil
            }
            self.view.endEditing(true)
            return EmailOrPhoneAsset(isResetUsingEmail: true, emailorPhone: email)
        default:
            //PhoneNumber
            let phoneNo = getPhoneNo()
            guard phoneNo != nil else {
                return nil
            }
            self.view.endEditing(true)
            return EmailOrPhoneAsset(isResetUsingEmail: false, emailorPhone: phoneNo!)
        }*/
    }
    */
    func getResetPassUsingPhoneAsset() -> ResetPassUsingPhoneAsset? {
        let passAndConfirmPass = getPasswordAndConfirmPassword()
        let verificationCode = fieldThird.text ?? ""
        if passAndConfirmPass == nil{
            return nil
        }else if verificationCode.count != 6{
            Alert.showMessage(viewController: self, title: Bundle.localizedStringFor(key: "auth-invalid-pin-title"), msg: Bundle.localizedStringFor(key: "auth-invalid-pin-msg"))
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
        let name = fieldFirst.text ?? ""
        let email = fieldSecond.text ?? ""
        let city = fieldThird.text ?? ""
        let isSaudiNational = driverNationalitySwitch.isOn
        if name.isEmpty || email.isEmpty || city.isEmpty {
            Alert.showMessage(viewController: self, title: Bundle.localizedStringFor(key: "constant-invalid-input"), msg: Bundle.localizedStringFor(key: "auth-fill-all-fields"))
            return nil
        }else if !fieldSecond.isValid(exp: .email){
            Alert.showMessage(viewController: self, title: Bundle.localizedStringFor(key: "constant-invalid-input"), msg: Bundle.localizedStringFor(key: "auth-fill-all-fields"))
            return nil
        } else{
            self.view.endEditing(true)
            return BasicInfo(name: name, email: email, city: city, isSaudiNational: isSaudiNational)
        }
    }
    
    public func getVehicleDetails() -> VehicleDetails? {
        let make = fieldFirst.text ?? ""
        let model = fieldSecond.text ?? ""
        let yearString = fieldThird.text ?? ""
        let licensePlate = fieldFourth.text ?? ""
        let currentYear = getCurrentYear()
        guard let year = Int(yearString),year <= currentYear  else {
            Alert.showMessage(viewController: self, title: Bundle.localizedStringFor(key: "constant-invalid-input"), msg: Bundle.localizedStringFor(key: "auth-invalid-year"))
            return nil
        }
        if year < RegisterationTemplateViewController.minValidYear{
            let format = Bundle.localizedStringFor(key: "auth-year-must-be-greater-than")
            let minValue = RegisterationTemplateViewController.minValidYear - 1
            Alert.showMessage(viewController: self, title: Bundle.localizedStringFor(key: "constant-invalid-input"), msg: String(format: format,minValue))
            return nil
        }else if make.isEmpty || model.isEmpty || licensePlate.isEmpty {
            Alert.showMessage(viewController: self, title: Bundle.localizedStringFor(key: "constant-invalid-input"), msg: Bundle.localizedStringFor(key: "auth-fill-all-fields"))
            return nil
        }else{
            self.view.endEditing(true)
            return VehicleDetails(make: make, model: model, year: year, licensePlate: licensePlate, selectedCapacityIndex: selectedCapacityIndex)
        }
    }
    
    func getCurrentYear() -> Int {
        let date = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year], from: date)
        return components.year ?? 0
    }
}
