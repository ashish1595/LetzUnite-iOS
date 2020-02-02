//
//  NotificationPresenter.swift
//  LetzUnite
//
//  Created by B0081006 on 6/30/18.
//  Copyright © 2018 Airtel. All rights reserved.
//

import Foundation

class NotificationPresenter: NotificationPresenterProtocol {
    var view: NotificationViewProtocol?
    var interactor: NotificationInteractorInputProtocol?
    var wireFrame: NotificationWireFrameProtocol?
    
    func viewDidLoad() {
        view?.prepareForAnimation()
        view?.styleNotificationView()
        view?.animateNotificationView()
        
        self.fetchNotification()
    }
    
    func fetchNotification() {
        interactor?.fetchNotification()
    }
    
    func popView(_ view: NotificationViewProtocol) {
        wireFrame?.popView(view)
    }
}


extension NotificationPresenter: NotificationInteractorOutputProtocol {
    func didFetchNotification(With response: RewardResponse?) {
        view?.updateView(With: response)
        view?.hideLoading()
    }
    
    func didFailToFetchNotification(_ message: String?) {
        view?.hideLoading()
        view?.showError(message)
    }
}
