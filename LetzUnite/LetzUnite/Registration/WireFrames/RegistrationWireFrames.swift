//
//  RegistrationWireFrames.swift
//  LetzUnite
//
//  Created by Himanshu on 3/26/18.
//  Copyright © 2018 LetzUnite. All rights reserved.
//

import Foundation
import UIKit

class RegistrationWireFrames: RegistrationWireFrameProtocol {
    
    static func createRegistrationModule() -> UIViewController {
        let viewController = mainStoryboard.instantiateViewController(withIdentifier: registrationSID)
        if let view = viewController as? RegistrationView {
            let presenter: RegistrationPresenterProtocol & RegistrationInteractorOutputProtocol = RegistrationPresenter()
            
            let interactor: RegistrationInterectorInputProtocol & RegistrationRemoteDataManagerOutputProtocol = RegistrationInteractor()
            
            let remoteDataManager: RegistrationRemoteDataManagerInputProtocol & RegistrationValidationOutputProtocol  = RegistrationRemoteDataManager()
            
            let validationManager: RegistrationValidationInputProtocol  = RegistrationValidationManager()
            
            let wireFrame: RegistrationWireFrameProtocol = RegistrationWireFrames()
            
            view.presenter = presenter
            presenter.view = view
            presenter.wireFrame = wireFrame
            presenter.interactor = interactor
            interactor.presenter = presenter
            interactor.remoteDatamanager = remoteDataManager
            remoteDataManager.remoteRequestHandler = interactor
            
            remoteDataManager.validationManager = validationManager
            validationManager.registrationValidationHandler = remoteDataManager
            
//            validationManager.registrationValidationHandler = remoteDataManager
//            remoteDataManager.validationManager = validationManager
            
            return viewController
        }
        return UIViewController()
    }
    
    func presentBaseViewScreen(from view: RegistrationViewProtocol, forUser username: String) {
        
    }
    
    func popToLoginScreen(from view: RegistrationViewProtocol) {
        if let sourceView = view as? UIViewController {
            sourceView.navigationController?.popViewController(animated: true)
        }
    }
    
    func popToLoginScreenAndShowSignInView(from view: RegistrationViewProtocol, with email: String?) {
        if let sourceView = view as? UIViewController {
            sourceView.navigationController?.popViewController(animated: true)
            if let topVc = sourceView.navigationController?.topViewController as? LoginView {
                topVc.showSignInView(With: email)
            }
        }
    }
    
}
