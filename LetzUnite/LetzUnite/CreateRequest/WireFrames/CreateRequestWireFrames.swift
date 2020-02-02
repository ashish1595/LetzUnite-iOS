//
//  CreateRequestWireFrames.swift
//  LetzUnite
//
//  Created by Himanshu on 4/4/18.
//  Copyright © 2018 LetzUnite. All rights reserved.
//

import Foundation
import UIKit

class CreateRequestWireFrames: CreateRequestWireFrameProtocol {
    
    static func createCreateRequestModule() -> UIViewController {
        let viewController = mainStoryboard.instantiateViewController(withIdentifier: createRequestViewSID)
        if let view = viewController as? CreateRequestView {
            let presenter: CreateRequestPresenterProtocol & CreateRequestInteractorOutputProtocol = CreateRequestPresenter()
            
            let interactor: CreateRequestInteractorInputProtocol & CreateRequestRemoteDataManagerOutputProtocol & CreateRequestLocalDataManagerOutputProtocol = CreateRequestInteractor()
            
            let remoteDataManager: CreateRequestRemoteDataManagerInputProtocol & CreateRequestValidationOutputProtocol  = CreateRequestRemoteDataManager()
            
            let validationManager: CreateRequestValidationInputProtocol  = CreateRequestValidationManager()

            let localDataManager: CreateRequestLocalDataManagerInputProtocol = CreateRequestLocalDataManager()

            let profileManager = UserProfileSingleton.sharedInstance
            if let profile = UserDefaults.retrieveObject(forKey: UserDefaultsSerializationKey.profile.rawValue) as? UserProfileSingleton {
                profileManager.userToken = profile.userToken
                profileManager._id = profile._id
                profileManager.name = profile.name
                profileManager.emailId = profile.emailId
                profileManager.mobileNumber = profile.mobileNumber
                profileManager.additionalInfo = profile.additionalInfo
            }
            
            let wireFrame: CreateRequestWireFrameProtocol = CreateRequestWireFrames()
            
            view.presenter = presenter
            presenter.view = view
            presenter.wireFrame = wireFrame
            presenter.interactor = interactor
            interactor.presenter = presenter
            interactor.localDatamanager = localDataManager
            interactor.remoteDatamanager = remoteDataManager
            remoteDataManager.remoteRequestHandler = interactor
            remoteDataManager.validationManager = validationManager
            validationManager.createRequestValidationHandler = remoteDataManager
            localDataManager.localRequestHandler = interactor
            localDataManager.userProfileManager = profileManager
            
            return viewController
        }
        return UIViewController()
    }
    
    func dismiss(_ view: CreateRequestViewProtocol) {
        if let viewController = view as? UIViewController {
            viewController.dismiss(animated: true, completion: nil)
        }
    }
}
