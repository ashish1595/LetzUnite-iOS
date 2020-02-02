//
//  FeedsDetailWireframes.swift
//  LetzUnite
//
//  Created by B0081006 on 7/11/18.
//  Copyright © 2018 Airtel. All rights reserved.
//

import Foundation
import UIKit

class FeedsDetailWireFrames: FeedsDetailWireFrameProtocol {
    
    static func createFeedsDetailModule() -> UIViewController {
        let viewController = mainStoryboard.instantiateViewController(withIdentifier: feedsDetailViewSID)
        if let view = viewController as? FeedsDetailView {
            let presenter: FeedsDetailPresenterProtocol & FeedsDetailInteractorOutputProtocol = FeedsDetailPresenter()
            
            let interactor: FeedsDetailInteractorInputProtocol & FeedsDetailRemoteDataManagerOutputProtocol & FeedsDetailLocalDataManagerOutputProtocol = FeedsDetailInteractor()
            
            let remoteDataManager: FeedsDetailRemoteDataManagerInputProtocol & FeedsDetailValidationOutputProtocol  = FeedsDetailRemoteDataManager()
            
            let validationManager: FeedsDetailValidationInputProtocol  = FeedsDetailValidationManager()
            
            let localDataManager: FeedsDetailLocalDataManagerInputProtocol = FeedsDetailLocalDataManager()
            
            let profileManager = UserProfileSingleton.sharedInstance
            
            let wireFrame: FeedsDetailWireFrameProtocol = FeedsDetailWireFrames()
            
            view.presenter = presenter
            presenter.view = view
            presenter.wireFrame = wireFrame
            presenter.interactor = interactor
            interactor.presenter = presenter
            interactor.localDatamanager = localDataManager
            interactor.remoteDatamanager = remoteDataManager
            remoteDataManager.remoteRequestHandler = interactor
            remoteDataManager.validationManager = validationManager
            validationManager.FeedsDetailValidationHandler = remoteDataManager
            localDataManager.localRequestHandler = interactor
            localDataManager.userProfileManager = profileManager
            
            return viewController
        }
        return UIViewController()
    }
    
    func popView(_ view: FeedsDetailViewProtocol) {
            if let viewController = view as? UIViewController {
                viewController.dismiss(animated: true, completion: nil)
            }
    }
}
