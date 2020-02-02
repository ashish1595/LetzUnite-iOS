//
//  HistoryView.swift
//  LetzUnite
//
//  Created by B0081006 on 6/24/18.
//  Copyright © 2018 Airtel. All rights reserved.
//

import UIKit
import WormTabStrip

class HistoryView: UIViewController {

    var presenter: HistoryPresenterProtocol?
    var tabs:[UIViewController] = []
    var tabsTitle:[String] = []
    var numberOfTabs = 2
    var navView:NavigationBarView?
    @IBOutlet var label_history: UILabel!

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
        navView?.buttonBack.isHidden = true
        navView?.label_searchTitle.alpha = 0
        navView?.label_detailTitle.text = "History"
        navView?.layoutIfNeeded()
        self.view.addSubview(navView!)
    }
}

extension HistoryView: HistoryViewProtocol {
    func styleHistoryView() {
        self.setUpViewPager()
    }
}

extension HistoryView: WormTabStripDelegate {
    
    func setUpViewPager(){
        let frame =  CGRect(x: 0, y: label_history.frame.origin.y + label_history.frame.size.height, width: self.view.frame.size.width, height: self.view.frame.size.height - label_history.frame.size.height)
        let viewPager:WormTabStrip = WormTabStrip(frame: frame)
        self.view.addSubview(viewPager)
        viewPager.delegate = self
        viewPager.eyStyle.wormStyel = .LINE
        viewPager.eyStyle.isWormEnable = true
        viewPager.eyStyle.spacingBetweenTabs = 0
        viewPager.eyStyle.dividerBackgroundColor = .clear
        viewPager.eyStyle.tabItemSelectedColor = .red
        viewPager.eyStyle.tabItemDefaultColor = .darkGray
        viewPager.eyStyle.topScrollViewBackgroundColor = .clear
        viewPager.eyStyle.WormColor = .red
        viewPager.currentTabIndex = 0
        viewPager.buildUI()
    }
    
    func WTSNumberOfTabs() -> Int {
        return self.numberOfTabs
    }
    
    func WTSTitleForTab(index: Int) -> String {
        return self.tabsTitle[index]
    }
    
    func WTSViewOfTab(index: Int) -> UIView {
        let view:UIView = self.tabs[index].view
        view.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height - label_history.frame.origin.y + label_history.frame.size.height)
        return self.tabs[index].view
    }
    
    func WTSReachedLeftEdge(panParam: UIPanGestureRecognizer) {
        
    }
    
    func WTSReachedRightEdge(panParam: UIPanGestureRecognizer) {
        
    }
}

extension HistoryView: NavigationBarProtocol {
    
}
