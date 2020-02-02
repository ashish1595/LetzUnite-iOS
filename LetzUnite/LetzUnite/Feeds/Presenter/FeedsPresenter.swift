//
//  FeedsPresenter.swift
//  LetzUnite
//
//  Created by Himanshu on 4/4/18.
//  Copyright © 2018 LetzUnite. All rights reserved.
//

import Foundation
import UIKit

class FeedsPresenter: FeedsPresenterProtocol {
    
    var view: FeedsViewProtocol?
    var interactor: FeedsInteractorInputProtocol?
    var wireFrame: FeedsWireFrameProtocol?
    
    func viewDidLoad() {
        view?.prepareForAnimation()
        view?.styleFeedsView()
        view?.animateFeedsView()
        self.fetchFeeds()
    }
    
    func fetchFeeds() {
        interactor?.fetchFeeds()
    }
    
    func showNotificationScreen() {
        wireFrame?.pushNotificationScreen(from: view!)
    }
    
    func showAllBloodRequestsScreen() {
        wireFrame?.pushBloodRequestsScreen(from: view!)
    }
    
    func showFeedsDetailScreen(with cardFrame:CGRect, cardCenter:CGPoint, imageFrame:CGRect, titleFrame:CGRect, descFrame:CGRect, bottomViewFrame:CGRect) {
        wireFrame?.presentFeedsDetailViewScreen(from: view!, cardFrame: cardFrame, cardCenter: cardCenter, imageFrame: imageFrame, titleFrame: titleFrame, descFrame: descFrame, bottomViewFrame: bottomViewFrame)
    }
}


extension FeedsPresenter: FeedsInteractorOutputProtocol {
    func didFetchFeeds(With response: FeedsResponse) {
        view?.updateView(With: response)
        view?.hideLoading()
    }
    
    func didFailToFetchFeeds(_ message: String?) {
        view?.hideLoading()
        view?.showError(message)
    }
}
