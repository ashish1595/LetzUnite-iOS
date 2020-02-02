//
//  NotificationProtocols.swift
//  LetzUnite
//
//  Created by B0081006 on 6/30/18.
//  Copyright © 2018 Airtel. All rights reserved.
//

import Foundation
import UIKit

protocol NotificationViewProtocol: class {
    var presenter: NotificationPresenterProtocol? { get set }
    
    func prepareForAnimation()
    func styleNotificationView()
    func animateNotificationView()
    func showLoading()
    func hideLoading()
    func showError(_ message:String?)
    func updateView(With parameters: RewardResponse?)
}

protocol NotificationWireFrameProtocol: class {
    static func createNotificationModule() -> UIViewController
    func popView(_ view:NotificationViewProtocol)
}

protocol NotificationPresenterProtocol: class {
    var view: NotificationViewProtocol? { get set }
    var interactor: NotificationInteractorInputProtocol? { get set }
    var wireFrame: NotificationWireFrameProtocol? { get set }
    
    func viewDidLoad()
    func fetchNotification()
    func popView(_ view:NotificationViewProtocol)
}

protocol NotificationInteractorOutputProtocol: class {
    func didFetchNotification(With response: RewardResponse?)
    func didFailToFetchNotification(_ message:String?)
}

protocol NotificationInteractorInputProtocol: class {
    var presenter: NotificationInteractorOutputProtocol? { get set }
    var localDatamanager: NotificationLocalDataManagerInputProtocol? { get set }
    var remoteDatamanager: NotificationRemoteDataManagerInputProtocol? { get set }
    
    func fetchNotification()
}

protocol NotificationRemoteDataManagerInputProtocol: class {
    var remoteRequestHandler: NotificationRemoteDataManagerOutputProtocol? { get set }
    var validationManager: NotificationValidationInputProtocol? { get set }
    
    func fetchNotification(With parameters:UserProfileSingleton)
    func callFetchNotificationApi(With validatedParams:Dictionary<String,Any>, endpoint:Endpoint)
}

protocol NotificationRemoteDataManagerOutputProtocol: class {
    func onFetchNotification(_ response: RewardResponse?)
    func onError(with message:String?, errorCode:Int? ,endpoint:Endpoint)
}

protocol NotificationLocalDataManagerInputProtocol: class {
    var userProfileManager: UserProfileSingleton? { get set }
    var localRequestHandler: NotificationLocalDataManagerOutputProtocol? { get set }
    func retrieveUserProfile() -> UserProfileSingleton?
}

protocol NotificationLocalDataManagerOutputProtocol: class {
    
}

protocol NotificationValidationInputProtocol: class{
    var NotificationValidationHandler: NotificationValidationOutputProtocol? {get set}
    func validateParameters(_ parameters:UserProfileSingleton, endpoint:Endpoint)
}

protocol NotificationValidationOutputProtocol: class{
    func didValidate(_ parameters:Dictionary<String,Any>, endpoint:Endpoint)
    func didValidateWithError(_ errorMessage:String, endpoint:Endpoint)
}
