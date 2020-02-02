//
//  SearchWireFrames.swift
//  LetzUnite
//
//  Created by Himanshu on 4/4/18.
//  Copyright © 2018 LetzUnite. All rights reserved.
//

import Foundation
import UIKit

class SearchWireFrames: SearchWireFrameProtocol {
    
    static func createSearchModule() -> UIViewController {
        let viewController = mainStoryboard.instantiateViewController(withIdentifier: searchViewSID)
        if let view = viewController as? SearchView {
            let presenter: SearchPresenterProtocol & SearchInteractorOutputProtocol = SearchPresenter()
            
            let interactor: SearchInteractorInputProtocol & SearchRemoteDataManagerOutputProtocol & SearchLocalDataManagerOutputProtocol = SearchInteractor()
            
            let remoteDataManager: SearchRemoteDataManagerInputProtocol & SearchValidationOutputProtocol  = SearchRemoteDataManager()
            
            let validationManager: SearchValidationInputProtocol = SearchValidationManager()

            let localDataManager: SearchLocalDataManagerInputProtocol = SearchLocalDataManager()

            let profileManager = UserProfileSingleton.sharedInstance

            let wireFrame: SearchWireFrameProtocol = SearchWireFrames()
            
            view.presenter = presenter
            presenter.view = view
            presenter.wireFrame = wireFrame
            presenter.interactor = interactor
            interactor.presenter = presenter
            interactor.localDatamanager = localDataManager
            interactor.remoteDatamanager = remoteDataManager
            remoteDataManager.remoteRequestHandler = interactor
            remoteDataManager.validationManager = validationManager
            validationManager.searchValidationHandler = remoteDataManager
            localDataManager.localRequestHandler = interactor
            localDataManager.userProfileManager = profileManager
            
            return viewController
        }
        return UIViewController()
    }
    
    func presentVisitProfileScreen(from view: SearchViewProtocol) {
        let visitProfileModule = VisitProfileWireFrames.createVisitProfileModule()
        if let sourceView = view as? UIViewController {
            sourceView.navigationController?.pushViewController(visitProfileModule, animated: true)
        }
    }
    
}
