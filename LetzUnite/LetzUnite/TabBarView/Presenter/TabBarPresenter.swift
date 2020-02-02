//
//  TabBarPresenter.swift
//  LetzUnite
//
//  Created by Himanshu on 4/4/18.
//  Copyright © 2018 LetzUnite. All rights reserved.
//

import Foundation

class TabBarPresenter: TabBarPresenterProtocol {
    var view: TabBarViewProtocol?
    var interactor: TabBarInteractorInputProtocol?
    var wireFrame: TabBarWireFrameProtocol?
    
    func viewDidLoad() {
        view?.styleTabBarView()
    }
    
    func openCreateRequestScreen() {
        wireFrame?.presentTabBarViewScreen(from: view!, forUser: "")
    }
}


extension TabBarPresenter: TabBarInteractorOutputProtocol {
    func didRetrieveTabBarDetail(_ tabBarDetails: Dictionary<String, Any>) {
        
    }
    
    func didFailWithError() {
        
    }
}
