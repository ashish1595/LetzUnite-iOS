//
//  BloodRequestDetailView.swift
//  LetzUnite
//
//  Created by B0081006 on 6/30/18.
//  Copyright © 2018 Airtel. All rights reserved.
//

import UIKit

class BloodRequestDetailView: UIViewController {
    
    var presenter: BloodRequestDetailPresenterProtocol?
    var navView:NavigationBarView?
    @IBOutlet var label_BloodRequestDetails: UILabel!
    @IBOutlet var scrollVw_bloodRequestDetails: UIScrollView!

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupNavigationBar() {
        navView = NavigationBarView.init(navType: .kDetailNav, frame: CGRect(x: 0, y: UIApplication.shared.statusBarFrame.height, width: self.view.bounds.size.width, height: 56))
        navView?.delegate = self
        navView?.label_detailTitle.alpha = 0
        navView?.label_detailTitle.text = "Blood Request"
        navView?.label_detailTitle.textColor = .black
        navView?.layoutIfNeeded()
        self.navView?.backgroundColor = UIColor.white
        self.view.addSubview(navView!)
        self.view.bringSubview(toFront: self.label_BloodRequestDetails)
    }
}

extension BloodRequestDetailView: BloodRequestDetailViewProtocol {
    
    func prepareForAnimation() {
        
    }
    
    func styleBloodRequestDetailView() {
        self.setupNavigationBar()
    }
    
    func animateBloodRequestDetailView() {
        
    }
    
    func showError(_ message: String?) {
        Utility.showToast(with: message)
    }
    
    func showLoading() {
        
    }
    
    func hideLoading() {
        
    }
    
    func updateView(With parameters: RewardResponse?) {
        /*
         update UI
         */
    }
}

extension BloodRequestDetailView: NavigationBarProtocol {
    func didPressBackButton() {
        presenter?.popView(self)
    }
}

extension BloodRequestDetailView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if(scrollView.contentOffset.y > 46) {
            UIView.animate(withDuration: 0.5, animations: {
                self.navView?.label_detailTitle.isHidden = false
                self.navView?.label_detailTitle.alpha = 1.0
                self.label_BloodRequestDetails.alpha = 0.0
            })
        }else {
            UIView.animate(withDuration: 0.5, animations: {
                self.navView?.label_detailTitle.alpha = 0.0
                self.label_BloodRequestDetails.alpha = 1.0
            })
        }
    }
}
