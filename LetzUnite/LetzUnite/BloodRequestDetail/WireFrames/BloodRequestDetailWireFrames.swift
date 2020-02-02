//
//  BloodRequestDetailWireFrames.swift
//  LetzUnite
//
//  Created by B0081006 on 6/30/18.
//  Copyright © 2018 Airtel. All rights reserved.
//

import Foundation
import UIKit

class BloodRequestDetailWireFrames: BloodRequestDetailWireFrameProtocol {
    
    static func createBloodRequestDetailModule() -> UIViewController {
        let viewController = mainStoryboard.instantiateViewController(withIdentifier: bloodRequestDetailViewSID)
        if let view = viewController as? BloodRequestDetailView {
            let presenter: BloodRequestDetailPresenterProtocol & BloodRequestDetailInteractorOutputProtocol = BloodRequestDetailPresenter()
            
            let interactor: BloodRequestDetailInteractorInputProtocol & BloodRequestDetailRemoteDataManagerOutputProtocol & BloodRequestDetailLocalDataManagerOutputProtocol = BloodRequestDetailInteractor()
            
            let remoteDataManager: BloodRequestDetailRemoteDataManagerInputProtocol & BloodRequestDetailValidationOutputProtocol  = BloodRequestDetailRemoteDataManager()
            
            let validationManager: BloodRequestDetailValidationInputProtocol  = BloodRequestDetailValidationManager()
            
            let localDataManager: BloodRequestDetailLocalDataManagerInputProtocol = BloodRequestDetailLocalDataManager()
            
            let profileManager = UserProfileSingleton.sharedInstance
            
            let wireFrame: BloodRequestDetailWireFrameProtocol = BloodRequestDetailWireFrames()
            
            view.presenter = presenter
            presenter.view = view
            presenter.wireFrame = wireFrame
            presenter.interactor = interactor
            interactor.presenter = presenter
            interactor.localDatamanager = localDataManager
            interactor.remoteDatamanager = remoteDataManager
            remoteDataManager.remoteRequestHandler = interactor
            remoteDataManager.validationManager = validationManager
            validationManager.BloodRequestDetailValidationHandler = remoteDataManager
            localDataManager.localRequestHandler = interactor
            localDataManager.userProfileManager = profileManager
            
            return viewController
        }
        return UIViewController()
    }
    
    func popView(_ view: BloodRequestDetailViewProtocol) {
        if let viewController = view as? UIViewController {
            viewController.navigationController?.popViewController(animated: true)
        }
    }    
}
