//
//  HistoryInteractor.swift
//  LetzUnite
//
//  Created by B0081006 on 6/24/18.
//  Copyright © 2018 Airtel. All rights reserved.
//

import Foundation

class HistoryInteractor: HistoryInteractorInputProtocol {
    var presenter: HistoryInteractorOutputProtocol?
    var localDatamanager: HistoryLocalDataManagerInputProtocol?
    var remoteDatamanager: HistoryRemoteDataManagerInputProtocol?
    
}

extension HistoryInteractor: HistoryLocalDataManagerOutputProtocol {
    
}

extension HistoryInteractor: HistoryRemoteDataManagerOutputProtocol {
    
}
