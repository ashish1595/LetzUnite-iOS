//
//  PlacesAutocompleteTableViewController.swift
//  LetzUnite
//
//  Created by B0081006 on 8/4/18.
//  Copyright © 2018 Airtel. All rights reserved.
//

import UIKit
import MapKit

private struct AllKeys {
    static let input = "input"
    static let types = "types"
    static let key = "key"
    static let location = "location"
    static let radius = "radius"
}

public protocol PlacesAutocompleteTableViewControllerDelegate: class {
    func placesAutocompleteController(didAutocompleteWith place: PlaceDetails)
}

class PlacesAutocompleteTableViewController: UITableViewController {

    private weak var delegate: PlacesAutocompleteTableViewControllerDelegate?
    private var apiKey: String = ""
    private var placeType: PlaceType = .all
    private var coordinate: CLLocationCoordinate2D = kCLLocationCoordinate2DInvalid
    private var radius: Double = 0.0

    private var places = [Place]() {
        didSet { tableView.reloadData() }
    }
    
    convenience init(delegate: PlacesAutocompleteTableViewControllerDelegate, apiKey: String, placeType: PlaceType = .all, coordinate: CLLocationCoordinate2D, radius: Double) {
        self.init()
        self.delegate = delegate
        self.apiKey = apiKey
        self.placeType = placeType
        self.coordinate = coordinate
        self.radius = radius
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
}

extension PlacesAutocompleteTableViewController {
    
    override open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places.count
    }
    
    override open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
            ?? UITableViewCell(style: .subtitle, reuseIdentifier: cellIdentifier)
        
        let place = places[indexPath.row]
        
        cell.textLabel?.text = place.address1
        cell.detailTextLabel?.text = place.address2
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
    override open func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let place = places[indexPath.row]
        GooglePlacesAPIManager.getPlaceDetails(id: place.id, apiKey: apiKey) { [unowned self] in
                guard let value = $0 else { return }
            self.delegate?.placesAutocompleteController(didAutocompleteWith: value)
        }
    }
}

extension PlacesAutocompleteTableViewController: UISearchBarDelegate, UISearchResultsUpdating {
    
    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else { places = []; return }
        let parameters = getParameters(for: searchText)
        GooglePlacesAPIManager.getPlaces(with: parameters) {
            self.places = $0
        }
    }
    
    public func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text, !searchText.isEmpty else { places = []; return }
        let parameters = getParameters(for: searchText)
        GooglePlacesAPIManager.getPlaces(with: parameters) {
            self.places = $0
        }
    }
    
    private func getParameters(for text: String) -> [String: String] {
        var params = [
            AllKeys.input: text,
            AllKeys.types: placeType.rawValue,
            AllKeys.key: apiKey
        ]
        
        if CLLocationCoordinate2DIsValid(coordinate) {
            params[AllKeys.location] = "\(coordinate.latitude),\(coordinate.longitude)"
            if radius > 0 {
                params[AllKeys.radius] = "\(radius)"
            }
        }
        
        return params
    }
}
