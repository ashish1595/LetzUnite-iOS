//
//  ProfileWireFrames.swift
//  LetzUnite
//
//  Created by Himanshu on 4/4/18.
//  Copyright © 2018 LetzUnite. All rights reserved.
//

import Foundation
import UIKit

class ProfileWireFrames: ProfileWireFrameProtocol {
    
    static func createProfileModule() -> UIViewController {
        let viewController = mainStoryboard.instantiateViewController(withIdentifier: profileViewSID)
        if let view = viewController as? ProfileView {
            let presenter: ProfilePresenterProtocol & ProfileInteractorOutputProtocol = ProfilePresenter()
            
            let interactor: ProfileInteractorInputProtocol & ProfileRemoteDataManagerOutputProtocol & ProfileLocalDataManagerOutputProtocol = ProfileInteractor()
            
            let remoteDataManager: ProfileRemoteDataManagerInputProtocol & ProfileValidationOutputProtocol  = ProfileRemoteDataManager()
            
            let validationManager: ProfileValidationInputProtocol  = ProfileValidationManager()

            let localDataManager: ProfileLocalDataManagerInputProtocol = ProfileLocalDataManager()

            let profileManager = UserProfileSingleton.sharedInstance

            let wireFrame: ProfileWireFrameProtocol = ProfileWireFrames()
            
            view.presenter = presenter
            presenter.view = view
            presenter.wireFrame = wireFrame
            presenter.interactor = interactor
            interactor.presenter = presenter
            interactor.localDatamanager = localDataManager
            interactor.remoteDatamanager = remoteDataManager
            remoteDataManager.remoteRequestHandler = interactor
            remoteDataManager.validationManager = validationManager
            validationManager.profileValidationHandler = remoteDataManager
            localDataManager.localRequestHandler = interactor
            localDataManager.userProfileManager = profileManager
            
            return viewController
        }
        return UIViewController()
    }
    
    func presentEditProfileScreen(from view: ProfileViewProtocol) {
        let editProfileModule = EditProfileWireFrames.createEditProfileModule()
        if let sourceView = view as? UIViewController {
            sourceView.navigationController?.pushViewController(editProfileModule, animated: true)
        }
    }
    
}
