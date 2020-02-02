//
//  TabBarInteractor.swift
//  LetzUnite
//
//  Created by Himanshu on 4/4/18.
//  Copyright © 2018 LetzUnite. All rights reserved.
//

import Foundation

class TabBarInteractor: TabBarInteractorInputProtocol {
    var presenter: TabBarInteractorOutputProtocol?
    var localDatamanager: TabBarLocalDataManagerInputProtocol?
    var remoteDatamanager: TabBarRemoteDataManagerInputProtocol?
    
    func retrieveTabBarDetails() {
        
    }
}

extension TabBarInteractor: TabBarLocalDataManagerOutputProtocol {
    
}

extension TabBarInteractor: TabBarRemoteDataManagerOutputProtocol {
    
}
