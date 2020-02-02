//
//  DonatedHistoryProtocols.swift
//  LetzUnite
//
//  Created by B0081006 on 6/24/18.
//  Copyright © 2018 Airtel. All rights reserved.
//

import Foundation
import UIKit

protocol DonatedHistoryViewProtocol: class {
    var presenter: DonatedHistoryPresenterProtocol? { get set }
    
    func showLoading()
    func hideLoading()
    func showError(_ message:String?)
    func updateView(With parameters: RewardResponse?)
}

protocol DonatedHistoryWireFrameProtocol: class {
    static func createDonatedHistoryModule() -> UIViewController
    func pushBloodDonatedRequestDetailScreen(from view: DonatedHistoryViewProtocol)
}

protocol DonatedHistoryPresenterProtocol: class {
    var view: DonatedHistoryViewProtocol? { get set }
    var interactor: DonatedHistoryInteractorInputProtocol? { get set }
    var wireFrame: DonatedHistoryWireFrameProtocol? { get set }
    
    func viewDidLoad()
    func fetchDonatedHistory()
    func showBloodDonatedRequestDetailScreen()
}

protocol DonatedHistoryInteractorOutputProtocol: class {
    func didFetchDonatedHistory(With response: RewardResponse?)
    func didFailToFetchDonatedHistory(_ message:String?)
}

protocol DonatedHistoryInteractorInputProtocol: class {
    var presenter: DonatedHistoryInteractorOutputProtocol? { get set }
    var localDatamanager: DonatedHistoryLocalDataManagerInputProtocol? { get set }
    var remoteDatamanager: DonatedHistoryRemoteDataManagerInputProtocol? { get set }
    
    func fetchDonatedHistory()
}

protocol DonatedHistoryRemoteDataManagerInputProtocol: class {
    var remoteRequestHandler: DonatedHistoryRemoteDataManagerOutputProtocol? { get set }
    var validationManager: DonatedHistoryValidationInputProtocol? { get set }
    
    func fetchDonatedHistory(With parameters:UserProfileSingleton)
    func callFetchDonatedHistoryApi(With validatedParams:Dictionary<String,Any>, endpoint:Endpoint)
}

protocol DonatedHistoryRemoteDataManagerOutputProtocol: class {
    func onFetchDonatedHistory(_ response: RewardResponse?)
    func onError(with message:String?, errorCode:Int? ,endpoint:Endpoint)
}

protocol DonatedHistoryLocalDataManagerInputProtocol: class {
    var userProfileManager: UserProfileSingleton? { get set }
    var localRequestHandler: DonatedHistoryLocalDataManagerOutputProtocol? { get set }
    func retrieveUserProfile() -> UserProfileSingleton?
}

protocol DonatedHistoryLocalDataManagerOutputProtocol: class {
    
}

protocol DonatedHistoryValidationInputProtocol: class{
    var DonatedHistoryValidationHandler: DonatedHistoryValidationOutputProtocol? {get set}
    func validateParameters(_ parameters:UserProfileSingleton, endpoint:Endpoint)
}

protocol DonatedHistoryValidationOutputProtocol: class{
    func didValidate(_ parameters:Dictionary<String,Any>, endpoint:Endpoint)
    func didValidateWithError(_ errorMessage:String, endpoint:Endpoint)
}
