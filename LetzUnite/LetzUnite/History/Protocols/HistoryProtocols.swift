//
//  HistoryProtocols.swift
//  LetzUnite
//
//  Created by B0081006 on 6/24/18.
//  Copyright © 2018 Airtel. All rights reserved.
//

import Foundation
import UIKit

protocol HistoryViewProtocol: class {
    var presenter: HistoryPresenterProtocol? { get set }
    
    func styleHistoryView()
}

protocol HistoryWireFrameProtocol: class {
    static func createHistoryModule() -> UIViewController
}

protocol HistoryPresenterProtocol: class {
    var view: HistoryViewProtocol? { get set }
    var interactor: HistoryInteractorInputProtocol? { get set }
    var wireFrame: HistoryWireFrameProtocol? { get set }
    
    func viewDidLoad()
}

protocol HistoryInteractorOutputProtocol: class {
    
}

protocol HistoryInteractorInputProtocol: class {
    var presenter: HistoryInteractorOutputProtocol? { get set }
    var localDatamanager: HistoryLocalDataManagerInputProtocol? { get set }
    var remoteDatamanager: HistoryRemoteDataManagerInputProtocol? { get set }
    
}

protocol HistoryRemoteDataManagerInputProtocol: class {
    var remoteRequestHandler: HistoryRemoteDataManagerOutputProtocol? { get set }
    var validationManager: HistoryValidationInputProtocol? { get set }    
}

protocol HistoryRemoteDataManagerOutputProtocol: class {

}

protocol HistoryLocalDataManagerInputProtocol: class {
    var userProfileManager: UserProfileSingleton? { get set }
    var localRequestHandler: HistoryLocalDataManagerOutputProtocol? { get set }
}

protocol HistoryLocalDataManagerOutputProtocol: class {
    
}

protocol HistoryValidationInputProtocol: class{
    var HistoryValidationHandler: HistoryValidationOutputProtocol? {get set}
}

protocol HistoryValidationOutputProtocol: class{

}
