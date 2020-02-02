//
//  ReceivedHistoryWireFrames.swift
//  LetzUnite
//
//  Created by B0081006 on 6/24/18.
//  Copyright © 2018 Airtel. All rights reserved.
//

import Foundation
import UIKit

class ReceivedHistoryWireFrames: ReceivedHistoryWireFrameProtocol {
    
    static func createReceivedHistoryModule() -> UIViewController {
        let viewController = mainStoryboard.instantiateViewController(withIdentifier: receivedHistoryViewSID)
        if let view = viewController as? ReceivedHistoryView {
            let presenter: ReceivedHistoryPresenterProtocol & ReceivedHistoryInteractorOutputProtocol = ReceivedHistoryPresenter()
            
            let interactor: ReceivedHistoryInteractorInputProtocol & ReceivedHistoryRemoteDataManagerOutputProtocol & ReceivedHistoryLocalDataManagerOutputProtocol = ReceivedHistoryInteractor()
            
            let remoteDataManager: ReceivedHistoryRemoteDataManagerInputProtocol & ReceivedHistoryValidationOutputProtocol  = ReceivedHistoryRemoteDataManager()
            
            let validationManager: ReceivedHistoryValidationInputProtocol  = ReceivedHistoryValidationManager()
            
            let localDataManager: ReceivedHistoryLocalDataManagerInputProtocol = ReceivedHistoryLocalDataManager()
            
            let profileManager = UserProfileSingleton.sharedInstance
            
            let wireFrame: ReceivedHistoryWireFrameProtocol = ReceivedHistoryWireFrames()
            
            view.presenter = presenter
            presenter.view = view
            presenter.wireFrame = wireFrame
            presenter.interactor = interactor
            interactor.presenter = presenter
            interactor.localDatamanager = localDataManager
            interactor.remoteDatamanager = remoteDataManager
            remoteDataManager.remoteRequestHandler = interactor
            remoteDataManager.validationManager = validationManager
            validationManager.ReceivedHistoryValidationHandler = remoteDataManager
            localDataManager.localRequestHandler = interactor
            localDataManager.userProfileManager = profileManager
            
            return viewController
        }
        return UIViewController()
    }
    
    func pushBloodReceivedRequestDetailScreen(from view: ReceivedHistoryViewProtocol) {
        let bloodRequestModule = BloodRequestDetailWireFrames.createBloodRequestDetailModule()
        historyNavigationController?.pushViewController(bloodRequestModule, animated: true)
    }
}
