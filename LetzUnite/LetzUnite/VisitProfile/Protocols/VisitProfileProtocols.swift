//
//  VisitProfileProtocols.swift
//  LetzUnite
//
//  Created by Himanshu on 4/4/18.
//  Copyright © 2018 LetzUnite. All rights reserved.
//

import Foundation
import UIKit

protocol VisitProfileViewProtocol: class {
    var presenter: VisitProfilePresenterProtocol? { get set }
    
    func prepareForAnimation()
    func styleVisitProfileView()
    func animateVisitProfileView()
    
    func showError(_ message:String?)
    func showMessage(_ message:String?)
    func showLoading()
    func hideLoading()
    func updateView(With parameters: UserProfileModel)
}

protocol VisitProfileWireFrameProtocol: class {
    static func createVisitProfileModule() -> UIViewController
    func presentChatScreen(from view: VisitProfileViewProtocol)
}

protocol VisitProfilePresenterProtocol: class {
    var view: VisitProfileViewProtocol? { get set }
    var interactor: VisitProfileInteractorInputProtocol? { get set }
    var wireFrame: VisitProfileWireFrameProtocol? { get set }
    
    func viewDidLoad()
    func fetchVisitProfile()
    func showEditVisitProfileScreen()
    func updateVisitProfile(with VisitProfileData: UserProfileModel)
}

protocol VisitProfileInteractorOutputProtocol: class {
    func didFetchVisitProfile(With response: UserProfileModel)
    func didFailToFetchVisitProfile(with message:String)
    func didUpdateVisitProfile(With response: UserUpdateProfileResponse)
    func didFailToUpdateVisitProfile(_ message:String?)
}

protocol VisitProfileInteractorInputProtocol: class {
    var presenter: VisitProfileInteractorOutputProtocol? { get set }
    var localDatamanager: VisitProfileLocalDataManagerInputProtocol? { get set }
    var remoteDatamanager: VisitProfileRemoteDataManagerInputProtocol? { get set }
    
    func fetchVisitProfileToDisplay()
    func updateVisitProfile(With userVisitProfileInfo:UserProfileModel)
}

protocol VisitProfileRemoteDataManagerInputProtocol: class {
    var remoteRequestHandler: VisitProfileRemoteDataManagerOutputProtocol? { get set }
    var validationManager: VisitProfileValidationInputProtocol? { get set }
    
    func updateVisitProfile(With parameters: UserProfileModel, savedUser:UserProfileSingleton)
    func callUpdateVisitProfileApi(With validatedParams:Dictionary<String,Any>, endpoint:Endpoint, updatedVisitProfile:UserProfileModel?)
}

protocol VisitProfileRemoteDataManagerOutputProtocol: class {
    func onUpdateVisitProfile(_ response: UserUpdateProfileResponse, updatedVisitProfile:UserProfileModel?)
    func onError(with message:String?, errorCode:Int? ,endpoint:Endpoint)
}

protocol VisitProfileLocalDataManagerInputProtocol: class {
    var userVisitProfileManager: UserProfileSingleton? { get set }
    var localRequestHandler: VisitProfileLocalDataManagerOutputProtocol? { get set }
    
    func retrieveUserVisitProfileToDisplay()
    func retrieveUserVisitProfile() -> UserProfileSingleton?
    func saveUpdatedUserVisitProfile(_ VisitProfile: UserProfileModel?) -> Bool
}

protocol VisitProfileLocalDataManagerOutputProtocol: class {
    func onLocalVisitProfileRetrieval(_ localVisitProfile:UserProfileModel)
    func onLocalVisitProfileRetrievalError(_ message:String)
}

protocol VisitProfileValidationInputProtocol: class{
    var visitProfileValidationHandler: VisitProfileValidationOutputProtocol? {get set}
    func validateParameters(_ parameters:UserProfileModel, endpoint:Endpoint)
    func validateParameters(_ parameters:UserProfileModel, endpoint:Endpoint, savedUserVisitProfile:UserProfileSingleton)
}

protocol VisitProfileValidationOutputProtocol: class{
    func didValidate(_ parameters:Dictionary<String,Any>, endpoint:Endpoint, updatedVisitProfile:UserProfileModel?)
    func didValidateWithError(_ errorMessage:String, endpoint:Endpoint)
}

