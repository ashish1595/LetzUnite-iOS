//
//  LoginProtocols.swift
//  LetzUnite
//
//  Created by Himanshu on 3/26/18.
//  Copyright © 2018 LetzUnite. All rights reserved.
//

import Foundation
import UIKit


protocol LoginViewProtocol: class {
    var presenter: LoginPresenterProtocol? { get set }
    
    func prepareForAnimation()
    func styleLoginView()
    func animateLoginView()
    
    func animateSignInButton()
    func stopAnimatingSignInButton()

    func animateRegistrationButton()

    func animateResetPasswordButton()
    func stopAnimatingResetPasswordButton()

    func animateConfirmResetPasswordButton()
    func stopAnimatingConfirmResetPasswordButton()

    func showSignInView()
    func showSignInView(With email:String?)
    func showResetPasswordView()
    func showConfirmResetPasswordView()

    func hideSignInView()
    func hideResetPasswordView()
    func hideConfirmResetPasswordView()

    func showMessage(_ message:String?)
    
    func showError()
    func showError(_ message:String?)
    func showLoading()
    func hideLoading()
    
    
}

protocol LoginWireFrameProtocol: class {
    static func createLoginModule() -> UIViewController
    func presentBaseViewScreen(from view: LoginViewProtocol)
    func presentNewUserRegistrationScreen(from view: LoginViewProtocol)
}

protocol LoginPresenterProtocol: class {
    var view: LoginViewProtocol? { get set }
    var interactor: LoginInterectorInputProtocol? { get set }
    var wireFrame: LoginWireFrameProtocol? { get set }
    
    func viewDidLoad()
    func startLoginRequest(With username: String, password: String)
    func startResetPasswordRequest(With emailId: String)
    func startConfirmResetPasswordRequest(email:String, otp: String, newPassword: String, confirmPassword: String)

    func actionLoginButton()
    
    func actionSignInButton()
    func actionStopAnimatingSignInButton()

    func actionForgotPasswordButton()

    func actionResetPasswordButton()
    func actionStopAnimatingResetPasswordButton()

    func actionConfirmResetPasswordButton()
    func actionStopAnimatingConfirmResetPasswordButton()

    func actionBackButton(_ viewType:LoginViewType)
    
    func actionNewUserRegistration()
    func showRegistrationForm()

}

protocol LoginInteractorOutputProtocol: class {
    func didRetrieveLoginUser(_ profile: UserLoginResponse)
    func didResetUserPassword(response: ForgotPasswordResponse)
    func didConfirmResetUserPassword(response: VerifyPasswordResponse)

    func didFailWithError()
    func didFailToLogin(_ message:String?)
    func didFailToResetPassword(_ message:String?)
    func didFailToConfirmResetPassword(_ message:String?)
}

protocol LoginInterectorInputProtocol: class {
    var presenter: LoginInteractorOutputProtocol? { get set }
    var localDatamanager: LoginLocalDataManagerInputProtocol? { get set }
    var remoteDatamanager: LoginRemoteDataManagerInputProtocol? { get set }
    
    func retrieveUser(With username:String, password: String)
    func resetPassword(With emailId:String)
    func confirmResetPassword(email:String, otp:String, newPassword:String, confirmPassword:String)
}

protocol LoginDataManagerInputProtocol: class {
    
    
}

protocol LoginRemoteDataManagerInputProtocol: class {
    var remoteRequestHandler: LoginRemoteDataManagerOutputProtocol? { get set }
    var validationManager: LoginValidationInputProtocol? { get set }

    func retrieveUser(With username:String, password: String)
    func callLoginApi(With validatedParams:Dictionary<String,Any>)

    func resetPassword(With emailId:String)
    func confirmResetPassword(email:String, otp:String, newPassword:String, confirmPassword:String)
}

protocol LoginRemoteDataManagerOutputProtocol: class {
    func onUserRetrieved(_ userProfile: UserLoginResponse)
    func onResetPassword(response: ForgotPasswordResponse)
    func onConfirmResetPassword(response: VerifyPasswordResponse)

    func onError()
    func onError(with message:String?, errorCode:Int? ,endpoint:Endpoint)
}

protocol LoginLocalDataManagerInputProtocol: class {
    var userProfileManager: UserProfileSingleton? { get set }
    var localRequestHandler: LoginLocalDataManagerOutputProtocol? { get set }
    func saveUserProfile(_ loginResponse: UserLoginResponse)
}

protocol LoginLocalDataManagerOutputProtocol: class {
    func onLocalUserRetrieved(_ userProfile: UserProfileSingleton)
    func onLocalDataManagerError()
}

protocol LoginValidationInputProtocol: class{
    var loginValidationHandler: LoginValidationOutputProtocol? {get set}
    func validateLoginParameters(_ email:String?, password:String?, endpoint:Endpoint)
    func validateForgotPasswordParameters(_ email:String?, endpoint:Endpoint)
    func validateConfirmPasswordParameters(email:String?, otp:String?, password:String?, confirmPassword:String? ,endpoint:Endpoint)
}

protocol LoginValidationOutputProtocol: class{
    func didValidate(_ parameters:Dictionary<String,Any>, endpoint:Endpoint)
    func didValidateWithError(_ errorMessage:String, endpoint:Endpoint)
}
