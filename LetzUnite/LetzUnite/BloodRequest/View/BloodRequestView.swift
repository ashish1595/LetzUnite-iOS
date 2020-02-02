//
//  BloodRequestView.swift
//  LetzUnite
//
//  Created by B0081006 on 6/30/18.
//  Copyright © 2018 Airtel. All rights reserved.
//

import UIKit

class BloodRequestView: UIViewController {
    
    var presenter: BloodRequestPresenterProtocol?
    @IBOutlet var tableView_BloodRequests: UITableView!
    var navView:NavigationBarView?
    @IBOutlet var label_BloodRequests: UILabel!
    @IBOutlet var view_tableHeader: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        self.tableView_BloodRequests.estimatedRowHeight = 140
        self.tableView_BloodRequests.reloadData()
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
        navView?.label_detailTitle.text = "BloodRequests"
        navView?.label_detailTitle.textColor = .black
        navView?.layoutIfNeeded()
        self.navView?.backgroundColor = UIColor.white
        self.view.addSubview(navView!)
        self.view.bringSubview(toFront: self.label_BloodRequests)
    }
}

extension BloodRequestView: BloodRequestViewProtocol {
    
    func prepareForAnimation() {
        
    }
    
    func styleBloodRequestView() {
        self.tableView_BloodRequests.contentInset = UIEdgeInsets(top: 65, left: 0, bottom: 0, right: 0)
        self.setupNavigationBar()
    }
    
    func animateBloodRequestView() {
        
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

extension BloodRequestView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 12
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: BloodRequestTableCell = tableView.dequeueReusableCell(withIdentifier: CellIDs.bloodRequestTableCellID.rawValue) as! BloodRequestTableCell
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.showBloodRequestDetailScreen()
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

extension BloodRequestView: NavigationBarProtocol {
    func didPressBackButton() {
        presenter?.popView(self)
    }
}

extension BloodRequestView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if(scrollView.contentOffset.y > 46) {
            UIView.animate(withDuration: 0.5, animations: {
                self.navView?.label_detailTitle.isHidden = false
                self.navView?.label_detailTitle.alpha = 1.0
                self.label_BloodRequests.alpha = 0.0
            })
        }else {
            UIView.animate(withDuration: 0.5, animations: {
                self.navView?.label_detailTitle.alpha = 0.0
                self.label_BloodRequests.alpha = 1.0
            })
        }
    }
}
