//
//  FeedsDetailView.swift
//  LetzUnite
//
//  Created by B0081006 on 7/11/18.
//  Copyright © 2018 Airtel. All rights reserved.
//

import UIKit

class FeedsDetailView: UIViewController {

    var presenter: FeedsDetailPresenterProtocol?
    @IBOutlet var button_back: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.button_back.bringSubview(toFront: self.view)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func actionBack(_ sender: Any) {
        presenter?.popView(self)
    }
}


extension FeedsDetailView: FeedsDetailViewProtocol {
    
    func prepareForAnimation() {
        
    }
    
    func styleFeedsDetailView() {

    }
    
    func animateFeedsDetailView() {
        
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
