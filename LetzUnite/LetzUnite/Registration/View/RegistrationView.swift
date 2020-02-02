//
//  RegistrationView.swift
//  LetzUnite
//
//  Created by Himanshu on 3/26/18.
//  Copyright © 2018 LetzUnite. All rights reserved.
//

import UIKit
import IQActionSheetPickerView

enum RegistrationPickerType {
    case dateOfBirth
    case genderPicker
}

class RegistrationView: UIViewController {
    
    @IBOutlet var topBarTitle: UILabel!
    @IBOutlet var textField_fullName: RadiantTextField!
    @IBOutlet var textfield_email: RadiantTextField!
    @IBOutlet var textfield_mobile: RadiantTextField!
    @IBOutlet var textfield_password: RadiantTextField!
    @IBOutlet var textfield_confirmPassword: RadiantTextField!

    @IBOutlet var scrollVw_registration: UIScrollView!
    
    var genderPickerPickerData: [String] = ["Male","Female"]

    var presenter: RegistrationPresenterProtocol?
    
    @IBOutlet var button_back: UIButton!
    @IBOutlet var button_registerUser: TKTransitionSubmitButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter?.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        presenter?.viewDidAppear()//need to remove this
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showPicker( pickerType:RegistrationPickerType) {
        switch pickerType {
        case .dateOfBirth:
            let picker = IQActionSheetPickerView.init(title: "Date", delegate: self)
            picker.actionSheetPickerStyle = .datePicker
            picker.tag = 0
            picker.show()
        case .genderPicker:
            let picker = IQActionSheetPickerView.init(title: "Gender", delegate: self)
            picker.titlesForComponents = [genderPickerPickerData]
            picker.actionSheetPickerStyle = .textPicker
            picker.tag = 1
            picker.show()
        }
    }
    
    @IBAction func actionBack(_ sender: Any) {
        presenter?.backToPreviousScreen()
    }
    
    @IBAction func actionRegisterUser(_ sender: Any) {
        
        presenter?.actionStartAnimatingRegistrationButton()
        
        var user : UserProfileModel  = UserProfileModel.init()
        
        //user.firstname  =    textField_fname.text
        //user.lastname   =    textField_lname.text
        
        user.username   =   textField_fullName.text
        user.email      =   textfield_email.text
        user.mobile     =   textfield_mobile.text
        user.password   =   textfield_password.text
        user.confirmPassword = textfield_confirmPassword.text
        
        //user.dob        =    textfield_dob.text
        //user.gender     =    textfield_gender.text == "Male" ? "M": "F"
        //user.height     =    textfield_height.text
        //user.weight     =       textfield_width.text
        //user.country    =    textfield_country.text == "Malaysia" ?  "129": "129"

        presenter?.registerUser(With: user)
    }
}

extension RegistrationView: RegistrationViewProtocol {
    func showError(_ message: String?) {
        Utility.showToast(with: message)
    }
    
    func styleRegistrationView() {
        self.button_registerUser.layer.borderColor = appThemeColor.cgColor
        self.button_registerUser.layer.cornerRadius = self.button_registerUser.frame.size.height/2
    }
    
    func animateRegistrationView(){
        
    }
    
    func startAnimatingRegistrationButton() {
        let button = button_registerUser
        button?.startLoadingAnimation()
    }
    
    func stopAnimatingRegistrationButton() {
        let button = button_registerUser
        button?.startFinishAnimation(0.2, CAMediaTimingFunction.init(name: kCAMediaTimingFunctionDefault), completion: nil)
    }
    
    func showError() {
        
    }
    
    func showLoading() {
        
    }
    
    func hideLoading() {
        
    }
    
}

extension RegistrationView: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        UIView.animate(withDuration: 0.5) {
            if (textField.frame.origin.y - self.scrollVw_registration.center.y) > 0 {
                self.scrollVw_registration.contentOffset = CGPoint(x: self.scrollVw_registration.contentOffset.x, y: textField.frame.origin.y - self.scrollVw_registration.center.y + textField.frame.size.height/2)
            }else {
                self.scrollVw_registration.contentOffset = CGPoint(x: 0, y: 0)
            }
        }

        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        
        if textField == self.textfield_email {
            if textField.text?.count == 0 || String.validateEmailWithString(checkString: textField.text!) {
                textField.resignFirstResponder()
            }else {
                return false
            }
        }
        
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        UIView.animate(withDuration: 0.5) {
            self.scrollVw_registration.contentOffset = CGPoint(x: 0, y: 0)
        }
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        guard let text = textField.text else { return true }
        
        let newLength = text.count + string.count - range.length
        
        if textField == self.textField_fullName {
            return newLength <= registration_fullname_max_length
        }else if textField == self.textfield_email {
           return newLength <= registration_email_max_length
        }else if textField == self.textfield_mobile {
            return newLength <= registration_mobile_num_equals
        }else if textField == self.textfield_password {
            return newLength <= registration_password_max_length
        }else if textField == self.textfield_confirmPassword {
            return newLength <= registration_password_max_length
        }
 
        return true
    }
}

extension RegistrationView: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if(self.scrollVw_registration.contentOffset.y > 46) {
            UIView.animate(withDuration: 0.5, animations: {
                self.topBarTitle.alpha = 1.0
            })
        }else {
            UIView.animate(withDuration: 0.5, animations: {
                self.topBarTitle.alpha = 0.0
            })
        }
    }
    
}

extension RegistrationView: IQActionSheetPickerViewDelegate {
    
    func actionSheetPickerView(_ pickerView: IQActionSheetPickerView, didSelectTitlesAtIndexes indexes: [NSNumber]) {
        switch pickerView.tag {
        case 1:
            let index:Int = Int(truncating: indexes[0])
            print(index)
            //self.textfield_gender.text = genderPickerPickerData[index]
        default:
            print("")
        }
    }
    
    func actionSheetPickerView(_ pickerView: IQActionSheetPickerView, didSelect date: Date) {
        let formatter = DateFormatter.init()
        formatter.dateFormat = "YYYY-MM-dd"
        //self.textfield_dob.text = formatter.string(from: date)
    }
    
}


