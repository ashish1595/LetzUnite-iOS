//
//  RewardsWireFrames.swift
//  LetzUnite
//
//  Created by Himanshu on 4/4/18.
//  Copyright © 2018 LetzUnite. All rights reserved.
//

import Foundation
import UIKit

class RewardsWireFrames: RewardsWireFrameProtocol {
    
    static func createRewardsModule() -> UIViewController {
        let viewController = mainStoryboard.instantiateViewController(withIdentifier: rewardsViewSID)
        if let view = viewController as? RewardsView {
            let presenter: RewardsPresenterProtocol & RewardsInteractorOutputProtocol = RewardsPresenter()
            
            let interactor: RewardsInteractorInputProtocol & RewardsRemoteDataManagerOutputProtocol & RewardsLocalDataManagerOutputProtocol = RewardsInteractor()
            
            let remoteDataManager: RewardsRemoteDataManagerInputProtocol & RewardsValidationOutputProtocol  = RewardsRemoteDataManager()
            
            let validationManager: RewardsValidationInputProtocol  = RewardsValidationManager()

            let localDataManager: RewardsLocalDataManagerInputProtocol = RewardsLocalDataManager()

            let profileManager = UserProfileSingleton.sharedInstance

            let wireFrame: RewardsWireFrameProtocol = RewardsWireFrames()
            
            view.presenter = presenter
            presenter.view = view
            presenter.wireFrame = wireFrame
            presenter.interactor = interactor
            interactor.presenter = presenter
            interactor.localDatamanager = localDataManager
            interactor.remoteDatamanager = remoteDataManager
            remoteDataManager.remoteRequestHandler = interactor
            remoteDataManager.validationManager = validationManager
            validationManager.rewardsValidationHandler = remoteDataManager
            localDataManager.localRequestHandler = interactor
            localDataManager.userProfileManager = profileManager
            
            return viewController
        }
        return UIViewController()
    }
    
}
