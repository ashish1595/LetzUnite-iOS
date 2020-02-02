//
//  TabBarView.swift
//  LetzUnite
//
//  Created by Himanshu on 4/1/18.
//  Copyright © 2018 LetzUnite. All rights reserved.
//

import UIKit

class TabBarView: AnimatedTabBarController {

    var presenter: TabBarPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        self.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension TabBarView: UITabBarControllerDelegate {
    public func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if let navigationController = viewController as? UINavigationController {
            if let topController = navigationController.topViewController {
                if topController.isKind(of: CreateRequestView.classForCoder()) {
                    presenter?.openCreateRequestScreen()
                    return false
                }else {
                    return true
                }
            }
        }
        return true
    }
}

extension TabBarView: TabBarViewProtocol {
    func styleTabBarView() {
        
    }
    
    func showError() {
        
    }
    
    func showLoading() {
        
    }
    
    func hideLoading() {
        
    }
}
