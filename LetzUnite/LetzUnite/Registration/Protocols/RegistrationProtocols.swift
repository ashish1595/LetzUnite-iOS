//
//  RegistrationProtocols.swift
//  LetzUnite
//
//  Created by Himanshu on 3/26/18.
//  Copyright © 2018 LetzUnite. All rights reserved.
//

import Foundation
import UIKit

protocol RegistrationViewProtocol: class {
    var presenter: RegistrationPresenterProtocol? { get set }
    
    func styleRegistrationView()
    func animateRegistrationView()
    func startAnimatingRegistrationButton()
    func stopAnimatingRegistrationButton()

    func showError()
    func showError(_ message:String?)

    func showLoading()
    func hideLoading()
}

protocol RegistrationWireFrameProtocol: class {
    static func createRegistrationModule() -> UIViewController
    func presentBaseViewScreen(from view: RegistrationViewProtocol, forUser username: String)
    func popToLoginScreen(from view: RegistrationViewProtocol)
    func popToLoginScreenAndShowSignInView(from view: RegistrationViewProtocol, with email:String?)
}

protocol RegistrationPresenterProtocol: class {
    var view: RegistrationViewProtocol? { get set }
    var interactor: RegistrationInterectorInputProtocol? { get set }
    var wireFrame: RegistrationWireFrameProtocol? { get set }
    
    func viewDidLoad()
    func viewDidAppear()

    func actionStartAnimatingRegistrationButton()
    func actionStopAnimatingRegistrationButton()
    
    func registerUser(With userProfileInfo:UserProfileModel)
    func backToPreviousScreen()
}

protocol RegistrationInteractorOutputProtocol: class {
    func didRegisterUser(With response: UserRegistrationResponse)
    func didNotRegisterUser(With response: UserRegistrationResponse)

    func didFailWithError(_ message:String?)//Showld be parameterised with error object
}

protocol RegistrationInterectorInputProtocol: class {
    var presenter: RegistrationInteractorOutputProtocol? { get set }
    var remoteDatamanager: RegistrationRemoteDataManagerInputProtocol? { get set }
    
    func registerUser(With userProfileInfo:UserProfileModel)
}

protocol RegistrationDataManagerInputProtocol: class {
    
}

protocol RegistrationRemoteDataManagerInputProtocol: class {
    var remoteRequestHandler: RegistrationRemoteDataManagerOutputProtocol? { get set }
    var validationManager: RegistrationValidationInputProtocol? { get set }

    func registerUser(With userProfileInfo:UserProfileModel)
    func callRegisterUserApi(With validatedParams:Dictionary<String,Any>)
}

protocol RegistrationRemoteDataManagerOutputProtocol: class {
    func onUserRegistration(_ response: UserRegistrationResponse)
    
    func onError(with message:String?, errorCode:Int? ,endpoint:Endpoint)
    func onError(_ message: String?)
    func onError()
}

protocol RegistrationValidationInputProtocol: class{
    var registrationValidationHandler: RegistrationValidationOutputProtocol? {get set}
    func validateParameters(_ parameters:UserProfileModel, endpoint:Endpoint)
}

protocol RegistrationValidationOutputProtocol: class{
    func didValidate(_ parameters:Dictionary<String,Any>, endpoint:Endpoint)
    func didValidateWithError(_ errorMessage:String, endpoint:Endpoint)
}

