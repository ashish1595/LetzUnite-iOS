//
//  BloodRequestWireFrames.swift
//  LetzUnite
//
//  Created by B0081006 on 6/30/18.
//  Copyright © 2018 Airtel. All rights reserved.
//

import Foundation
import UIKit

class BloodRequestWireFrames: BloodRequestWireFrameProtocol {
    
    static func createBloodRequestModule() -> UIViewController {
        let viewController = mainStoryboard.instantiateViewController(withIdentifier: bloodRequestViewSID)
        if let view = viewController as? BloodRequestView {
            let presenter: BloodRequestPresenterProtocol & BloodRequestInteractorOutputProtocol = BloodRequestPresenter()
            
            let interactor: BloodRequestInteractorInputProtocol & BloodRequestRemoteDataManagerOutputProtocol & BloodRequestLocalDataManagerOutputProtocol = BloodRequestInteractor()
            
            let remoteDataManager: BloodRequestRemoteDataManagerInputProtocol & BloodRequestValidationOutputProtocol  = BloodRequestRemoteDataManager()
            
            let validationManager: BloodRequestValidationInputProtocol  = BloodRequestValidationManager()
            
            let localDataManager: BloodRequestLocalDataManagerInputProtocol = BloodRequestLocalDataManager()
            
            let profileManager = UserProfileSingleton.sharedInstance
            
            let wireFrame: BloodRequestWireFrameProtocol = BloodRequestWireFrames()
            
            view.presenter = presenter
            presenter.view = view
            presenter.wireFrame = wireFrame
            presenter.interactor = interactor
            interactor.presenter = presenter
            interactor.localDatamanager = localDataManager
            interactor.remoteDatamanager = remoteDataManager
            remoteDataManager.remoteRequestHandler = interactor
            remoteDataManager.validationManager = validationManager
            validationManager.BloodRequestValidationHandler = remoteDataManager
            localDataManager.localRequestHandler = interactor
            localDataManager.userProfileManager = profileManager
            
            return viewController
        }
        return UIViewController()
    }
    
    func popView(_ view: BloodRequestViewProtocol) {
        if let viewController = view as? UIViewController {
            viewController.navigationController?.popViewController(animated: true)
        }
    }
    
    func pushBloodRequestDetailScreen(from view: BloodRequestViewProtocol) {
        let bloodRequestModule = BloodRequestDetailWireFrames.createBloodRequestDetailModule()
        if let sourceView = view as? UIViewController {
            sourceView.navigationController?.pushViewController(bloodRequestModule, animated: true)
        }
    }
}
