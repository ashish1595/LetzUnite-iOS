//
//  HistoryWireFrames.swift
//  LetzUnite
//
//  Created by B0081006 on 6/24/18.
//  Copyright © 2018 Airtel. All rights reserved.
//

import Foundation
import UIKit

class HistoryWireFrames: HistoryWireFrameProtocol {
    
    static func createHistoryModule() -> UIViewController {
        let viewController = mainStoryboard.instantiateViewController(withIdentifier: historyViewSID)
        if let view = viewController as? HistoryView {
            let presenter: HistoryPresenterProtocol & HistoryInteractorOutputProtocol = HistoryPresenter()
            
            let interactor: HistoryInteractorInputProtocol & HistoryRemoteDataManagerOutputProtocol & HistoryLocalDataManagerOutputProtocol = HistoryInteractor()
            
            let remoteDataManager: HistoryRemoteDataManagerInputProtocol & HistoryValidationOutputProtocol  = HistoryRemoteDataManager()
            
            let validationManager: HistoryValidationInputProtocol  = HistoryValidationManager()
            
            let localDataManager: HistoryLocalDataManagerInputProtocol = HistoryLocalDataManager()
            
            let profileManager = UserProfileSingleton.sharedInstance
            
            let wireFrame: HistoryWireFrameProtocol = HistoryWireFrames()
            
            view.presenter = presenter
            presenter.view = view
            presenter.wireFrame = wireFrame
            presenter.interactor = interactor
            interactor.presenter = presenter
            interactor.localDatamanager = localDataManager
            interactor.remoteDatamanager = remoteDataManager
            remoteDataManager.remoteRequestHandler = interactor
            remoteDataManager.validationManager = validationManager
            validationManager.HistoryValidationHandler = remoteDataManager
            localDataManager.localRequestHandler = interactor
            localDataManager.userProfileManager = profileManager
            
            view.tabs.append(DonatedHistoryWireFrames.createDonatedHistoryModule())
            view.tabs.append(ReceivedHistoryWireFrames.createReceivedHistoryModule())
            view.tabsTitle.append("Blood Donated")
            view.tabsTitle.append("Blood Received")
            view.numberOfTabs = 2
                        
            return viewController
        }
        return UIViewController()
    }
    
    
    
}
