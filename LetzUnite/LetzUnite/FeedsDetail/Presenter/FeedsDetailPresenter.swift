//
//  FeedsDetailPresenter.swift
//  LetzUnite
//
//  Created by B0081006 on 7/11/18.
//  Copyright © 2018 Airtel. All rights reserved.
//

import Foundation

class FeedsDetailPresenter: FeedsDetailPresenterProtocol {
    var view: FeedsDetailViewProtocol?
    var interactor: FeedsDetailInteractorInputProtocol?
    var wireFrame: FeedsDetailWireFrameProtocol?
    
    func viewDidLoad() {
        view?.prepareForAnimation()
        view?.styleFeedsDetailView()
        view?.animateFeedsDetailView()
        
        self.fetchFeedsDetail()
    }
    
    func fetchFeedsDetail() {
        interactor?.fetchFeedsDetail()
    }
    
    func popView(_ view: FeedsDetailViewProtocol) {
        wireFrame?.popView(view)
    }
}


extension FeedsDetailPresenter: FeedsDetailInteractorOutputProtocol {
    func didFetchFeedsDetail(With response: RewardResponse?) {
        view?.updateView(With: response)
        view?.hideLoading()
    }
    
    func didFailToFetchFeedsDetail(_ message: String?) {
        view?.hideLoading()
        view?.showError(message)
    }
}
