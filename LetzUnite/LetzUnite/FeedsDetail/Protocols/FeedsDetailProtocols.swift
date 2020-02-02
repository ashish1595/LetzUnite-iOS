//
//  FeedsDetailProtocols.swift
//  LetzUnite
//
//  Created by B0081006 on 7/11/18.
//  Copyright © 2018 Airtel. All rights reserved.
//

import Foundation
import UIKit

protocol FeedsDetailViewProtocol: class {
    var presenter: FeedsDetailPresenterProtocol? { get set }
    
    func prepareForAnimation()
    func styleFeedsDetailView()
    func animateFeedsDetailView()
    func showLoading()
    func hideLoading()
    func showError(_ message:String?)
    func updateView(With parameters: RewardResponse?)
}

protocol FeedsDetailWireFrameProtocol: class {
    static func createFeedsDetailModule() -> UIViewController
    func popView(_ view:FeedsDetailViewProtocol)
}

protocol FeedsDetailPresenterProtocol: class {
    var view: FeedsDetailViewProtocol? { get set }
    var interactor: FeedsDetailInteractorInputProtocol? { get set }
    var wireFrame: FeedsDetailWireFrameProtocol? { get set }
    
    func viewDidLoad()
    func fetchFeedsDetail()
    func popView(_ view:FeedsDetailViewProtocol)
}

protocol FeedsDetailInteractorOutputProtocol: class {
    func didFetchFeedsDetail(With response: RewardResponse?)
    func didFailToFetchFeedsDetail(_ message:String?)
}

protocol FeedsDetailInteractorInputProtocol: class {
    var presenter: FeedsDetailInteractorOutputProtocol? { get set }
    var localDatamanager: FeedsDetailLocalDataManagerInputProtocol? { get set }
    var remoteDatamanager: FeedsDetailRemoteDataManagerInputProtocol? { get set }
    
    func fetchFeedsDetail()
}

protocol FeedsDetailRemoteDataManagerInputProtocol: class {
    var remoteRequestHandler: FeedsDetailRemoteDataManagerOutputProtocol? { get set }
    var validationManager: FeedsDetailValidationInputProtocol? { get set }
    
    func fetchFeedsDetail(With parameters:UserProfileSingleton)
    func callFetchFeedsDetailApi(With validatedParams:Dictionary<String,Any>, endpoint:Endpoint)
}

protocol FeedsDetailRemoteDataManagerOutputProtocol: class {
    func onFetchFeedsDetail(_ response: RewardResponse?)
    func onError(with message:String?, errorCode:Int? ,endpoint:Endpoint)
}

protocol FeedsDetailLocalDataManagerInputProtocol: class {
    var userProfileManager: UserProfileSingleton? { get set }
    var localRequestHandler: FeedsDetailLocalDataManagerOutputProtocol? { get set }
    func retrieveUserProfile() -> UserProfileSingleton?
}

protocol FeedsDetailLocalDataManagerOutputProtocol: class {
    
}

protocol FeedsDetailValidationInputProtocol: class{
    var FeedsDetailValidationHandler: FeedsDetailValidationOutputProtocol? {get set}
    func validateParameters(_ parameters:UserProfileSingleton, endpoint:Endpoint)
}

protocol FeedsDetailValidationOutputProtocol: class{
    func didValidate(_ parameters:Dictionary<String,Any>, endpoint:Endpoint)
    func didValidateWithError(_ errorMessage:String, endpoint:Endpoint)
}
