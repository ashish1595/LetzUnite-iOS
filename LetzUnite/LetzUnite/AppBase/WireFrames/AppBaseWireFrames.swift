//
//  AppBaseWireFrames.swift
//  LetzUnite
//
//  Created by Himanshu on 4/3/18.
//  Copyright © 2018 LetzUnite. All rights reserved.
//

import Foundation
import UIKit

class AppBaseWireFrames: AppBaseWireFrameProtocol {
    
    static func createAppBaseModule() -> UIViewController {
        let viewController = mainStoryboard.instantiateViewController(withIdentifier: appBaseViewSID)
        if let view = viewController as? AppBaseView {
            let presenter: AppBasePresenterProtocol & AppBaseInteractorOutputProtocol = AppBasePresenter()
            
            let interactor: AppBaseInteractorInputProtocol & AppBaseRemoteDataManagerOutputProtocol & AppBaseLocalDataManagerOutputProtocol = AppBaseInteractor()
            
            let remoteDataManager: AppBaseRemoteDataManagerInputProtocol  = AppBaseRemoteDataManager()
            
            let wireFrame: AppBaseWireFrameProtocol = AppBaseWireFrames()
            
            let localDataManager: AppBaseLocalDataManagerInputProtocol = AppBaseLocalDataManager()

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
            
            return viewController
        }
        return UIViewController()
    }
    
    
    func presentTabBarViewScreen(from view: AppBaseViewProtocol, forUser username: String) {
        let tabBarModule = TabBarWireFrames.createTabBarModule()
        if let sourceView = view as? UIViewController {
        sourceView.navigationController?.pushViewController(tabBarModule, animated: false)
        }
    }
    
}
