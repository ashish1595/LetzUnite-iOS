//
//  EditProfileProtocols.swift
//  LetzUnite
//
//  Created by B0081006 on 6/24/18.
//  Copyright © 2018 Airtel. All rights reserved.
//

import Foundation
import UIKit

protocol EditProfileViewProtocol: class {
    var presenter: EditProfilePresenterProtocol? { get set }
    
    func prepareForAnimation()
    func styleEditView()
    func animateEditView()
    func showMessage(_ message:String?)

    func showLoading()
    func hideLoading()
    func showError(_ message:String?)
    func updateView(With parameters: UserProfileModel)
}

protocol EditProfileWireFrameProtocol: class {
    static func createEditProfileModule() -> UIViewController
    func popToProfileScreen(from view: EditProfileViewProtocol)
}

protocol EditProfilePresenterProtocol: class {
    var view: EditProfileViewProtocol? { get set }
    var interactor: EditProfileInteractorInputProtocol? { get set }
    var wireFrame: EditProfileWireFrameProtocol? { get set }
    
    func viewDidLoad()
    func popToProfileScreen()
    func updateProfile(with profileData: UserProfileModel)
    
}

protocol EditProfileInteractorOutputProtocol: class {
    func didFailToFetchProfile(with message:String)
    func didUpdateProfile(With response: UserUpdateProfileResponse)
    func didFailToUpdateProfile(_ message:String?)
}

protocol EditProfileInteractorInputProtocol: class {
    var presenter: EditProfileInteractorOutputProtocol? { get set }
    var localDatamanager: EditProfileLocalDataManagerInputProtocol? { get set }
    var remoteDatamanager: EditProfileRemoteDataManagerInputProtocol? { get set }
    
    func updateProfile(With userProfileInfo:UserProfileModel)
}

protocol EditProfileRemoteDataManagerInputProtocol: class {
    var remoteRequestHandler: EditProfileRemoteDataManagerOutputProtocol? { get set }
    var validationManager: EditProfileValidationInputProtocol? { get set }
    
    func updateProfile(With parameters: UserProfileModel, savedUser:UserProfileSingleton)    
}

protocol EditProfileRemoteDataManagerOutputProtocol: class {
    func onUpdateProfile(_ response: UserUpdateProfileResponse, updatedProfile:UserProfileModel?)
    func onError(with message:String?, errorCode:Int? ,endpoint:Endpoint)
}

protocol EditProfileLocalDataManagerInputProtocol: class {
    var userProfileManager: UserProfileSingleton? { get set }
    var localRequestHandler: EditProfileLocalDataManagerOutputProtocol? { get set }
    
    func retrieveUserProfile() -> UserProfileSingleton?
    func saveUpdatedUserProfile(_ profile: UserProfileModel?) -> Bool
}

protocol EditProfileLocalDataManagerOutputProtocol: class {
    
}

protocol EditProfileValidationInputProtocol: class{
    var EditProfileValidationHandler: EditProfileValidationOutputProtocol? {get set}    
    func validateParameters(_ parameters:UserProfileModel, endpoint:Endpoint, savedUserProfile:UserProfileSingleton)
}

protocol EditProfileValidationOutputProtocol: class{
    func didValidate(_ parameters:Dictionary<String,Any>, endpoint:Endpoint, updatedProfile:UserProfileModel?)
    func didValidateWithError(_ errorMessage:String, endpoint:Endpoint)
}
