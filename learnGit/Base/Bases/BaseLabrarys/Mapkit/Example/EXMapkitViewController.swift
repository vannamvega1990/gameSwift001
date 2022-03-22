//
//  EXMapkitViewController.swift
//  VegaFintech
//
//  Created by tran dinh thong on 8/10/21.
//  Copyright © 2021 Vega. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class EXMapkitViewController: BaseViewControllers {

    var locationManager:CLLocationManager!
    var map: MKMapView!
    var matchingItems: [MKMapItem] = []
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let btn = UIButton()
        btn.backgroundColor = .red
        btn.setTitle("btn test", for: .normal)
        btn.frame = CGRect(x: 189, y: 196, width: 98, height: 46)
        view.addSubview(btn)
        btn.addTarget(self, action: #selector(xuly), for: .touchUpInside)
    }
    @objc func xuly(){
        updateSearchResults(for: "nam định")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBackgroundColor()
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        
        map = MKMapView(frame: view.bounds)
        addSubViews([map])
        
        if CLLocationManager.locationServicesEnabled(){
            locationManager.startUpdatingLocation()
        }
        
    }
    
    
}

extension EXMapkitViewController : CLLocationManagerDelegate{
    
    
    
    //MARK: - location delegate methods
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation :CLLocation = locations[0] as CLLocation
        
        print("user latitude = \(userLocation.coordinate.latitude)")
        print("user longitude = \(userLocation.coordinate.longitude)")
        
        
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(userLocation) { (placemarks, error) in
            if (error != nil){
                print("error in reverseGeocode")
            }
            guard let placemark = placemarks as? [CLPlacemark] else {
                return
            }
            if placemark.count>0{
                let placemark = placemarks![0]
                print(placemark.locality!)
                print(placemark.administrativeArea!)
                print(placemark.country!)
                
                //self.labelAdd.text = "\(placemark.locality!), \(placemark.administrativeArea!), \(placemark.country!)"
            }
        }
        
        let location = locations.last! as CLLocation
        
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.001, longitudeDelta: 0.001))
        
        self.map.setRegion(region, animated: true)
        
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error \(error)")
    }
}


extension EXMapkitViewController  {
    func updateSearchResults(for searchController: String) {
        guard let mapView = map else { return }
        
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchController
        request.region = mapView.region
        let search = MKLocalSearch(request: request)
        
        search.start { response, _ in
            guard let response = response else {
                return
            }
            print(response.mapItems)
            self.matchingItems = response.mapItems
            for each in self.matchingItems {
                let selectedItem = each.placemark
                let locality = selectedItem.locality
                let locality1 = selectedItem.region
                print("-----------\(selectedItem)")
                print("-----------\(locality)")
                print(locality)
                
            }
            //self.tableView.reloadData()
        }
    }
}
