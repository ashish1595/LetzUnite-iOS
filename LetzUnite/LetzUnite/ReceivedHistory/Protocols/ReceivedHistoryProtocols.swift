//
//  ReceivedHistoryProtocols.swift
//  LetzUnite
//
//  Created by B0081006 on 6/24/18.
//  Copyright © 2018 Airtel. All rights reserved.
//

import Foundation
import UIKit

protocol ReceivedHistoryViewProtocol: class {
    var presenter: ReceivedHistoryPresenterProtocol? { get set }
    
    func showLoading()
    func hideLoading()
    func showError(_ message:String?)
    func updateView(With parameters: RewardResponse?)
}

protocol ReceivedHistoryWireFrameProtocol: class {
    static func createReceivedHistoryModule() -> UIViewController
    func pushBloodReceivedRequestDetailScreen(from view: ReceivedHistoryViewProtocol)
}

protocol ReceivedHistoryPresenterProtocol: class {
    var view: ReceivedHistoryViewProtocol? { get set }
    var interactor: ReceivedHistoryInteractorInputProtocol? { get set }
    var wireFrame: ReceivedHistoryWireFrameProtocol? { get set }
    
    func viewDidLoad()
    func fetchReceivedHistory()
    func showBloodReceivedRequestDetailScreen()
}

protocol ReceivedHistoryInteractorOutputProtocol: class {
    func didFetchReceivedHistory(With response: RewardResponse?)
    func didFailToFetchReceivedHistory(_ message:String?)
}

protocol ReceivedHistoryInteractorInputProtocol: class {
    var presenter: ReceivedHistoryInteractorOutputProtocol? { get set }
    var localDatamanager: ReceivedHistoryLocalDataManagerInputProtocol? { get set }
    var remoteDatamanager: ReceivedHistoryRemoteDataManagerInputProtocol? { get set }
    
    func fetchReceivedHistory()
}

protocol ReceivedHistoryRemoteDataManagerInputProtocol: class {
    var remoteRequestHandler: ReceivedHistoryRemoteDataManagerOutputProtocol? { get set }
    var validationManager: ReceivedHistoryValidationInputProtocol? { get set }
    
    func fetchReceivedHistory(With parameters:UserProfileSingleton)
    func callFetchReceivedHistoryApi(With validatedParams:Dictionary<String,Any>, endpoint:Endpoint)
}

protocol ReceivedHistoryRemoteDataManagerOutputProtocol: class {
    func onFetchReceivedHistory(_ response: RewardResponse?)
    func onError(with message:String?, errorCode:Int? ,endpoint:Endpoint)
}

protocol ReceivedHistoryLocalDataManagerInputProtocol: class {
    var userProfileManager: UserProfileSingleton? { get set }
    var localRequestHandler: ReceivedHistoryLocalDataManagerOutputProtocol? { get set }
    func retrieveUserProfile() -> UserProfileSingleton?
}

protocol ReceivedHistoryLocalDataManagerOutputProtocol: class {
    
}

protocol ReceivedHistoryValidationInputProtocol: class{
    var ReceivedHistoryValidationHandler: ReceivedHistoryValidationOutputProtocol? {get set}
    func validateParameters(_ parameters:UserProfileSingleton, endpoint:Endpoint)
}

protocol ReceivedHistoryValidationOutputProtocol: class{
    func didValidate(_ parameters:Dictionary<String,Any>, endpoint:Endpoint)
    func didValidateWithError(_ errorMessage:String, endpoint:Endpoint)
}
