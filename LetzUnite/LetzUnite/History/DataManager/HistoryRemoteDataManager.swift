//
//  HistoryRemoteDataManager.swift
//  LetzUnite
//
//  Created by B0081006 on 6/24/18.
//  Copyright © 2018 Airtel. All rights reserved.
//

import Foundation
import SwiftyJSON

class HistoryRemoteDataManager: HistoryRemoteDataManagerInputProtocol {
    var remoteRequestHandler: HistoryRemoteDataManagerOutputProtocol?
    var validationManager: HistoryValidationInputProtocol?
}

extension HistoryRemoteDataManager: HistoryValidationOutputProtocol {
    
}
