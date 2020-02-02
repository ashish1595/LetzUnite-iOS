//
//  DonatedHistoryWireFrames.swift
//  LetzUnite
//
//  Created by B0081006 on 6/24/18.
//  Copyright © 2018 Airtel. All rights reserved.
//

import Foundation
import UIKit

class DonatedHistoryWireFrames: DonatedHistoryWireFrameProtocol {

    static func createDonatedHistoryModule() -> UIViewController {
        let viewController = mainStoryboard.instantiateViewController(withIdentifier: donatedHistoryViewSID)
        if let view = viewController as? DonatedHistoryView {
            let presenter: DonatedHistoryPresenterProtocol & DonatedHistoryInteractorOutputProtocol = DonatedHistoryPresenter()
            
            let interactor: DonatedHistoryInteractorInputProtocol & DonatedHistoryRemoteDataManagerOutputProtocol & DonatedHistoryLocalDataManagerOutputProtocol = DonatedHistoryInteractor()
            
            let remoteDataManager: DonatedHistoryRemoteDataManagerInputProtocol & DonatedHistoryValidationOutputProtocol  = DonatedHistoryRemoteDataManager()
            
            let validationManager: DonatedHistoryValidationInputProtocol  = DonatedHistoryValidationManager()
            
            let localDataManager: DonatedHistoryLocalDataManagerInputProtocol = DonatedHistoryLocalDataManager()
            
            let profileManager = UserProfileSingleton.sharedInstance
            
            let wireFrame: DonatedHistoryWireFrameProtocol = DonatedHistoryWireFrames()
            
            view.presenter = presenter
            presenter.view = view
            presenter.wireFrame = wireFrame
            presenter.interactor = interactor
            interactor.presenter = presenter
            interactor.localDatamanager = localDataManager
            interactor.remoteDatamanager = remoteDataManager
            remoteDataManager.remoteRequestHandler = interactor
            remoteDataManager.validationManager = validationManager
            validationManager.DonatedHistoryValidationHandler = remoteDataManager
            localDataManager.localRequestHandler = interactor
            localDataManager.userProfileManager = profileManager
            
            return viewController
        }
        return UIViewController()
    }
    
    func pushBloodDonatedRequestDetailScreen(from view: DonatedHistoryViewProtocol) {
        let bloodRequestModule = BloodRequestDetailWireFrames.createBloodRequestDetailModule()
        historyNavigationController?.pushViewController(bloodRequestModule, animated: true)
    }
    
}
