//
//  TabBarProtocols.swift
//  LetzUnite
//
//  Created by Himanshu on 4/4/18.
//  Copyright © 2018 LetzUnite. All rights reserved.
//

import Foundation
import UIKit

protocol TabBarViewProtocol: class {
    var presenter: TabBarPresenterProtocol? { get set }
    
    func styleTabBarView()

    func showError()
    func showLoading()
    func hideLoading()
}

protocol TabBarWireFrameProtocol: class {
    static func createTabBarModule() -> TabBarView
    func presentTabBarViewScreen(from view: TabBarViewProtocol, forUser username: String)
}

protocol TabBarPresenterProtocol: class {
    var view: TabBarViewProtocol? { get set }
    var interactor: TabBarInteractorInputProtocol? { get set }
    var wireFrame: TabBarWireFrameProtocol? { get set }
    
    func viewDidLoad()
    func openCreateRequestScreen()
}

protocol TabBarInteractorOutputProtocol: class {
    func didRetrieveTabBarDetail(_ tabBarDetails: Dictionary<String, Any>)
    func didFailWithError()
}

protocol TabBarInteractorInputProtocol: class {
    var presenter: TabBarInteractorOutputProtocol? { get set }
    var localDatamanager: TabBarLocalDataManagerInputProtocol? { get set }
    var remoteDatamanager: TabBarRemoteDataManagerInputProtocol? { get set }
    
    func retrieveTabBarDetails()
}

protocol TabBarRemoteDataManagerInputProtocol: class {
    var remoteRequestHandler: TabBarRemoteDataManagerOutputProtocol? { get set }
    
}

protocol TabBarRemoteDataManagerOutputProtocol: class {
    
}

protocol TabBarLocalDataManagerInputProtocol: class {
    
}

protocol TabBarLocalDataManagerOutputProtocol: class {
    
}
