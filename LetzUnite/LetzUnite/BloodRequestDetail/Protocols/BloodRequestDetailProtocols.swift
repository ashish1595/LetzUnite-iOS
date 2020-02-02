//
//  BloodRequestDetailProtocols.swift
//  LetzUnite
//
//  Created by B0081006 on 6/30/18.
//  Copyright © 2018 Airtel. All rights reserved.
//

import Foundation
import UIKit

protocol BloodRequestDetailViewProtocol: class {
    var presenter: BloodRequestDetailPresenterProtocol? { get set }
    
    func prepareForAnimation()
    func styleBloodRequestDetailView()
    func animateBloodRequestDetailView()
    func showLoading()
    func hideLoading()
    func showError(_ message:String?)
    func updateView(With parameters: RewardResponse?)
}

protocol BloodRequestDetailWireFrameProtocol: class {
    static func createBloodRequestDetailModule() -> UIViewController
    func popView(_ view:BloodRequestDetailViewProtocol)
}

protocol BloodRequestDetailPresenterProtocol: class {
    var view: BloodRequestDetailViewProtocol? { get set }
    var interactor: BloodRequestDetailInteractorInputProtocol? { get set }
    var wireFrame: BloodRequestDetailWireFrameProtocol? { get set }
    
    func viewDidLoad()
    func fetchBloodRequestDetail()
    func popView(_ view:BloodRequestDetailViewProtocol)
}

protocol BloodRequestDetailInteractorOutputProtocol: class {
    func didFetchBloodRequestDetail(With response: RewardResponse?)
    func didFailToFetchBloodRequestDetail(_ message:String?)
}

protocol BloodRequestDetailInteractorInputProtocol: class {
    var presenter: BloodRequestDetailInteractorOutputProtocol? { get set }
    var localDatamanager: BloodRequestDetailLocalDataManagerInputProtocol? { get set }
    var remoteDatamanager: BloodRequestDetailRemoteDataManagerInputProtocol? { get set }
    
    func fetchBloodRequestDetail()
}

protocol BloodRequestDetailRemoteDataManagerInputProtocol: class {
    var remoteRequestHandler: BloodRequestDetailRemoteDataManagerOutputProtocol? { get set }
    var validationManager: BloodRequestDetailValidationInputProtocol? { get set }
    
    func fetchBloodRequestDetail(With parameters:UserProfileSingleton)
    func callFetchBloodRequestDetailApi(With validatedParams:Dictionary<String,Any>, endpoint:Endpoint)
}

protocol BloodRequestDetailRemoteDataManagerOutputProtocol: class {
    func onFetchBloodRequestDetail(_ response: RewardResponse?)
    func onError(with message:String?, errorCode:Int? ,endpoint:Endpoint)
}

protocol BloodRequestDetailLocalDataManagerInputProtocol: class {
    var userProfileManager: UserProfileSingleton? { get set }
    var localRequestHandler: BloodRequestDetailLocalDataManagerOutputProtocol? { get set }
    func retrieveUserProfile() -> UserProfileSingleton?
}

protocol BloodRequestDetailLocalDataManagerOutputProtocol: class {
    
}

protocol BloodRequestDetailValidationInputProtocol: class{
    var BloodRequestDetailValidationHandler: BloodRequestDetailValidationOutputProtocol? {get set}
    func validateParameters(_ parameters:UserProfileSingleton, endpoint:Endpoint)
}

protocol BloodRequestDetailValidationOutputProtocol: class{
    func didValidate(_ parameters:Dictionary<String,Any>, endpoint:Endpoint)
    func didValidateWithError(_ errorMessage:String, endpoint:Endpoint)
}
