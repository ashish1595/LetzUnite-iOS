//
//  RewardsProtocols.swift
//  LetzUnite
//
//  Created by Himanshu on 4/4/18.
//  Copyright © 2018 LetzUnite. All rights reserved.
//

import Foundation
import UIKit

protocol RewardsViewProtocol: class {
    var presenter: RewardsPresenterProtocol? { get set }
    
    func showLoading()
    func hideLoading()
    func showError(_ message:String?)
    func updateView(With parameters: RewardResponse?)
}

protocol RewardsWireFrameProtocol: class {
    static func createRewardsModule() -> UIViewController
}

protocol RewardsPresenterProtocol: class {
    var view: RewardsViewProtocol? { get set }
    var interactor: RewardsInteractorInputProtocol? { get set }
    var wireFrame: RewardsWireFrameProtocol? { get set }
    
    func viewDidLoad()
    func fetchRewards()
}

protocol RewardsInteractorOutputProtocol: class {
    func didFetchRewards(With response: RewardResponse?)
    func didFailToFetchRewards(_ message:String?)
}

protocol RewardsInteractorInputProtocol: class {
    var presenter: RewardsInteractorOutputProtocol? { get set }
    var localDatamanager: RewardsLocalDataManagerInputProtocol? { get set }
    var remoteDatamanager: RewardsRemoteDataManagerInputProtocol? { get set }

    func fetchRewards()
}

protocol RewardsRemoteDataManagerInputProtocol: class {
    var remoteRequestHandler: RewardsRemoteDataManagerOutputProtocol? { get set }
    var validationManager: RewardsValidationInputProtocol? { get set }
    
    func fetchRewards(With parameters:UserProfileSingleton)
    func callFetchRewardsApi(With validatedParams:Dictionary<String,Any>, endpoint:Endpoint)
}

protocol RewardsRemoteDataManagerOutputProtocol: class {
    func onFetchRewards(_ response: RewardResponse?)
    func onError(with message:String?, errorCode:Int? ,endpoint:Endpoint)
}

protocol RewardsLocalDataManagerInputProtocol: class {
    var userProfileManager: UserProfileSingleton? { get set }
    var localRequestHandler: RewardsLocalDataManagerOutputProtocol? { get set }
    func retrieveUserProfile() -> UserProfileSingleton?
}

protocol RewardsLocalDataManagerOutputProtocol: class {
    
}

protocol RewardsValidationInputProtocol: class{
    var rewardsValidationHandler: RewardsValidationOutputProtocol? {get set}
    func validateParameters(_ parameters:UserProfileSingleton, endpoint:Endpoint)
}

protocol RewardsValidationOutputProtocol: class{
    func didValidate(_ parameters:Dictionary<String,Any>, endpoint:Endpoint)
    func didValidateWithError(_ errorMessage:String, endpoint:Endpoint)
}
