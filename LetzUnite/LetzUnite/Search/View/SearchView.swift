//
//  SearchView.swift
//  LetzUnite
//
//  Created by Himanshu on 4/4/18.
//  Copyright © 2018 LetzUnite. All rights reserved.
//

import UIKit
import MapKit
import IQActionSheetPickerView

class SearchView: UIViewController {

    var presenter: SearchPresenterProtocol?
    
    @IBOutlet var scrollVw_search: UIScrollView!
    @IBOutlet var mapVw_search: MKMapView!
    @IBOutlet var label_searchTitle: UILabel!
    @IBOutlet var button_selectSearchOption: UIButton!
    @IBOutlet var imgVw_searchDropdown: UIImageView!
    @IBOutlet var button_selectBloodGroup: UIButton!
    @IBOutlet var imgVw_dropdown: UIImageView!
    @IBOutlet var label_distanceFilter: UILabel!
    @IBOutlet var slider_distanceFilter: UISlider!
    
    var navView:NavigationBarView?
    private let kMapAnnotationReusableId = "annotationId"
    var searchOptionsList: [String] = ["All","Donors","Requesters","Blood Banks"];
    var bloodGroupsList: [String] = ["All","O-","O+","A-","A+","B-","B+","AB-","AB+"]
    var search = SearchRequestModel.init()

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        
        DispatchQueue.main.async {
            self.setupNavigationBar()
            self.mapVw_search.layoutIfNeeded()
        }
        
        self.slider_distanceFilter.addTarget(self, action: #selector(actionDistanceSliderOnValueChanged(slider:event:)), for: .valueChanged)
        
        search.searchUserType = String(SearchUserTypes.all.rawValue)
        search.range = String(60)
        search.bloodGroup = String(BloodGroupTypes.all.rawValue)
        presenter?.getCurrentLocation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func actionGetCurrentLocation(_ sender: Any) {
        presenter?.getCurrentLocation()
    }
    
    func actionSearch() {
        presenter?.searchRecords(With: search)
    }
    
    @IBAction func actionSelectSearchOption(_ sender: Any) {
        let picker = IQActionSheetPickerView.init(title: "Search By", delegate: self)
        picker.titlesForComponents = [searchOptionsList]
        picker.actionSheetPickerStyle = .textPicker
        picker.tag = 1
        picker.show()
    }
    
    @IBAction func actionSelectBloodGroup(_ sender: Any) {
        let picker = IQActionSheetPickerView.init(title: "Blood Group", delegate: self)
        picker.titlesForComponents = [bloodGroupsList]
        picker.actionSheetPickerStyle = .textPicker
        picker.tag = 2
        picker.show()
    }
    
    @objc func actionDistanceSliderOnValueChanged(slider: UISlider, event: UIEvent) {
            if let touchEvent = event.allTouches?.first {
                switch touchEvent.phase {
                case .began:
                    self.label_distanceFilter.text = "Range: \(Int(slider.value)) Km"
                case .moved:
                    self.label_distanceFilter.text = "Range: \(Int(slider.value)) Km"
                case .ended:
                    self.label_distanceFilter.text = "Range: \(Int(slider.value)) Km"
                    self.search.range = String(Int(slider.value))
                    presenter?.getCurrentLocation()
                default:
                    break
                }
            }
    }
    
    func setupNavigationBar() {
        navView = NavigationBarView.init(navType: .kSearchNav, frame: CGRect(x: 0, y: UIApplication.shared.statusBarFrame.height, width: self.view.bounds.size.width, height: 56))
        navView?.delegate = self
        navView?.label_searchTitle.alpha = 0
        navView?.layoutIfNeeded()
        self.view.addSubview(navView!)
    }
}


extension SearchView: SearchViewProtocol {
    func showError(_ message: String?) {
        
    }
    
    func showMessage(_ message: String?) {
        
    }
    
    func showLoading() {
        
    }
    
    func hideLoading() {
        
    }
    
    func updateView(With parameters: SearchResponse?) {
        if parameters?.searchedRecords?.count != 0 {
            self.mapVw_search.removeAnnotations(self.mapVw_search.annotations)
        
            for item in (parameters?.searchedRecords)! {
                print("\(item.annotationType), \(String(describing: item.title)), \(item.locationName), \(item.coordinate), \(String(describing: item.userId)), \(String(describing: item.imageUrl)), \(String(describing: item.imageName)), ")
            }
            
            self.mapVw_search.addAnnotations((parameters?.searchedRecords)!)
        }
    }
    
    func updateLocation(_ latitude: Double, longitude: Double) {
        search.location = "\(latitude),\(longitude)"
        presenter?.searchRecords(With: search)
    }
}

extension SearchView: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.5, animations: {
                self.scrollVw_search.contentOffset = CGPoint(x: 0, y: self.label_searchTitle.frame.origin.y - 20)
            })
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.returnKeyType == .search {
            //Hit api here
            self.actionSearch()
        }
        textField.resignFirstResponder()
        UIView.animate(withDuration: 0.5, animations: {
            self.scrollVw_search.contentOffset = CGPoint(x: 0, y: 0)
        })
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let newLength = (textField.text?.utf16.count)! + string.utf16.count - range.length
        
        if newLength == 0 {
            textField.returnKeyType = .default
        }else {
            textField.returnKeyType = .search
        }
        textField.reloadInputViews()
        
        return true
    }
    
}


extension SearchView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if(scrollView.contentOffset.y > 46) {
            UIView.animate(withDuration: 0.5, animations: {
                self.navView?.label_searchTitle.alpha = 1.0
                self.label_searchTitle.alpha = 0.0
            })
        }else {
            UIView.animate(withDuration: 0.5, animations: {
                self.navView?.label_searchTitle.alpha = 0.0
                self.label_searchTitle.alpha = 1.0
            })
        }
    }
}

extension SearchView: NavigationBarProtocol {
    func didPressNotificationBellButton() {
        
    }
}

extension SearchView: MKMapViewDelegate {
    
    // MARK: - MKMapViewDelegate methods
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        let visibleRegion = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 10000, 10000)
        self.mapVw_search.setRegion(self.mapVw_search.regionThatFits(visibleRegion), animated: true)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation { return nil }
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: kMapAnnotationReusableId)
        
        if annotationView == nil {
            annotationView = AnnotationView(annotation: annotation, reuseIdentifier: kMapAnnotationReusableId, imageName: (annotation as! AnnotationInfo).imageName)
            (annotationView as! AnnotationView).customCalloutViewDelegate = self
        } else {
            annotationView!.annotation = annotation
        }
        return annotationView
    }
    
}

extension SearchView: MapCalloutViewDelegate {
    func detailsRequestedForCallout(callout: Any) {
        //Open Map app with start and end points and Navigate
        presenter?.showVisitProfileScreen()
    }
}

extension SearchView: IQActionSheetPickerViewDelegate {
    func actionSheetPickerView(_ pickerView: IQActionSheetPickerView, didSelectTitlesAtIndexes indexes: [NSNumber]) {
        switch pickerView.tag {
        case 1:
            let index:Int = Int(truncating: indexes[0])
            self.button_selectSearchOption.setTitle(searchOptionsList[index], for: .normal)
            self.search.searchUserType = String(SearchUserTypes(rawValue: index)!.rawValue)
            if(index == 0 || index == 3) {
                //hide
                self.button_selectBloodGroup.isHidden = true
                self.imgVw_dropdown.isHidden = true
            }else {
                //show
                self.button_selectBloodGroup.isHidden = false
                self.imgVw_dropdown.isHidden = false
            }
        case 2:
            let index:Int = Int(truncating: indexes[0])
            print(index)
            self.button_selectBloodGroup.setTitle(bloodGroupsList[index], for: .normal)
            self.search.bloodGroup = bloodGroupsList[index] //String(BloodGroupTypes(rawValue: bloodGroupsList[index])!.rawValue)
        default:
            print("")
        }
        
        presenter?.getCurrentLocation()
    }
    
}
