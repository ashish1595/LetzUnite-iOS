//
//  HistoryPresenter.swift
//  LetzUnite
//
//  Created by B0081006 on 6/24/18.
//  Copyright © 2018 Airtel. All rights reserved.
//

import Foundation

class HistoryPresenter: HistoryPresenterProtocol {
    var view: HistoryViewProtocol?
    var interactor: HistoryInteractorInputProtocol?
    var wireFrame: HistoryWireFrameProtocol?
    
    func viewDidLoad() {
        view?.styleHistoryView()
    }
}


extension HistoryPresenter: HistoryInteractorOutputProtocol {
    
}
