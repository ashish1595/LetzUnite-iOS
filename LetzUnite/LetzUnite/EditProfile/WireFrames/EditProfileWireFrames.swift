//
//  EditProfileWireFrames.swift
//  LetzUnite
//
//  Created by B0081006 on 6/24/18.
//  Copyright © 2018 Airtel. All rights reserved.
//

import Foundation
import UIKit

class EditProfileWireFrames: EditProfileWireFrameProtocol {
    
    static func createEditProfileModule() -> UIViewController {
        let viewController = mainStoryboard.instantiateViewController(withIdentifier: editProfileViewSID)
        if let view = viewController as? EditProfileView {
            let presenter: EditProfilePresenterProtocol & EditProfileInteractorOutputProtocol = EditProfilePresenter()
            
            let interactor: EditProfileInteractorInputProtocol & EditProfileRemoteDataManagerOutputProtocol & EditProfileLocalDataManagerOutputProtocol = EditProfileInteractor()
            
            let remoteDataManager: EditProfileRemoteDataManagerInputProtocol & EditProfileValidationOutputProtocol  = EditProfileRemoteDataManager()
            
            let validationManager: EditProfileValidationInputProtocol  = EditProfileValidationManager()
            
            let localDataManager: EditProfileLocalDataManagerInputProtocol = EditProfileLocalDataManager()
            
            let profileManager = UserProfileSingleton.sharedInstance
            
            let wireFrame: EditProfileWireFrameProtocol = EditProfileWireFrames()
            
            view.presenter = presenter
            presenter.view = view
            presenter.wireFrame = wireFrame
            presenter.interactor = interactor
            interactor.presenter = presenter
            interactor.localDatamanager = localDataManager
            interactor.remoteDatamanager = remoteDataManager
            remoteDataManager.remoteRequestHandler = interactor
            remoteDataManager.validationManager = validationManager
            validationManager.EditProfileValidationHandler = remoteDataManager
            localDataManager.localRequestHandler = interactor
            localDataManager.userProfileManager = profileManager
            
            return viewController
        }
        return UIViewController()
    }
    
    func popToProfileScreen(from view: EditProfileViewProtocol) {
        if let sourceView = view as? UIViewController {
            sourceView.navigationController?.popViewController(animated: true)
        }
    }
    
}
