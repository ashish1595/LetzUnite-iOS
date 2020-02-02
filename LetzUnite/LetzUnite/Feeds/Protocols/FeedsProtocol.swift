//
//  FeedsProtocol.swift
//  LetzUnite
//
//  Created by Himanshu on 4/4/18.
//  Copyright © 2018 LetzUnite. All rights reserved.
//

import Foundation
import UIKit

protocol FeedsViewProtocol: class {
    var presenter: FeedsPresenterProtocol? { get set }
    
    func prepareForAnimation()
    func styleFeedsView()
    func animateFeedsView()
    
    func showLoading()
    func hideLoading()
    
    func showError(_ message:String?)

    func updateView(With parameters: FeedsResponse?)
}

protocol FeedsWireFrameProtocol: class {
    static func createFeedsModule() -> UIViewController
    func pushNotificationScreen(from view: FeedsViewProtocol)
    func pushBloodRequestsScreen(from view: FeedsViewProtocol)
    func presentFeedsDetailViewScreen(from view:FeedsViewProtocol, cardFrame:CGRect, cardCenter:CGPoint, imageFrame:CGRect, titleFrame:CGRect, descFrame:CGRect, bottomViewFrame:CGRect)
}

protocol FeedsPresenterProtocol: class {
    var view: FeedsViewProtocol? { get set }
    var interactor: FeedsInteractorInputProtocol? { get set }
    var wireFrame: FeedsWireFrameProtocol? { get set }
    
    func viewDidLoad()
    func fetchFeeds()
    func showNotificationScreen()
    func showAllBloodRequestsScreen()
    func showFeedsDetailScreen(with cardFrame:CGRect, cardCenter:CGPoint, imageFrame:CGRect, titleFrame:CGRect, descFrame:CGRect, bottomViewFrame:CGRect)
}

protocol FeedsInteractorOutputProtocol: class {
    func didFetchFeeds(With response: FeedsResponse)
    func didFailToFetchFeeds(_ message:String?)
}

protocol FeedsInteractorInputProtocol: class {
    var presenter: FeedsInteractorOutputProtocol? { get set }
    var localDatamanager: FeedsLocalDataManagerInputProtocol? { get set }
    var remoteDatamanager: FeedsRemoteDataManagerInputProtocol? { get set }
    
    func fetchFeeds()
}

protocol FeedsRemoteDataManagerInputProtocol: class {
    var remoteRequestHandler: FeedsRemoteDataManagerOutputProtocol? { get set }
    var validationManager: FeedsValidationInputProtocol? { get set }
    
    func fetchFeeds(With params: UserProfileSingleton?)
    func callFetchFeedsApi(With validatedParams:Dictionary<String,Any>, endpoint:Endpoint)
}

protocol FeedsRemoteDataManagerOutputProtocol: class {
    func onFetchFeeds(_ response: FeedsResponse)
    func onError(with message:String?, errorCode:Int? ,endpoint:Endpoint)
}

protocol FeedsLocalDataManagerInputProtocol: class {
    var userProfileManager: UserProfileSingleton? { get set }
    var localRequestHandler: FeedsLocalDataManagerOutputProtocol? { get set }
    func retrieveUserProfile() -> UserProfileSingleton?
}

protocol FeedsLocalDataManagerOutputProtocol: class {
    
}

protocol FeedsValidationInputProtocol: class{
    var feedsValidationHandler: FeedsValidationOutputProtocol? {get set}
    func validateParameters(_ parameters:UserProfileSingleton?, endpoint:Endpoint)
}

protocol FeedsValidationOutputProtocol: class{
    func didValidate(_ parameters:Dictionary<String,Any>, endpoint:Endpoint)
    func didValidateWithError(_ errorMessage:String, endpoint:Endpoint)
}

