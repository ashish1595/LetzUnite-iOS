//
//  NotificationView.swift
//  LetzUnite
//
//  Created by B0081006 on 6/30/18.
//  Copyright © 2018 Airtel. All rights reserved.
//

import UIKit

class NotificationView: UIViewController {
    
    var presenter: NotificationPresenterProtocol?
    @IBOutlet var tableView_notifications: UITableView!
    var navView:NavigationBarView?
    @IBOutlet var label_notifications: UILabel!
    @IBOutlet var scrollVw_notification: UIScrollView!
    @IBOutlet var view_tableHeader: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        self.tableView_notifications.estimatedRowHeight = 140
        self.tableView_notifications.reloadData()
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
        navView?.label_detailTitle.text = "Notifications"
        navView?.label_detailTitle.textColor = .black
        navView?.layoutIfNeeded()
        self.navView?.backgroundColor = UIColor.white
        self.view.addSubview(navView!)
        self.view.bringSubview(toFront: self.label_notifications)
    }
}

extension NotificationView: NotificationViewProtocol {
    
    func prepareForAnimation() {
        
    }
    
    func styleNotificationView() {
        self.tableView_notifications.contentInset = UIEdgeInsets(top: 65, left: 0, bottom: 0, right: 0)
        self.setupNavigationBar()
    }
    
    func animateNotificationView() {
        
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

extension NotificationView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 12
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: NotificationCell1 = tableView.dequeueReusableCell(withIdentifier: CellIDs.notificationCell1ID.rawValue) as! NotificationCell1
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return self.view_tableHeader
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return self.view_tableHeader.frame.size.height
    }
}

extension NotificationView: NavigationBarProtocol {
    func didPressBackButton() {
        presenter?.popView(self)
    }
}

extension NotificationView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
            if(scrollView.contentOffset.y > 46) {
                UIView.animate(withDuration: 0.5, animations: {
                    self.navView?.label_detailTitle.isHidden = false
                    self.navView?.label_detailTitle.alpha = 1.0
                    self.label_notifications.alpha = 0.0
                })
            }else {
                UIView.animate(withDuration: 0.5, animations: {
                    self.navView?.label_detailTitle.alpha = 0.0
                    self.label_notifications.alpha = 1.0
                })
            }
    }
}
