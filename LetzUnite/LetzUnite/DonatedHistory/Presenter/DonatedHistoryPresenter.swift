//
//  DonatedHistoryPresenter.swift
//  LetzUnite
//
//  Created by B0081006 on 6/24/18.
//  Copyright © 2018 Airtel. All rights reserved.
//

import Foundation

class DonatedHistoryPresenter: DonatedHistoryPresenterProtocol {
    var view: DonatedHistoryViewProtocol?
    var interactor: DonatedHistoryInteractorInputProtocol?
    var wireFrame: DonatedHistoryWireFrameProtocol?
    
    func viewDidLoad() {
        self.fetchDonatedHistory()
    }
    
    func fetchDonatedHistory() {
        interactor?.fetchDonatedHistory()
    }
    
    func showBloodDonatedRequestDetailScreen() {
        wireFrame?.pushBloodDonatedRequestDetailScreen(from: view!)
    }
}


extension DonatedHistoryPresenter: DonatedHistoryInteractorOutputProtocol {
    func didFetchDonatedHistory(With response: RewardResponse?) {
        view?.updateView(With: response)
        view?.hideLoading()
    }
    
    func didFailToFetchDonatedHistory(_ message: String?) {
        view?.hideLoading()
        view?.showError(message)
    }
}
