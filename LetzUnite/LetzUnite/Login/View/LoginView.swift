//
//  LoginView.swift
//  LetzUnite
//
//  Created by Himanshu on 3/26/18.
//  Copyright © 2018 LetzUnite. All rights reserved.
//

import UIKit
import ZCAnimatedLabel
import ImageSlideshow

enum LoginViewType {
    case landing
    case signIn
    case resetPassword
    case confirmResetPassword
}

class LoginView: UIViewController {
    
    //main container containing signin & reset password
    @IBOutlet var view_signInContainer: UIView!

    @IBOutlet var scroll_signIn: UIScrollView!
    @IBOutlet var button_signIn: TKTransitionSubmitButton!
    @IBOutlet var textField_emailSignIn: UITextField!
    @IBOutlet var textField_passwordSignIn: UITextField!
    
    @IBOutlet var scroll_resetPassword: UIScrollView!
    @IBOutlet var button_resetPassword: TKTransitionSubmitButton!
    @IBOutlet var label_loginScreenTitle: UILabel!
    @IBOutlet var textfield_emailResetPassword: RadiantTextField!
    
    
    @IBOutlet var scroll_confirmResetPassword: UIScrollView!
    @IBOutlet var textField_otp: RadiantTextField!
    @IBOutlet var textField_newPassword: RadiantTextField!
    @IBOutlet var textField_confirmPassword: RadiantTextField!
    @IBOutlet var button_confirmReset: TKTransitionSubmitButton!
    
    
    //app tour slide show
    @IBOutlet var view_imageSlideshow: ImageSlideshow!
    
    @IBOutlet var imgVw_logo: UIImageView!
    @IBOutlet var imgVw_logoText: UIImageView!
    @IBOutlet var view_imageViewer: UIView!
    @IBOutlet var imgVw_imageViewer: UIImageView!
    @IBOutlet var pageControl_imageViewer: UIPageControl!
    @IBOutlet var label_animatedText: ZCAnimatedLabel!
    @IBOutlet var button_login: UIButton!
    @IBOutlet var button_newUserRegistration: TKTransitionSubmitButton!
    
    //upper logo
    @IBOutlet var constraint_upperLogoTop: NSLayoutConstraint!
    @IBOutlet var constraint_upperLogoLeading: NSLayoutConstraint!
    @IBOutlet var constraint_upperLogoWidth: NSLayoutConstraint!
    @IBOutlet var constraint_upperLogoHeight: NSLayoutConstraint!
    @IBOutlet var constraint_upperLogoBottom: NSLayoutConstraint!
    @IBOutlet var constraint_upperLogoTrailing: NSLayoutConstraint!
    @IBOutlet var constraint_upperLogoCenterHorizontally: NSLayoutConstraint!
    //upper logo text
    @IBOutlet var constraint_upperTextHeight: NSLayoutConstraint!
    @IBOutlet var constraint_upperTextTrailing: NSLayoutConstraint!
    
    //center logo
    @IBOutlet var constraint_centerLogoAspectRatio: NSLayoutConstraint!
    @IBOutlet var constraint_centerLogoBottom: NSLayoutConstraint!
    @IBOutlet var constraint_centerLogoCenterHz: NSLayoutConstraint!
    @IBOutlet var constraint_centerLogoCenterVt: NSLayoutConstraint!
    //center logo text
    @IBOutlet var constraint_centerTextCenter: NSLayoutConstraint!
    @IBOutlet var constraint_centerTextAspectRatio: NSLayoutConstraint!
 
    var currentViewType:LoginViewType = .landing
    
    var presenter: LoginPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Helpers

    
    //MARK: Actions
    @IBAction func action_newUserRegistration(_ sender: Any) {
        presenter?.actionNewUserRegistration()
    }
    
    @IBAction func actionLogin(_ sender: Any) {
        presenter?.actionLoginButton()
    }
    
    @IBAction func actionBack(_ sender: Any) {
        presenter?.actionBackButton(currentViewType)
    }
    
    @IBAction func actionSignIn(_ sender: Any) {
        presenter?.actionSignInButton()
    }
    
    @IBAction func actionForgotPassword(_ sender: Any) {
        presenter?.actionForgotPasswordButton()
    }
    
    @IBAction func actionResetPassword(_ sender: Any) {
        presenter?.actionResetPasswordButton()
    }
    
    @IBAction func actionConfirmResetPassword(_ sender: Any) {
        presenter?.actionConfirmResetPasswordButton()
    }
    
}

extension LoginView: LoginViewProtocol {
    
    func prepareForAnimation() {

        self.button_login.alpha = 0
        self.button_newUserRegistration.alpha = 0
        
        self.imgVw_imageViewer.transform = CGAffineTransform(scaleX: 0.02, y: 0.02)

        self.view.setNeedsLayout()
        self.view.layoutIfNeeded()

        //To display first animated text in image slide show
        self.label_animatedText?.animationDuration = 0.3
        self.label_animatedText?.animationDelay = 0.04
        object_setClass(self.label_animatedText, ZCSpinLabel.classForCoder())
        self.label_animatedText?.backgroundColor = UIColor.clear
        self.label_animatedText?.onlyDrawDirtyArea = true
        self.label_animatedText?.layerBased = false
        self.label_animatedText?.text = "Blood anytime, anywhere"
        
        let style = NSMutableParagraphStyle()
        style.alignment = .center
        let mutableString = NSMutableAttributedString(string: (self.label_animatedText?.text)!, attributes: [NSAttributedStringKey.font : UIFont(
            name: "Georgia",
            size: 30)!, NSAttributedStringKey.foregroundColor:UIColor.black, NSAttributedStringKey.paragraphStyle:style])
        
        self.label_animatedText?.attributedString = mutableString
        self.label_animatedText?.setNeedsDisplay()
        
        //image-slideshow images
        self.view_imageSlideshow.slideshowInterval = 4.0
    }
    
    func styleLoginView() {
        self.button_newUserRegistration.backgroundColor = appThemeColor
        self.button_newUserRegistration.layer.cornerRadius = self.button_newUserRegistration.frame.size.height/2
        self.button_signIn.backgroundColor = appThemeColor
        self.button_signIn.layer.cornerRadius = self.button_signIn.frame.size.height/2
        self.button_resetPassword.backgroundColor = appThemeColor
        self.button_resetPassword.layer.cornerRadius = self.button_resetPassword.frame.size.height/2
        self.button_confirmReset.backgroundColor = appThemeColor
        self.button_confirmReset.layer.cornerRadius = self.button_confirmReset.frame.size.height/2
    }
    
    func animateLoginView() {
        
        var moved = false
        
        UIView.animate(withDuration: 1.0, animations: {
            self.constraint_centerLogoBottom.isActive = moved
            self.constraint_centerLogoCenterHz.isActive = moved
            self.constraint_centerLogoCenterVt.isActive = moved
            self.constraint_centerLogoAspectRatio.isActive = moved
            
            self.constraint_centerTextCenter.isActive = moved
            self.constraint_centerTextAspectRatio.isActive = moved
            
            self.constraint_upperLogoTop.isActive = !moved
            self.constraint_upperLogoWidth.isActive = !moved
            self.constraint_upperLogoBottom.isActive = !moved
            self.constraint_upperLogoHeight.isActive = !moved
            self.constraint_upperLogoLeading.isActive = !moved
            self.constraint_upperLogoTrailing.isActive = !moved
            self.constraint_upperLogoCenterHorizontally.isActive = !moved
            self.constraint_upperTextHeight.isActive = !moved
            self.constraint_upperTextTrailing.isActive = !moved
            
            self.view.setNeedsLayout()
            self.view.layoutIfNeeded()
            
            self.imgVw_imageViewer.alpha = 0.5

            //self.imgVw_imageViewer.transform = CGAffineTransform(scaleX: 0.3, y: 0.3)
            
        }) { (completed) in
 
            self.imgVw_imageViewer.alpha = 1.0

            UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.0, options: .transitionCrossDissolve, animations: {
                
                self.imgVw_imageViewer.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)

                
            }, completion: { (completed) in
 
                UIView.animate(withDuration: 1.1, animations: {
                    self.button_newUserRegistration.alpha = 1.0
                    self.button_login.alpha = 1.0
                })
                
                UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .curveLinear, animations: {
                    
                    self.label_animatedText.alpha = 1.0

                    self.imgVw_imageViewer.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)

                    DispatchQueue.global(qos: .userInteractive).async {
                        DispatchQueue.main.async {
                            
                            let style = NSMutableParagraphStyle()
                            //style.lineSpacing = 5
                            style.alignment = .center
                            
                            let mutableString = NSMutableAttributedString(string: (self.label_animatedText?.text)!, attributes: [NSAttributedStringKey.font : UIFont(
                                name: "Georgia",
                                size: 18)!, NSAttributedStringKey.foregroundColor:UIColor.black, NSAttributedStringKey.paragraphStyle:style])
                            self.label_animatedText?.attributedString = mutableString
                            //self.label_animatedText.sizeToFit()
                            self.label_animatedText?.startAppearAnimation()
                            //self.label_animatedText.backgroundColor = .red
                        }
                        
                    }
                    
                    
                }, completion: { (completed) in
                    
                    UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .curveLinear, animations: {
                        
                        self.pageControl_imageViewer.alpha = 1.0
                        self.imgVw_imageViewer.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)

                    }, completion: { (completed) in
                        
                        self.imgVw_imageViewer.alpha = 0.0
                        self.view_imageSlideshow.alpha = 1.0
                        
                        let localSource = [ImageSource(imageString: "apptour")!, ImageSource(imageString: "apptour1")!, ImageSource(imageString: "apptour2")!, ImageSource(imageString: "apptour3")!]
                        self.view_imageSlideshow.setImageInputs(localSource)
                        
                        let localSourceMessages = ["Blood anytime, anywhere", "Blood anytime, anywhere 2", "Blood anytime, anywhere 3", "Blood anytime, anywhere 4"]

                        
                        self.view_imageSlideshow.currentPageChanged = { page in
                            print("current page:", page)
                    
                            DispatchQueue.global(qos: .userInteractive).async {
                                DispatchQueue.main.async {
                                    
                                    self.pageControl_imageViewer.currentPage = page
                                    
                                    let style = NSMutableParagraphStyle()
                                    //style.lineSpacing = 5
                                    style.alignment = .center
                                    
                                    let mutableString = NSMutableAttributedString(string: (localSourceMessages[page]), attributes: [NSAttributedStringKey.font : UIFont(
                                        name: "Georgia",
                                        size: 18)!, NSAttributedStringKey.foregroundColor:UIColor.black, NSAttributedStringKey.paragraphStyle:style])
                                    self.label_animatedText?.attributedString = mutableString
                                    //self.label_animatedText.sizeToFit()
                                self.label_animatedText?.startAppearAnimation()
                                    //self.label_animatedText.backgroundColor = .red
                                    
                                }
                                
                            }
                        }
                        
                    })
                })
                
            })
            
        }
    
        moved = true
    }
 
    func animateSignInButton() {
        let button = button_signIn
        button?.startLoadingAnimation()
        self.presenter?.startLoginRequest(With: self.textField_emailSignIn.text!, password: self.textField_passwordSignIn.text!)
    }
    
    func stopAnimatingSignInButton() {
        let button = button_signIn
        button?.startFinishAnimation(0.3, CAMediaTimingFunction.init(name: kCAMediaTimingFunctionDefault), completion: nil)
    }
    
    func animateRegistrationButton() {
        let button = button_newUserRegistration
        button?.animate(0.5, CAMediaTimingFunction.init(name: kCAMediaTimingFunctionDefault), completion: {
            self.presenter?.showRegistrationForm()
        })
    }
    
    func animateResetPasswordButton() {
        let button = button_resetPassword
        button?.startLoadingAnimation()
        self.presenter?.startResetPasswordRequest(With: self.textfield_emailResetPassword.text!)
    }
    
    func stopAnimatingResetPasswordButton() {
        let button = button_resetPassword
        button?.startFinishAnimation(0.3, CAMediaTimingFunction.init(name: kCAMediaTimingFunctionDefault), completion: nil)
    }
    
    func animateConfirmResetPasswordButton() {
        let button = button_confirmReset
        button?.startLoadingAnimation()
        self.presenter?.startConfirmResetPasswordRequest(email: self.textfield_emailResetPassword.text!, otp: self.textField_otp.text!, newPassword: self.textField_newPassword.text!, confirmPassword: self.textField_confirmPassword.text!)
    }
    
    func stopAnimatingConfirmResetPasswordButton() {
        let button = button_confirmReset
        button?.startFinishAnimation(0.3, CAMediaTimingFunction.init(name: kCAMediaTimingFunctionDefault), completion: nil)
    }

    func showSignInView() {
        self.view.endEditing(true)
        self.view_signInContainer.isHidden = false
        self.view_signInContainer.alpha = 1
        self.scroll_signIn.isHidden = false
        self.scroll_signIn.alpha = 0
        self.scroll_resetPassword.isHidden = true
        self.scroll_confirmResetPassword.isHidden = true
        self.view.bringSubview(toFront: self.scroll_signIn)
        currentViewType = .signIn
        self.label_loginScreenTitle.text = "Sign in"
        UIView.animate(withDuration: 0.6) {
            self.scroll_signIn.alpha = 1
        }
    }
    
    func showSignInView(With email:String?) {
        self.showSignInView()
        self.textField_emailSignIn.text = email
    }
    
    func showResetPasswordView() {
        self.view.endEditing(true)
        self.view_signInContainer.isHidden = false
        self.scroll_signIn.isHidden = true
        self.scroll_resetPassword.isHidden = false
        self.scroll_resetPassword.alpha = 0
        self.scroll_confirmResetPassword.isHidden = true
        self.view.bringSubview(toFront: self.scroll_resetPassword)
        currentViewType = .resetPassword
        self.label_loginScreenTitle.text = "Reset password"
        UIView.animate(withDuration: 0.6) {
            self.scroll_resetPassword.alpha = 1
        }
    }
    
    func showConfirmResetPasswordView() {
        self.view.endEditing(true)
        self.view_signInContainer.isHidden = false
        self.scroll_signIn.isHidden = true
        self.scroll_resetPassword.isHidden = true
        self.scroll_confirmResetPassword.isHidden = false
        self.scroll_confirmResetPassword.alpha = 0
        self.view.bringSubview(toFront: self.scroll_confirmResetPassword)
        currentViewType = .confirmResetPassword
        self.label_loginScreenTitle.text = "Reset password"
        UIView.animate(withDuration: 0.6) {
            self.scroll_confirmResetPassword.alpha = 1
        }
    }
    
    func hideConfirmResetPasswordView() {
        self.scroll_confirmResetPassword.isHidden = true
        self.view.bringSubview(toFront: self.scroll_confirmResetPassword)
    }
    
    func hideSignInView() {
        self.view.endEditing(true)
        self.scroll_resetPassword.isHidden = true
        self.scroll_confirmResetPassword.isHidden = true
        self.scroll_signIn.alpha = 1
        self.view_signInContainer.alpha = 1
        UIView.animate(withDuration: 0.6, animations: {
            self.scroll_signIn.alpha = 0
            self.view_signInContainer.alpha = 0
        }) { (completed) in
            self.scroll_signIn.isHidden = true
            self.view_signInContainer.isHidden = true
        }
        currentViewType = .landing
    }
    
    func hideResetPasswordView() {
        self.scroll_resetPassword.isHidden = true
        self.view.bringSubview(toFront: self.scroll_resetPassword)
    }
    
    func showMessage(_ message: String?) {
        if let msg = message {
            Utility.showToast(with: msg)
        }
    }
    
    func showError() {
        
    }
    
    func showLoading() {
        
    }
    
    func hideLoading() {
        
    }
    
    func showError(_ message: String?) {
        if let msg = message {
            Utility.showToast(with: msg)
        }
    }
}

extension LoginView: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}

extension LoginView: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if(scrollView.contentOffset.y > 46) {
            UIView.animate(withDuration: 0.5, animations: {
                self.label_loginScreenTitle.alpha = 1.0
            })
        }else {
            UIView.animate(withDuration: 0.5, animations: {
                self.label_loginScreenTitle.alpha = 0.0
            })
        }
    }
    
}

