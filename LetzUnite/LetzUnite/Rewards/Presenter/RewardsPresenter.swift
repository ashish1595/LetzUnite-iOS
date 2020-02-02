//
//  RewardsPresenter.swift
//  LetzUnite
//
//  Created by Himanshu on 4/4/18.
//  Copyright © 2018 LetzUnite. All rights reserved.
//

import Foundation

class RewardsPresenter: RewardsPresenterProtocol {
    var view: RewardsViewProtocol?
    var interactor: RewardsInteractorInputProtocol?
    var wireFrame: RewardsWireFrameProtocol?
    
    func viewDidLoad() {
        self.fetchRewards()
    }
    
    func fetchRewards() {
        interactor?.fetchRewards()
    }
}


extension RewardsPresenter: RewardsInteractorOutputProtocol {
    func didFetchRewards(With response: RewardResponse?) {
        view?.updateView(With: response)
        view?.hideLoading()
    }
    
    func didFailToFetchRewards(_ message: String?) {
        view?.hideLoading()
        view?.showError(message)
    }
}
