//
//  VisitProfileWireFrames.swift
//  LetzUnite
//
//  Created by Himanshu on 4/4/18.
//  Copyright © 2018 LetzUnite. All rights reserved.
//

import Foundation
import UIKit

class VisitProfileWireFrames: VisitProfileWireFrameProtocol {
    
    static func createVisitProfileModule() -> UIViewController {
        let viewController = mainStoryboard.instantiateViewController(withIdentifier: visitProfileViewSID)
        if let view = viewController as? VisitProfileView {
            let presenter: VisitProfilePresenterProtocol & VisitProfileInteractorOutputProtocol = VisitProfilePresenter()
            
            let interactor: VisitProfileInteractorInputProtocol & VisitProfileRemoteDataManagerOutputProtocol & VisitProfileLocalDataManagerOutputProtocol = VisitProfileInteractor()
            
            let remoteDataManager: VisitProfileRemoteDataManagerInputProtocol & VisitProfileValidationOutputProtocol  = VisitProfileRemoteDataManager()
            
            let validationManager: VisitProfileValidationInputProtocol  = VisitProfileValidationManager()

            let localDataManager: VisitProfileLocalDataManagerInputProtocol = VisitProfileLocalDataManager()

            let VisitProfileManager = UserProfileSingleton.sharedInstance

            let wireFrame: VisitProfileWireFrameProtocol = VisitProfileWireFrames()
            
            view.presenter = presenter
            presenter.view = view
            presenter.wireFrame = wireFrame
            presenter.interactor = interactor
            interactor.presenter = presenter
            interactor.localDatamanager = localDataManager
            interactor.remoteDatamanager = remoteDataManager
            remoteDataManager.remoteRequestHandler = interactor
            remoteDataManager.validationManager = validationManager
            validationManager.visitProfileValidationHandler = remoteDataManager
            localDataManager.localRequestHandler = interactor
            localDataManager.userVisitProfileManager = VisitProfileManager
            
            return viewController
        }
        return UIViewController()
    }
    
    func presentChatScreen(from view: VisitProfileViewProtocol) {
        let chatModule = ChatWireFrames.createChatModule()
        if let sourceView = view as? UIViewController {
            sourceView.navigationController?.pushViewController(chatModule, animated: true)
        }
    }
    
}
