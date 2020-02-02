//
//  HistoryLocalDataManager.swift
//  LetzUnite
//
//  Created by B0081006 on 6/24/18.
//  Copyright © 2018 Airtel. All rights reserved.
//

import Foundation

class HistoryLocalDataManager: HistoryLocalDataManagerInputProtocol {
    var userProfileManager: UserProfileSingleton?
    var localRequestHandler: HistoryLocalDataManagerOutputProtocol?
}
