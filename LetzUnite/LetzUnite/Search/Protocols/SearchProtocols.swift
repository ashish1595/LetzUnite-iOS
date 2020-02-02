//
//  SearchProtocols.swift
//  LetzUnite
//
//  Created by Himanshu on 4/4/18.
//  Copyright © 2018 LetzUnite. All rights reserved.
//

import Foundation
import UIKit

protocol SearchViewProtocol: class {
    var presenter: SearchPresenterProtocol? { get set }
    
    func showError(_ message:String?)
    func showMessage(_ message:String?)
    func showLoading()
    func hideLoading()
    func updateView(With parameters: SearchResponse?)
    func updateLocation(_ latitude:Double, longitude:Double)
}

protocol SearchWireFrameProtocol: class {
    static func createSearchModule() -> UIViewController
    func presentVisitProfileScreen(from view: SearchViewProtocol)
}

protocol SearchPresenterProtocol: class {
    var view: SearchViewProtocol? { get set }
    var interactor: SearchInteractorInputProtocol? { get set }
    var wireFrame: SearchWireFrameProtocol? { get set }
    
    func viewDidLoad()
    func getCurrentLocation()
    func searchRecords(With parameters:SearchRequestModel)
    func showVisitProfileScreen()
}

protocol SearchInteractorOutputProtocol: class {
    func didSearchRecords(With response: SearchResponse)
    func didFailToSearchRecords(_ message:String?)
    
    func didUpdateLocation(coordinates latitude:Double, longitude:Double)
    func didFailToGetLocation(_ message:String?)
}

protocol SearchInteractorInputProtocol: class {
    var presenter: SearchInteractorOutputProtocol? { get set }
    var localDatamanager: SearchLocalDataManagerInputProtocol? { get set }
    var remoteDatamanager: SearchRemoteDataManagerInputProtocol? { get set }
    
    func searchRecords(With parameters:SearchRequestModel)
    func getCurrentLocation()
}

protocol SearchRemoteDataManagerInputProtocol: class {
    var remoteRequestHandler: SearchRemoteDataManagerOutputProtocol? { get set }
    var validationManager: SearchValidationInputProtocol? { get set }
    
    func searchRecordsRequest(With parameters:SearchRequestModel, profileInfo:UserProfileSingleton?)
    func callSearchRecordApi(With validatedParameters:Dictionary<String,Any>, endpoint:Endpoint)
}

protocol SearchRemoteDataManagerOutputProtocol: class {
    func onSearchRecords(_ response: SearchResponse)
    func onError(with message:String?, errorCode:Int? ,endpoint:Endpoint)
}

protocol SearchLocalDataManagerInputProtocol: class {
    var userProfileManager: UserProfileSingleton? { get set }
    var localRequestHandler: SearchLocalDataManagerOutputProtocol? { get set }
    func retrieveUserProfile() -> UserProfileSingleton?
}

protocol SearchLocalDataManagerOutputProtocol: class {

}

protocol SearchValidationInputProtocol: class{
    var searchValidationHandler: SearchValidationOutputProtocol? {get set}
    func validateParameters(_ parameters:SearchRequestModel, endpoint:Endpoint, profileInfo:UserProfileSingleton?)
}

protocol SearchValidationOutputProtocol: class{
    func didValidate(_ parameters:Dictionary<String,Any>, endpoint:Endpoint)
    func didValidateWithError(_ errorMessage:String, endpoint:Endpoint)
}
