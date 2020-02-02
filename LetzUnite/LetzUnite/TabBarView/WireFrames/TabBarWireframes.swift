//
//  TabBarWireframes.swift
//  LetzUnite
//
//  Created by Himanshu on 4/4/18.
//  Copyright © 2018 LetzUnite. All rights reserved.
//

import Foundation
import UIKit

class TabBarWireFrames: NSObject, TabBarWireFrameProtocol {
    
    let transition = CircularTransition()
    
    static func createTabBarModule() -> TabBarView {
    
        let feedsModule = FeedsWireFrames.createFeedsModule()
        let searchModule = SearchWireFrames.createSearchModule()
        let createRequestModule = CreateRequestWireFrames.createCreateRequestModule()
        let historyModule = HistoryWireFrames.createHistoryModule()
        let profileModule = ProfileWireFrames.createProfileModule()

        //let tabViewController:TabBarView? = TabBarView()
        
//        feedsModule.tabBarItem = UITabBarItem(title: "Home", image: UIImage(named: "home"), tag: 0)
//        feedsModule.tabBarItem.selectedImage = UIImage(named: "home_on")
//
//        searchModule.tabBarItem = UITabBarItem(title: "Search", image: UIImage(named: "history"), tag: 1)
//        searchModule.tabBarItem.selectedImage = UIImage(named: "history_on")
//
//        createRequestModule.tabBarItem = UITabBarItem(title: "donate", image: UIImage(named: "donate"), tag: 2)
//        createRequestModule.tabBarItem.selectedImage = UIImage(named: "donate")
//
//        rewardsModule.tabBarItem = UITabBarItem(title: "Rewards", image: UIImage(named: "rewards"), tag: 3)
//        rewardsModule.tabBarItem.selectedImage = UIImage(named: "rewards_on")
//
//        profileModule.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(named: "profile"), tag: 4)
//        rewardsModule.tabBarItem.selectedImage = UIImage(named: "profile_on")
//
//        let vcList = [feedsModule,searchModule,createRequestModule,rewardsModule,profileModule]
//
//        tabViewController?.viewControllers = vcList.map { UINavigationController(rootViewController: $0)}
        
        let tabViewController:TabBarView? = mainStoryboard.instantiateViewController(withIdentifier: tabBarViewSID) as? TabBarView
        let vcList = [feedsModule,searchModule,createRequestModule,historyModule,profileModule]
        tabViewController?.viewControllers = vcList
        tabViewController?.viewControllers = vcList.map {
            let nav = UINavigationController(rootViewController: $0)
            nav.isNavigationBarHidden = true
            return nav
        }
        
        //As history tab is fourth tab
        historyNavigationController = tabViewController?.viewControllers![3] as? UINavigationController
        
        //let vcList = (tabViewController?.viewControllers)!
        
//        tabViewController?.viewControllers = vcList
//
//        tabViewController?.viewControllers = vcList.map {
//            let nav = UINavigationController(rootViewController: $0)
//            nav.isNavigationBarHidden = true
//            return nav
//        }
        
        if let view = tabViewController {
            
            let presenter: TabBarPresenterProtocol & TabBarInteractorOutputProtocol = TabBarPresenter()
            
            let interactor: TabBarInteractorInputProtocol & TabBarRemoteDataManagerOutputProtocol = TabBarInteractor()
            
            let remoteDataManager: TabBarRemoteDataManagerInputProtocol  = TabBarRemoteDataManager()
            
            let wireFrame: TabBarWireFrameProtocol = TabBarWireFrames()
            
            view.presenter = presenter
            presenter.view = view
            presenter.wireFrame = wireFrame
            presenter.interactor = interactor
            interactor.presenter = presenter
            interactor.remoteDatamanager = remoteDataManager
            remoteDataManager.remoteRequestHandler = interactor
            
            return tabViewController!
        }
        return TabBarView()
    }
    
    
    
}


extension TabBarWireFrames: UIViewControllerTransitioningDelegate{
    
    func presentTabBarViewScreen(from view: TabBarViewProtocol, forUser username: String) {
        let createRequestModule = CreateRequestWireFrames.createCreateRequestModule()
        let navCon = UINavigationController(rootViewController: createRequestModule)
        navCon.isNavigationBarHidden = true
        navCon.transitioningDelegate = self
        navCon.modalPresentationStyle = .custom
        if let viewController = view as? UIViewController {
            viewController.present(navCon, animated: true, completion: nil)
        }
    }
    
    // MARK: UIViewControllerTransitioningDelegate
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .present
        transition.startingPoint = CGPoint(x: source.view.frame.size.width/2, y: source.view.frame.size.height - 30)
        transition.circleColor = appThemeColor//UIColor(displayP3Red: 66/255, green: 164/255, blue: 246/255, alpha: 1.0)
        return transition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .dismiss
        transition.startingPoint = CGPoint(x: dismissed.view.frame.size.width/2, y: dismissed.view.frame.size.height - 30)
        transition.circleColor = appThemeColor//UIColor(displayP3Red: 66/255, green: 164/255, blue: 246/255, alpha: 1.0)
        return transition
    }
}





