//
//  ProfileProtocols.swift
//  LetzUnite
//
//  Created by Himanshu on 4/4/18.
//  Copyright © 2018 LetzUnite. All rights reserved.
//

import Foundation
import UIKit

protocol ProfileViewProtocol: class {
    var presenter: ProfilePresenterProtocol? { get set }
    
    func showError(_ message:String?)
    func showMessage(_ message:String?)
    
    func showLoading()
    func hideLoading()
    func updateView(With parameters: UserProfileModel)
}

protocol ProfileWireFrameProtocol: class {
    static func createProfileModule() -> UIViewController
    func presentEditProfileScreen(from view: ProfileViewProtocol)
}

protocol ProfilePresenterProtocol: class {
    var view: ProfileViewProtocol? { get set }
    var interactor: ProfileInteractorInputProtocol? { get set }
    var wireFrame: ProfileWireFrameProtocol? { get set }
    
    func viewDidLoad()
    func fetchProfile()
    func showEditProfileScreen()
    func updateProfile(with profileData: UserProfileModel)
}

protocol ProfileInteractorOutputProtocol: class {
    func didFetchProfile(With response: UserProfileModel)
    func didFailToFetchProfile(with message:String)
    func didUpdateProfile(With response: UserUpdateProfileResponse)
    func didFailToUpdateProfile(_ message:String?)
}

protocol ProfileInteractorInputProtocol: class {
    var presenter: ProfileInteractorOutputProtocol? { get set }
    var localDatamanager: ProfileLocalDataManagerInputProtocol? { get set }
    var remoteDatamanager: ProfileRemoteDataManagerInputProtocol? { get set }
    
    func fetchProfileToDisplay()
    func updateProfile(With userProfileInfo:UserProfileModel)
}

protocol ProfileRemoteDataManagerInputProtocol: class {
    var remoteRequestHandler: ProfileRemoteDataManagerOutputProtocol? { get set }
    var validationManager: ProfileValidationInputProtocol? { get set }
    
    func updateProfile(With parameters: UserProfileModel, savedUser:UserProfileSingleton)
    func callUpdateProfileApi(With validatedParams:Dictionary<String,Any>, endpoint:Endpoint, updatedProfile:UserProfileModel?)
}

protocol ProfileRemoteDataManagerOutputProtocol: class {
    func onUpdateProfile(_ response: UserUpdateProfileResponse, updatedProfile:UserProfileModel?)
    func onError(with message:String?, errorCode:Int? ,endpoint:Endpoint)
}

protocol ProfileLocalDataManagerInputProtocol: class {
    var userProfileManager: UserProfileSingleton? { get set }
    var localRequestHandler: ProfileLocalDataManagerOutputProtocol? { get set }
    
    func retrieveUserProfileToDisplay()
    func retrieveUserProfile() -> UserProfileSingleton?
    func saveUpdatedUserProfile(_ profile: UserProfileModel?) -> Bool
}

protocol ProfileLocalDataManagerOutputProtocol: class {
    func onLocalProfileRetrieval(_ localProfile:UserProfileModel)
    func onLocalProfileRetrievalError(_ message:String)
}

protocol ProfileValidationInputProtocol: class{
    var profileValidationHandler: ProfileValidationOutputProtocol? {get set}
    func validateParameters(_ parameters:UserProfileModel, endpoint:Endpoint)
    func validateParameters(_ parameters:UserProfileModel, endpoint:Endpoint, savedUserProfile:UserProfileSingleton)
}

protocol ProfileValidationOutputProtocol: class{
    func didValidate(_ parameters:Dictionary<String,Any>, endpoint:Endpoint, updatedProfile:UserProfileModel?)
    func didValidateWithError(_ errorMessage:String, endpoint:Endpoint)
}

