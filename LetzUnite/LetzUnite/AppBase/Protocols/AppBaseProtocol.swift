//
//  AppBaseProtocol.swift
//  LetzUnite
//
//  Created by Himanshu on 4/3/18.
//  Copyright © 2018 LetzUnite. All rights reserved.
//

import Foundation
import UIKit

protocol AppBaseViewProtocol: class {
    var presenter: AppBasePresenterProtocol? { get set }

    func showWelcomeView(with name:String)
    func hideWelcomeView()
    func showError()
    func showLoading()
    func hideLoading()
}

protocol AppBaseWireFrameProtocol: class {
    static func createAppBaseModule() -> UIViewController
    func presentTabBarViewScreen(from view: AppBaseViewProtocol, forUser username: String)
}

protocol AppBasePresenterProtocol: class {
    var view: AppBaseViewProtocol? { get set }
    var interactor: AppBaseInteractorInputProtocol? { get set }
    var wireFrame: AppBaseWireFrameProtocol? { get set }
    
    func hideWelcomeView()
    func viewDidLoad()
    func showNextScreen()
}

protocol AppBaseInteractorOutputProtocol: class {
    func didRetrieveTabBarDetail(_ tabBarDetails: Dictionary<String, Any>)
    func didRetrieveUserProfile(_ userProfile:UserProfileSingleton)
    func didFailWithError()
}

protocol AppBaseInteractorInputProtocol: class {
    var presenter: AppBaseInteractorOutputProtocol? { get set }
    var localDatamanager: AppBaseLocalDataManagerInputProtocol? { get set }
    var remoteDatamanager: AppBaseRemoteDataManagerInputProtocol? { get set }
    
    func retrieveTabBarDetails()
}

protocol AppBaseRemoteDataManagerInputProtocol: class {
    var remoteRequestHandler: AppBaseRemoteDataManagerOutputProtocol? { get set }

}

protocol AppBaseRemoteDataManagerOutputProtocol: class {
    
}

protocol AppBaseLocalDataManagerInputProtocol: class {
    var userProfileManager: UserProfileSingleton? { get set }
    var localRequestHandler: AppBaseLocalDataManagerOutputProtocol? { get set }
    func retrieveUserProfile()
}

protocol AppBaseLocalDataManagerOutputProtocol: class {
    func onLocalUserRetrieved(_ userProfile: UserProfileSingleton)
    func onLocalDataManagerError()
}
