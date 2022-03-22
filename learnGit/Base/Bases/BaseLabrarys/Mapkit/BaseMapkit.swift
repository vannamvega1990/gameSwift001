//
//  BaseMapkit.swift
//  VegaFintech
//
//  Created by tran dinh thong on 8/10/21.
//  Copyright © 2021 Vega. All rights reserved.
//

import Foundation
import MapKit
import CoreLocation

class BaseViewControllerMapkit: TPBaseViewController, CLLocationManagerDelegate{
    var locManager1: CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locManager1 = CLLocationManager()
        locManager1.delegate = self
        locManager1.desiredAccuracy = kCLLocationAccuracyBest
        locManager1.requestAlwaysAuthorization()
        locManager1.requestWhenInUseAuthorization()
        locManager1.startUpdatingLocation()
        showPermissionLocation()
    }
    
    func showPermissionLocation(){
//        locManager1.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            switch CLLocationManager.authorizationStatus() {
            case .notDetermined:
                //locManager1.requestWhenInUseAuthorization()
                //locManager1.requestAlwaysAuthorization()
                break
            case .restricted, .denied:
                print("No access")
                Commons.showDialogConfirm(title: "Thông báo", content: "cần truy cập vị trí", titleButton: "Đồng ý") {
                    if let url = URL(string:UIApplication.openSettingsURLString) {
                        self.showSettingsForApp()
                    }
                }
                break
                
            case .authorizedAlways, .authorizedWhenInUse:
                print("Access")
                //locManager1.startUpdatingLocation()
//                guard let currentLocation = locManager1.location else {
//                    return
//                }
//                print(currentLocation.coordinate.latitude)
//                print(currentLocation.coordinate.longitude)
                break
            }
        } else {
            print("Location services are not enabled")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation :CLLocation = locations[0] as CLLocation
        
        print("user latitude = \(userLocation.coordinate.latitude)")
        print("user longitude = \(userLocation.coordinate.longitude)")
        
        
    }
}
