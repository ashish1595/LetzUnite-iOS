//
//  CreateRequestProtocols.swift
//  LetzUnite
//
//  Created by Himanshu on 4/4/18.
//  Copyright © 2018 LetzUnite. All rights reserved.
//

import Foundation
import UIKit

protocol CreateRequestViewProtocol: class {
    var presenter: CreateRequestPresenterProtocol? { get set }
    
    func prepareForAnimation()
    func styleCreateBloodRequestView()
    func animateCreateBloodRequestView()
    
    func showError(_ message:String?)
    func showMessage(_ message:String?)
    func showLoading()
    func hideLoading()
    func updateView(With parameters: BloodRequestResponse?)
}

protocol CreateRequestWireFrameProtocol: class {
    static func createCreateRequestModule() -> UIViewController
    func dismiss(_ view:CreateRequestViewProtocol)
}

protocol CreateRequestPresenterProtocol: class {
    var view: CreateRequestViewProtocol? { get set }
    var interactor: CreateRequestInteractorInputProtocol? { get set }
    var wireFrame: CreateRequestWireFrameProtocol? { get set }
    
    func viewDidLoad()
    func dismiss(_ view:CreateRequestViewProtocol)
    func createBloodRequest(With parameters:BloodRequestModel)
}

protocol CreateRequestInteractorOutputProtocol: class {
    func didCreateBloodRequest(With response: BloodRequestResponse?)
    func didFailToCreateBloodRequest(_ message:String?)
}

protocol CreateRequestInteractorInputProtocol: class {
    var presenter: CreateRequestInteractorOutputProtocol? { get set }
    var localDatamanager: CreateRequestLocalDataManagerInputProtocol? { get set }
    var remoteDatamanager: CreateRequestRemoteDataManagerInputProtocol? { get set }
    
    func createBloodRequest(With parameters:BloodRequestModel)
}

protocol CreateRequestRemoteDataManagerInputProtocol: class {
    var remoteRequestHandler: CreateRequestRemoteDataManagerOutputProtocol? { get set }
    var validationManager: CreateRequestValidationInputProtocol? { get set }
    
    func createBloodRequest(With parameters:BloodRequestModel, profileInfo:UserProfileSingleton?)
    func callCreateBloodRequestApi(With validatedParameters:Dictionary<String,Any>, endpoint:Endpoint);
}

protocol CreateRequestRemoteDataManagerOutputProtocol: class {
    func onCreateBloodRequest(_ response: BloodRequestResponse)
    func onError(with message:String?, errorCode:Int? ,endpoint:Endpoint)
}

protocol CreateRequestLocalDataManagerInputProtocol: class {
    var userProfileManager: UserProfileSingleton? { get set }
    var localRequestHandler: CreateRequestLocalDataManagerOutputProtocol? { get set }
    func retrieveUserProfile() -> UserProfileSingleton?
}

protocol CreateRequestLocalDataManagerOutputProtocol: class {

}

protocol CreateRequestValidationInputProtocol: class{
    var createRequestValidationHandler: CreateRequestValidationOutputProtocol? {get set}
    func validateParameters(_ parameters:BloodRequestModel, endpoint:Endpoint, profileInfo:UserProfileSingleton?)
}

protocol CreateRequestValidationOutputProtocol: class{
    func didValidate(_ parameters:Dictionary<String,Any>, endpoint:Endpoint)
    func didValidateWithError(_ errorMessage:String, endpoint:Endpoint)
}
