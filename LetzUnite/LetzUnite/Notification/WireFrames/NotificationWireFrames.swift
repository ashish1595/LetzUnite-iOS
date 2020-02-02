//
//  NotificationWireFrames.swift
//  LetzUnite
//
//  Created by B0081006 on 6/30/18.
//  Copyright © 2018 Airtel. All rights reserved.
//

import Foundation
import UIKit

class NotificationWireFrames: NotificationWireFrameProtocol {
    
    static func createNotificationModule() -> UIViewController {
        let viewController = mainStoryboard.instantiateViewController(withIdentifier: notificationViewSID)
        if let view = viewController as? NotificationView {
            let presenter: NotificationPresenterProtocol & NotificationInteractorOutputProtocol = NotificationPresenter()
            
            let interactor: NotificationInteractorInputProtocol & NotificationRemoteDataManagerOutputProtocol & NotificationLocalDataManagerOutputProtocol = NotificationInteractor()
            
            let remoteDataManager: NotificationRemoteDataManagerInputProtocol & NotificationValidationOutputProtocol  = NotificationRemoteDataManager()
            
            let validationManager: NotificationValidationInputProtocol  = NotificationValidationManager()
            
            let localDataManager: NotificationLocalDataManagerInputProtocol = NotificationLocalDataManager()
            
            let profileManager = UserProfileSingleton.sharedInstance
            
            let wireFrame: NotificationWireFrameProtocol = NotificationWireFrames()
            
            view.presenter = presenter
            presenter.view = view
            presenter.wireFrame = wireFrame
            presenter.interactor = interactor
            interactor.presenter = presenter
            interactor.localDatamanager = localDataManager
            interactor.remoteDatamanager = remoteDataManager
            remoteDataManager.remoteRequestHandler = interactor
            remoteDataManager.validationManager = validationManager
            validationManager.NotificationValidationHandler = remoteDataManager
            localDataManager.localRequestHandler = interactor
            localDataManager.userProfileManager = profileManager
            
            return viewController
        }
        return UIViewController()
    }
    
    func popView(_ view: NotificationViewProtocol) {
//        if let viewController = view as? UIViewController {
//            viewController.dismiss(animated: true, completion: nil)
//        }
        if let sourceView = baseNavigationController {
            sourceView.popViewController(animated: true)
        }
    }
}
