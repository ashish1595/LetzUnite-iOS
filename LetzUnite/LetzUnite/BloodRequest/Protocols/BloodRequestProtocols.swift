//
//  BloodRequestProtocols.swift
//  LetzUnite
//
//  Created by B0081006 on 6/30/18.
//  Copyright © 2018 Airtel. All rights reserved.
//

import Foundation
import UIKit

protocol BloodRequestViewProtocol: class {
    var presenter: BloodRequestPresenterProtocol? { get set }
    
    func prepareForAnimation()
    func styleBloodRequestView()
    func animateBloodRequestView()
    func showLoading()
    func hideLoading()
    func showError(_ message:String?)
    func updateView(With parameters: RewardResponse?)
}

protocol BloodRequestWireFrameProtocol: class {
    static func createBloodRequestModule() -> UIViewController
    func popView(_ view:BloodRequestViewProtocol)
    func pushBloodRequestDetailScreen(from view: BloodRequestViewProtocol)
}

protocol BloodRequestPresenterProtocol: class {
    var view: BloodRequestViewProtocol? { get set }
    var interactor: BloodRequestInteractorInputProtocol? { get set }
    var wireFrame: BloodRequestWireFrameProtocol? { get set }
    
    func viewDidLoad()
    func fetchBloodRequest()
    func popView(_ view:BloodRequestViewProtocol)
    func showBloodRequestDetailScreen()
}

protocol BloodRequestInteractorOutputProtocol: class {
    func didFetchBloodRequest(With response: RewardResponse?)
    func didFailToFetchBloodRequest(_ message:String?)
}

protocol BloodRequestInteractorInputProtocol: class {
    var presenter: BloodRequestInteractorOutputProtocol? { get set }
    var localDatamanager: BloodRequestLocalDataManagerInputProtocol? { get set }
    var remoteDatamanager: BloodRequestRemoteDataManagerInputProtocol? { get set }
    
    func fetchBloodRequest()
}

protocol BloodRequestRemoteDataManagerInputProtocol: class {
    var remoteRequestHandler: BloodRequestRemoteDataManagerOutputProtocol? { get set }
    var validationManager: BloodRequestValidationInputProtocol? { get set }
    
    func fetchBloodRequest(With parameters:UserProfileSingleton)
    func callFetchBloodRequestApi(With validatedParams:Dictionary<String,Any>, endpoint:Endpoint)
}

protocol BloodRequestRemoteDataManagerOutputProtocol: class {
    func onFetchBloodRequest(_ response: RewardResponse?)
    func onError(with message:String?, errorCode:Int? ,endpoint:Endpoint)
}

protocol BloodRequestLocalDataManagerInputProtocol: class {
    var userProfileManager: UserProfileSingleton? { get set }
    var localRequestHandler: BloodRequestLocalDataManagerOutputProtocol? { get set }
    func retrieveUserProfile() -> UserProfileSingleton?
}

protocol BloodRequestLocalDataManagerOutputProtocol: class {
    
}

protocol BloodRequestValidationInputProtocol: class{
    var BloodRequestValidationHandler: BloodRequestValidationOutputProtocol? {get set}
    func validateParameters(_ parameters:UserProfileSingleton, endpoint:Endpoint)
}

protocol BloodRequestValidationOutputProtocol: class{
    func didValidate(_ parameters:Dictionary<String,Any>, endpoint:Endpoint)
    func didValidateWithError(_ errorMessage:String, endpoint:Endpoint)
}
