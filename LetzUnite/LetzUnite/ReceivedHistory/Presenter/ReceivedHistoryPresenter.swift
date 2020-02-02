//
//  ReceivedHistoryPresenter.swift
//  LetzUnite
//
//  Created by B0081006 on 6/24/18.
//  Copyright © 2018 Airtel. All rights reserved.
//

import Foundation

class ReceivedHistoryPresenter: ReceivedHistoryPresenterProtocol {
    var view: ReceivedHistoryViewProtocol?
    var interactor: ReceivedHistoryInteractorInputProtocol?
    var wireFrame: ReceivedHistoryWireFrameProtocol?
    
    func viewDidLoad() {
        self.fetchReceivedHistory()
    }
    
    func fetchReceivedHistory() {
        interactor?.fetchReceivedHistory()
    }
    
    func showBloodReceivedRequestDetailScreen() {
        wireFrame?.pushBloodReceivedRequestDetailScreen(from: view!)
    }
}


extension ReceivedHistoryPresenter: ReceivedHistoryInteractorOutputProtocol {
    func didFetchReceivedHistory(With response: RewardResponse?) {
        view?.updateView(With: response)
        view?.hideLoading()
    }
    
    func didFailToFetchReceivedHistory(_ message: String?) {
        view?.hideLoading()
        view?.showError(message)
    }
}
