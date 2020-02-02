//
//  ReceivedHistoryView.swift
//  LetzUnite
//
//  Created by B0081006 on 6/24/18.
//  Copyright © 2018 Airtel. All rights reserved.
//

import UIKit

class ReceivedHistoryView: UIViewController {

    var presenter: ReceivedHistoryPresenterProtocol?
    @IBOutlet var tableView_received: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView_received.estimatedRowHeight = 140
        self.tableView_received.reloadData()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension ReceivedHistoryView: ReceivedHistoryViewProtocol {
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

extension ReceivedHistoryView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 12
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ReceivedHistoryCell = tableView.dequeueReusableCell(withIdentifier: CellIDs.receivedHistoryCellID.rawValue) as! ReceivedHistoryCell
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.showBloodReceivedRequestDetailScreen()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}

