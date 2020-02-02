//
//  ChatWireFrames.swift
//  LetzUnite
//
//  Created by B0081006 on 6/24/18.
//  Copyright © 2018 Airtel. All rights reserved.
//

import Foundation
import UIKit

class ChatWireFrames: ChatWireFrameProtocol {
    
    static func createChatModule() -> UIViewController {
        let viewController = mainStoryboard.instantiateViewController(withIdentifier: chatViewSID)
        if let view = viewController as? ChatView {
            let presenter: ChatPresenterProtocol & ChatInteractorOutputProtocol = ChatPresenter()
            
            let interactor: ChatInteractorInputProtocol & ChatRemoteDataManagerOutputProtocol & ChatLocalDataManagerOutputProtocol = ChatInteractor()
            
            let remoteDataManager: ChatRemoteDataManagerInputProtocol & ChatValidationOutputProtocol  = ChatRemoteDataManager()
            
            let validationManager: ChatValidationInputProtocol  = ChatValidationManager()
            
            let localDataManager: ChatLocalDataManagerInputProtocol = ChatLocalDataManager()
            
            let profileManager = UserProfileSingleton.sharedInstance
            
            let wireFrame: ChatWireFrameProtocol = ChatWireFrames()
            
            view.presenter = presenter
            presenter.view = view
            presenter.wireFrame = wireFrame
            presenter.interactor = interactor
            interactor.presenter = presenter
            interactor.localDatamanager = localDataManager
            interactor.remoteDatamanager = remoteDataManager
            remoteDataManager.remoteRequestHandler = interactor
            remoteDataManager.validationManager = validationManager
            validationManager.ChatValidationHandler = remoteDataManager
            localDataManager.localRequestHandler = interactor
            localDataManager.userProfileManager = profileManager
            
            return viewController
        }
        return UIViewController()
    }
    
    func popToPreviousScreen(from view: ChatViewProtocol) {
        if let sourceView = view as? UIViewController {
            sourceView.navigationController?.popViewController(animated: true)
        }
    }
    
}
