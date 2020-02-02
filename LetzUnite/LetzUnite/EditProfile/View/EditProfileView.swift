//
//  EditProfileView.swift
//  LetzUnite
//
//  Created by B0081006 on 6/24/18.
//  Copyright © 2018 Airtel. All rights reserved.
//

import UIKit

class EditProfileView: UIViewController {

    var presenter: EditProfilePresenterProtocol?
    var navView:NavigationBarView?
    @IBOutlet var scrollVw_updateProfile: UIScrollView!
    @IBOutlet var buttonUpdateProfile: TKTransitionSubmitButton!
    
    @IBOutlet var textField_name: RadiantTextField!
    @IBOutlet var textField_email: RadiantTextField!
    @IBOutlet var textField_mobile: RadiantTextField!
    @IBOutlet var textField_bloodGroup: RadiantTextField!
    @IBOutlet var imgVw_profilePicture: CircularImageView!
    
    @IBOutlet var label_editProfile: UILabel!
    @IBOutlet var label_editProfileTitle: UILabel!
    
    @IBOutlet var buttonEditPicture: UIButton!
    let picker = UIImagePickerController()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func actionBack(_ sender: Any) {
        presenter?.popToProfileScreen()
    }
    
    @IBAction func actionEditPicture(_ sender: Any) {
        AppAlert.showAlertWith(message: nil, buttonTitles: ["Camera","Gallery"], delegate: self)
    }
    
    func setupNavigationBar() {
        navView = NavigationBarView.init(navType: .kDetailNav, frame: CGRect(x: 0, y: UIApplication.shared.statusBarFrame.height, width: self.view.bounds.size.width, height: 56))
        navView?.delegate = self
        navView?.label_detailTitle.alpha = 0
        navView?.label_detailTitle.text = "Edit Profile"
        navView?.label_detailTitle.isHidden = true
        navView?.layoutIfNeeded()
        self.navView?.backgroundColor = UIColor.white
        self.view.addSubview(navView!)
        self.view.bringSubview(toFront: self.label_editProfileTitle)
    }
    
    @IBAction func actionUpdateProfile(_ sender: Any) {
        self.animateUpdateButton()
        var user : UserProfileModel  = UserProfileModel.init()
        user.username = "Himz"
        user.email = "proyadav@gmail.com"
        user.mobile = "8800465004"
        user.password = "11111"
        user.confirmPassword = "11111"
        presenter?.updateProfile(with: user)
    }
    
    func animateUpdateButton() {
        let button = buttonUpdateProfile
        button?.startLoadingAnimation()
        
    }
    
    func stopAnimatingUpdateButton() {
        let button = buttonUpdateProfile
        button?.startFinishAnimation(0.3, CAMediaTimingFunction.init(name: kCAMediaTimingFunctionDefault), completion: nil)
    }
    
    func showImagePickerControllerWith(tag: Int?) {
        picker.allowsEditing = true
        if tag == 0 {
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                picker.sourceType = UIImagePickerControllerSourceType.camera
                picker.cameraCaptureMode = .photo
                picker.modalPresentationStyle = .fullScreen
            } else {
                AppToast.showToast(with: "No camera available.")
                return
            }
        }else {
            picker.sourceType = .photoLibrary
            picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
            picker.modalPresentationStyle = .fullScreen
        }
        picker.delegate = self
        present(picker, animated: true, completion: nil)
    }
}

extension EditProfileView: EditProfileViewProtocol {
    
    func prepareForAnimation() {
        
    }
    
    func styleEditView() {
        self.setupNavigationBar()
        self.buttonUpdateProfile.layer.borderColor = appThemeColor.cgColor
        self.buttonUpdateProfile.layer.cornerRadius = self.buttonUpdateProfile.frame.size.height/2
    }
    
    func animateEditView() {
        
    }
    
    func showMessage(_ message:String?) {
        Utility.showToast(with: message)
    }
    
    func showError(_ message: String?) {
        Utility.showToast(with: message)
    }
    
    func showLoading() {
        
    }
    
    func hideLoading() {
        self.stopAnimatingUpdateButton()
    }
    
    func updateView(With parameters: UserProfileModel) {

    }
}

extension EditProfileView: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        UIView.animate(withDuration: 0.5) {
            if (textField.frame.origin.y - self.scrollVw_updateProfile.center.y) > 0 {
                self.scrollVw_updateProfile.contentOffset = CGPoint(x: self.scrollVw_updateProfile.contentOffset.x, y: textField.frame.origin.y - self.scrollVw_updateProfile.center.y + textField.frame.size.height/2)
            }else {
                self.scrollVw_updateProfile.contentOffset = CGPoint(x: 0, y: 0)
            }
        }
        
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        
        if textField == self.textField_email {
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
            self.scrollVw_updateProfile.contentOffset = CGPoint(x: 0, y: 0)
        }
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        guard let text = textField.text else { return true }
        
        let newLength = text.count + string.count - range.length
        
        if textField == self.textField_name {
            return newLength <= registration_fullname_max_length
        }else if textField == self.textField_email {
            return newLength <= registration_email_max_length
        }else if textField == self.textField_mobile {
            return newLength <= registration_mobile_num_equals
        }
        
        return true
    }
}

extension EditProfileView: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if(self.scrollVw_updateProfile.contentOffset.y > 46) {
            UIView.animate(withDuration: 0.5, animations: {
                self.label_editProfileTitle.alpha = 1.0
                self.label_editProfile.alpha = 0.0
            })
        }else {
            UIView.animate(withDuration: 0.5, animations: {
                self.label_editProfileTitle.alpha = 0.0
                self.label_editProfile.alpha = 1.0
            })
        }
    }
    
}


extension EditProfileView: NavigationBarProtocol {
    func didPressBackButton() {
        presenter?.popToProfileScreen()
    }
}

extension EditProfileView: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        var  chosenImage = UIImage()
        chosenImage = info[UIImagePickerControllerEditedImage] as! UIImage
        self.imgVw_profilePicture.image = chosenImage
        self.imgVw_profilePicture.contentMode = UIViewContentMode.scaleAspectFill
        dismiss(animated:true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}

extension EditProfileView: AppAlertProtocol {
    func didPressButtonWith(title: String?, clickedIndex: String?) {
        if let index = clickedIndex {
            if index == "0" {
                //Camera
                self.showImagePickerControllerWith(tag: Int(index))
            }else if index == "1" {
                //Gallery
                self.showImagePickerControllerWith(tag: Int(index))
            }
        }
        print("\(String(describing: title)) \(String(describing: clickedIndex))")
    }
}

