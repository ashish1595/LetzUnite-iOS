//
//  AppBasePresenter.swift
//  LetzUnite
//
//  Created by Himanshu on 4/3/18.
//  Copyright © 2018 LetzUnite. All rights reserved.
//

import Foundation

class AppBasePresenter: AppBasePresenterProtocol {
    var view: AppBaseViewProtocol?
    var interactor: AppBaseInteractorInputProtocol?
    var wireFrame: AppBaseWireFrameProtocol?
    
    func viewDidLoad() {
        interactor?.localDatamanager?.retrieveUserProfile()
    }
    
    func hideWelcomeView() {
        view?.hideWelcomeView()
    }
    
    func showNextScreen() {
        wireFrame?.presentTabBarViewScreen(from: view!, forUser: "")
    }
}


extension AppBasePresenter: AppBaseInteractorOutputProtocol {
    func didRetrieveUserProfile(_ userProfile: UserProfileSingleton) {
        view?.showWelcomeView(with: userProfile.name!)
    }
    
    func didRetrieveTabBarDetail(_ tabBarDetails: Dictionary<String, Any>) {
        
    }
    
    func didFailWithError() {
        
    }
    
}
