//
//  CreateRequestView.swift
//  LetzUnite
//
//  Created by Himanshu on 4/4/18.
//  Copyright © 2018 LetzUnite. All rights reserved.
//

import UIKit

class CreateRequestView: UIViewController {

    @IBOutlet var buttonDismiss: UIButton!
    var presenter: CreateRequestPresenterProtocol?
    @IBOutlet var label_bloodRequestTitle: UILabel!
    @IBOutlet var label_bloodRequest: UILabel!
    var navView:NavigationBarView?
    @IBOutlet var scrollVw_createBloodRequest: UIScrollView!
    @IBOutlet var scrollVw_availableHours: UIScrollView!
    @IBOutlet var scrollVw_bloodTypes: UIScrollView!
    @IBOutlet var textField_mobile: RadiantTextField!
    @IBOutlet var textField_disease: RadiantTextField!
    @IBOutlet var textField_hospitalContactPersonName: RadiantTextField!
    @IBOutlet var textField_hospitalName: RadiantTextField!
    @IBOutlet var textField_hospitalAddress: RadiantTextField!
    @IBOutlet var buttonCreateBloodRequest: TKTransitionSubmitButton!
    
    var bloodRequest = BloodRequestModel.init()

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        // Do any additional setup after loading the view.        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func actionDismiss(_ sender: Any) {
        presenter?.dismiss(self)
    }
    
    
    @objc func actionSelectHour(_ sender: Any) {
        let button:UIButton = sender as! UIButton
        self.styleHourSelection()
        button.backgroundColor = .red
        button.setTitleColor(.white, for: .normal)
        bloodRequest.availableHours = button.titleLabel?.text
    }
    
    @objc func actionSelectBlood(_ sender: Any) {
        let button:UIButton = sender as! UIButton
        self.styleBloodSelection()
        button.backgroundColor = .red
        button.setTitleColor(.white, for: .normal)
        bloodRequest.bloodType = button.titleLabel?.text
    }
    
    func styleHourSelection() {
        for item in self.scrollVw_availableHours.subviews {
            if let button:UIButton = item as? UIButton {
                button.layer.cornerRadius = button.frame.size.height/2
                button.backgroundColor = UIColor.init(red: 244.0/255.0, green: 244.0/255.0, blue: 244.0/255.0, alpha: 1.0)
                button.setTitleColor(.black, for: .normal)
                button.addTarget(self, action: #selector(actionSelectHour(_:)), for: UIControlEvents.touchUpInside)
            }
        }
    }
    
    func styleBloodSelection() {
        for item in self.scrollVw_bloodTypes.subviews {
            if let button:UIButton = item as? UIButton {
                button.layer.cornerRadius = button.frame.size.height/2
                button.backgroundColor = UIColor.init(red: 244.0/255.0, green: 244.0/255.0, blue: 244.0/255.0, alpha: 1.0)
                button.setTitleColor(.black, for: .normal)
                button.addTarget(self, action: #selector(actionSelectBlood(_:)), for: UIControlEvents.touchUpInside)
            }
        }
    }
    
    
    
    func setupNavigationBar() {
        navView = NavigationBarView.init(navType: .kDetailNav, frame: CGRect(x: 0, y: UIApplication.shared.statusBarFrame.height, width: self.view.bounds.size.width, height: 56))
        navView?.delegate = self
        navView?.label_detailTitle.text = "Blood Profile"
        navView?.label_detailTitle.isHidden = true
        navView?.label_detailTitle.alpha = 0
        navView?.layoutIfNeeded()
        navView?.buttonBack.isHidden = false
        self.navView?.backgroundColor = UIColor.white
        self.view.addSubview(navView!)
        self.view.bringSubview(toFront: self.label_bloodRequestTitle)
    }
    
    func createBloodRequest() {
        bloodRequest.location = "Delhi"
        bloodRequest.city = "Gurgaon"
        bloodRequest.state = "Delhi"
        bloodRequest.latitude = "28.4706"
        bloodRequest.longitude = "77.5053"

        bloodRequest.contactPersonNumber = self.textField_mobile.text
        bloodRequest.disease = self.textField_disease.text
        bloodRequest.hospitalContactPerson = self.textField_hospitalContactPersonName.text
        bloodRequest.hospitalName = self.textField_hospitalName.text
        bloodRequest.patientName = "Ashish"
        presenter?.createBloodRequest(With: bloodRequest)
    }
    
    @IBAction func actionCreateBloodRequest(_ sender: Any) {
        self.createBloodRequest()
    }
}


extension CreateRequestView: CreateRequestViewProtocol {
    
    func prepareForAnimation() {
        
    }
    
    func styleCreateBloodRequestView() {
        self.setupNavigationBar()
        self.buttonCreateBloodRequest.layer.borderColor = appThemeColor.cgColor
        self.buttonCreateBloodRequest.layer.cornerRadius = self.buttonCreateBloodRequest.frame.size.height/2
        self.styleHourSelection()
        self.styleBloodSelection()
        for item in self.scrollVw_bloodTypes.subviews {
            item.layer.cornerRadius = item.frame.size.height/2
        }
    }
    
    func animateCreateBloodRequestView() {
        
    }
    
    func showError(_ message: String?) {
        Utility.showToast(with: message)
    }
    
    func showMessage(_ message: String?) {
        Utility.showToast(with: message)
    }
    
    func showLoading() {
        
    }
    
    func hideLoading() {
        
    }
    
    func updateView(With parameters: BloodRequestResponse?) {
        /*
         need to update view using response or can show message in showmessage method
         */
    }
}

extension CreateRequestView: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        UIView.animate(withDuration: 0.5) {
            if (textField.frame.origin.y - self.scrollVw_createBloodRequest.center.y) > 0 {
                self.scrollVw_createBloodRequest.contentOffset = CGPoint(x: self.scrollVw_createBloodRequest.contentOffset.x, y: textField.frame.origin.y - self.scrollVw_createBloodRequest.center.y + textField.frame.size.height/2)
            }else {
                self.scrollVw_createBloodRequest.contentOffset = CGPoint(x: 0, y: 0)
            }
        }
        
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        UIView.animate(withDuration: 0.5) {
            self.scrollVw_createBloodRequest.contentOffset = CGPoint(x: 0, y: 0)
        }
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        guard let text = textField.text else { return true }
        
        let newLength = text.count + string.count - range.length
        
        //check count
        
        return true
    }
}

extension CreateRequestView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if self.scrollVw_createBloodRequest == scrollView {
            if(self.scrollVw_createBloodRequest.contentOffset.y > 46) {
                UIView.animate(withDuration: 0.2, animations: {
                    self.label_bloodRequestTitle.alpha = 1.0
                    self.label_bloodRequest.alpha = 0.0
                })
            }else {
                UIView.animate(withDuration: 0.5, animations: {
                    self.label_bloodRequestTitle.alpha = 0.0
                    self.label_bloodRequest.alpha = 1.0
                })
            }
        }
    }
}

extension CreateRequestView: NavigationBarProtocol {
    func didPressBackButton() {
        presenter?.dismiss(self)
    }
}

