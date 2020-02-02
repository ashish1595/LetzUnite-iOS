//
//  GooglePlacesAPIManager.swift
//  LetzUnite
//
//  Created by B0081006 on 8/4/18.
//  Copyright © 2018 Airtel. All rights reserved.
//

import Foundation
import UIKit

private struct AllKeys {
    static let language = "language"
    static let predictions = "predictions"
    static let placeid = "placeid"
    static let key = "key"
    static let radius = "radius"
}

class GooglePlacesAPIManager {
    static func networkRequest(_ urlString: String, params: [String: String], completion: @escaping (NSDictionary) -> Void) {
        var components = URLComponents(string: urlString)
        components?.queryItems = params.map { URLQueryItem(name: $0, value: $1) }
        
        guard let url = components?.url else { return }
        
        let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            if let error = error {
                print("GooglePlacesAPIManager Error: \(error.localizedDescription)")
                return
            }
            
            guard let data = data, let response = response as? HTTPURLResponse else {
                print("GooglePlacesAPIManager Error: No response from API")
                return
            }
            
            guard response.statusCode == 200 else {
                print("GooglePlacesAPIManager Error: Invalid status code \(response.statusCode) from API")
                return
            }
            
            let object: NSDictionary?
            do {
                object = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? NSDictionary
            } catch {
                object = nil
                print("GooglePlacesAPIManager Error")
                return
            }
            
            guard object?["status"] as? String == "OK" else {
                print("GooglePlacesAPIManager API Error: \(object?["status"] ?? "")")
                return
            }
            
            guard let json = object else {
                print("GooglePlacesAPIManager Parse Error")
                return
            }
            
            // Perform table updates on UI thread
            DispatchQueue.main.async {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                completion(json)
            }
        })
        
        task.resume()
    }
    
    static func getPlaces(with parameters: [String: String], completion: @escaping ([Place]) -> Void) {
        var parameters = parameters
        if let deviceLanguage = deviceLanguage {
            parameters[AllKeys.language] = deviceLanguage
        }
        networkRequest(
            googleAPIs.placeAutocomplete.rawValue,
            params: parameters,
            completion: {
                guard let predictions = $0[AllKeys.predictions] as? [[String: Any]] else { return }
                completion(predictions.map { Place(dict: $0) })
        }
        )
    }
    
    static func getPlaceDetails(id: String, apiKey: String, completion: @escaping (PlaceDetails?) -> Void) {
        var parameters = [ AllKeys.placeid: id, AllKeys.key: apiKey ]
        if let deviceLanguage = deviceLanguage {
            parameters[AllKeys.language] = deviceLanguage
        }
        networkRequest(
            googleAPIs.placeDetails.rawValue,
            params: parameters,
            completion: { completion(PlaceDetails(json: $0 as? [String: Any] ?? [:])) }
        )
    }
    
    private static var deviceLanguage: String? {
        return (Locale.current as NSLocale).object(forKey: NSLocale.Key.languageCode) as? String
    }
}
