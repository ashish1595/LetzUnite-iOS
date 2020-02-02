//
//  FeedsWireFrames.swift
//  LetzUnite
//
//  Created by Himanshu on 4/4/18.
//  Copyright © 2018 LetzUnite. All rights reserved.
//

import Foundation
import UIKit

class FeedsWireFrames: NSObject,FeedsWireFrameProtocol {
    
    let transition = AppStoreCardTransition()//CircularTransition()
    
    var cardCenter:CGPoint? = nil
    var cardFrame:CGRect? = nil
    var imageFrame:CGRect? = nil
    var titleFrame:CGRect? = nil
    var descFrame:CGRect? = nil
    var bottomViewFrame:CGRect? = nil
    
    static func createFeedsModule() -> UIViewController {
        let viewController = mainStoryboard.instantiateViewController(withIdentifier: feedsViewSID)
        if let view = viewController as? FeedsView {
            let presenter: FeedsPresenterProtocol & FeedsInteractorOutputProtocol = FeedsPresenter()
            
            let interactor: FeedsInteractorInputProtocol & FeedsRemoteDataManagerOutputProtocol & FeedsLocalDataManagerOutputProtocol = FeedsInteractor()
            
            let remoteDataManager: FeedsRemoteDataManagerInputProtocol & FeedsValidationOutputProtocol  = FeedsRemoteDataManager()
            
            let validationManager: FeedsValidationInputProtocol  = FeedsValidationManager()

            let localDataManager: FeedsLocalDataManagerInputProtocol = FeedsLocalDataManager()

            let profileManager = UserProfileSingleton.sharedInstance

            let wireFrame: FeedsWireFrameProtocol = FeedsWireFrames()
            
            view.presenter = presenter
            presenter.view = view
            presenter.wireFrame = wireFrame
            presenter.interactor = interactor
            interactor.presenter = presenter
            interactor.localDatamanager = localDataManager
            interactor.remoteDatamanager = remoteDataManager
            remoteDataManager.remoteRequestHandler = interactor
            remoteDataManager.validationManager = validationManager
            validationManager.feedsValidationHandler = remoteDataManager
            localDataManager.localRequestHandler = interactor
            localDataManager.userProfileManager = profileManager
            
            return viewController
        }
        return UIViewController()
    }
    
    func pushNotificationScreen(from view: FeedsViewProtocol) {
        let notificationModule = NotificationWireFrames.createNotificationModule()
        if let sourceView = baseNavigationController {
            sourceView.pushViewController(notificationModule, animated: true)
        }
    }
    
    func pushBloodRequestsScreen(from view: FeedsViewProtocol) {
        let bloodRequestsModule = BloodRequestWireFrames.createBloodRequestModule()
                if let sourceView = view as? UIViewController {
                    sourceView.navigationController?.pushViewController(bloodRequestsModule, animated: true)
                }
    }
}


extension FeedsWireFrames: UIViewControllerTransitioningDelegate{
    
    func presentFeedsDetailViewScreen(from view: FeedsViewProtocol, cardFrame: CGRect, cardCenter: CGPoint, imageFrame: CGRect, titleFrame: CGRect, descFrame: CGRect, bottomViewFrame: CGRect) {
        
         self.cardCenter = cardCenter
         self.cardFrame = cardFrame
         self.imageFrame = imageFrame
         self.titleFrame = titleFrame
         self.descFrame = descFrame
         self.bottomViewFrame = bottomViewFrame
        
        let feedsDetailModule = FeedsDetailWireFrames.createFeedsDetailModule()
        let navCon = UINavigationController(rootViewController: feedsDetailModule)
        navCon.isNavigationBarHidden = true
        navCon.transitioningDelegate = self
        navCon.modalPresentationStyle = .custom
        
//        feedsDetailModule.transitioningDelegate = self
//        feedsDetailModule.navigationController?.modalPresentationStyle = .custom
        
        if let viewController = view as? UIViewController {
            viewController.present(navCon, animated: true, completion: nil)
//            viewController.navigationController?.pushViewController(feedsDetailModule, animated: true)
        }
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .present
        transition.startingFrame = cardFrame!
        transition.startingPoint = cardCenter!
        transition.imageViewStartingFrame = imageFrame!
        transition.titleLabelStartingFrame = titleFrame!
        transition.descLabelStartingFrame = descFrame!
        transition.bottomShareViewFrame = bottomViewFrame!
        return transition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .dismiss
        transition.startingPoint = CGPoint(x: dismissed.view.frame.size.width/2, y: dismissed.view.frame.size.height - 30)
        return transition
    }
}





