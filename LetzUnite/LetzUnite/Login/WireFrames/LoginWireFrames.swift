//
//  LoginWireFrames.swift
//  LetzUnite
//
//  Created by Himanshu on 3/26/18.
//  Copyright © 2018 LetzUnite. All rights reserved.
//

import Foundation
import UIKit

class LoginWireFrames: NSObject, LoginWireFrameProtocol {
    static func createLoginModule() -> UIViewController {
        let navController = mainStoryboard.instantiateViewController(withIdentifier: navigationSID)
        baseNavigationController = navController as? UINavigationController
        if let view = navController.childViewControllers.first as? LoginView {
            let presenter: LoginPresenterProtocol & LoginInteractorOutputProtocol = LoginPresenter()
            
            let interactor: LoginInterectorInputProtocol & LoginRemoteDataManagerOutputProtocol & LoginLocalDataManagerOutputProtocol = LoginInteractor()
            
            let localDataManager: LoginLocalDataManagerInputProtocol = LoginLocalDataManager()
            let remoteDataManager: LoginRemoteDataManagerInputProtocol & LoginValidationOutputProtocol  = LoginRemoteDataManager()
            let wireFrame: LoginWireFrameProtocol = LoginWireFrames()
            
            let validationManager: LoginValidationInputProtocol  = LoginValidationManager()
            
            let profileManager = UserProfileSingleton.sharedInstance
            
            view.presenter = presenter
            presenter.view = view
            presenter.wireFrame = wireFrame
            presenter.interactor = interactor
            interactor.presenter = presenter
            interactor.localDatamanager = localDataManager
            interactor.remoteDatamanager = remoteDataManager
            remoteDataManager.remoteRequestHandler = interactor
            localDataManager.localRequestHandler = interactor
            localDataManager.userProfileManager = profileManager
            
            remoteDataManager.validationManager = validationManager
            validationManager.loginValidationHandler = remoteDataManager
            
            return navController
        }
        return UIViewController()
    }
    
    
    func presentNewUserRegistrationScreen(from view: LoginViewProtocol) {
        let registrationModule = RegistrationWireFrames.createRegistrationModule()
        if let sourceView = view as? UIViewController {
           sourceView.navigationController?.pushViewController(registrationModule, animated: true)
        }
    }

}


extension LoginWireFrames: UIViewControllerTransitioningDelegate{
    
    func presentBaseViewScreen(from view: LoginViewProtocol) {
        let appBaseModule = AppBaseWireFrames.createAppBaseModule()
        appBaseModule.transitioningDelegate = self
        appBaseModule.modalPresentationStyle = .custom
        if let sourceView = view as? UIViewController {
            baseNavigationController = sourceView.navigationController
            sourceView.navigationController?.pushViewController(appBaseModule, animated: false)
        }
    }
    
    // MARK: UIViewControllerTransitioningDelegate
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return TKFadeInAnimator(transitionDuration: 0.5, startingAlpha: 0.8)
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return nil
    }
}




