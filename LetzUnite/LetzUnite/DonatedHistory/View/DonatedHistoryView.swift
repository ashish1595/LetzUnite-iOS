//
//  DonatedHistoryView.swift
//  LetzUnite
//
//  Created by B0081006 on 6/24/18.
//  Copyright © 2018 Airtel. All rights reserved.
//

import UIKit

class DonatedHistoryView: UIViewController {

    var presenter: DonatedHistoryPresenterProtocol?
    @IBOutlet var tableView_donated: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView_donated.estimatedRowHeight = 94
        self.tableView_donated.reloadData()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}


extension DonatedHistoryView: DonatedHistoryViewProtocol {
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

extension DonatedHistoryView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 12
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: DonatedHistoryCell = tableView.dequeueReusableCell(withIdentifier: CellIDs.donatedHistoryCellID.rawValue) as! DonatedHistoryCell
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.showBloodDonatedRequestDetailScreen()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}

