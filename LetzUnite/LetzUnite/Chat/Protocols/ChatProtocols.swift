//
//  ChatProtocols.swift
//  LetzUnite
//
//  Created by B0081006 on 6/24/18.
//  Copyright © 2018 Airtel. All rights reserved.
//

import Foundation
import UIKit

protocol ChatViewProtocol: class {
    var presenter: ChatPresenterProtocol? { get set }
    
    func prepareForAnimation()
    func styleChatView()
    func animateChatView()
    
    func showMessage(_ message:String?)
    func showError(_ message:String?)

    func showLoading()
    func hideLoading()
    
    func updateView(With parameters: UserProfileModel)
}

protocol ChatWireFrameProtocol: class {
    static func createChatModule() -> UIViewController
    func popToPreviousScreen(from view: ChatViewProtocol)
}

protocol ChatPresenterProtocol: class {
    var view: ChatViewProtocol? { get set }
    var interactor: ChatInteractorInputProtocol? { get set }
    var wireFrame: ChatWireFrameProtocol? { get set }
    
    func viewDidLoad()
    func popToPreviousScreen()
    func updateProfile(with profileData: UserProfileModel)
}

protocol ChatInteractorOutputProtocol: class {
    func didFailToFetchProfile(with message:String)
    func didUpdateProfile(With response: UserUpdateProfileResponse)
    func didFailToUpdateProfile(_ message:String?)
}

protocol ChatInteractorInputProtocol: class {
    var presenter: ChatInteractorOutputProtocol? { get set }
    var localDatamanager: ChatLocalDataManagerInputProtocol? { get set }
    var remoteDatamanager: ChatRemoteDataManagerInputProtocol? { get set }
    
    func updateProfile(With userProfileInfo:UserProfileModel)
}

protocol ChatRemoteDataManagerInputProtocol: class {
    var remoteRequestHandler: ChatRemoteDataManagerOutputProtocol? { get set }
    var validationManager: ChatValidationInputProtocol? { get set }
    
    func updateProfile(With parameters: UserProfileModel, savedUser:UserProfileSingleton)    
}

protocol ChatRemoteDataManagerOutputProtocol: class {
    func onUpdateProfile(_ response: UserUpdateProfileResponse, updatedProfile:UserProfileModel?)
    func onError(with message:String?, errorCode:Int? ,endpoint:Endpoint)
}

protocol ChatLocalDataManagerInputProtocol: class {
    var userProfileManager: UserProfileSingleton? { get set }
    var localRequestHandler: ChatLocalDataManagerOutputProtocol? { get set }
    
    func retrieveUserProfile() -> UserProfileSingleton?
    func saveUpdatedUserProfile(_ profile: UserProfileModel?) -> Bool
}

protocol ChatLocalDataManagerOutputProtocol: class {
    
}

protocol ChatValidationInputProtocol: class{
    var ChatValidationHandler: ChatValidationOutputProtocol? {get set}
    func validateParameters(_ parameters:UserProfileModel, endpoint:Endpoint, savedUserProfile:UserProfileSingleton)
}

protocol ChatValidationOutputProtocol: class{
    func didValidate(_ parameters:Dictionary<String,Any>, endpoint:Endpoint, updatedProfile:UserProfileModel?)
    func didValidateWithError(_ errorMessage:String, endpoint:Endpoint)
}
