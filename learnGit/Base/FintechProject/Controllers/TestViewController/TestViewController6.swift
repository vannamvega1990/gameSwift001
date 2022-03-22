//
//  TestViewController6.swift
//  VegaFintech
//
//  Created by tran dinh thong on 9/29/21.
//  Copyright © 2021 Vega. All rights reserved.
//

import UIKit
import AVFoundation
import MapKit
import CoreLocation

class TestViewController6: BaseViewControllerMapkit {

    var locManager = CLLocationManager()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let s1 = "NỘI DUNG"
        print(s1.lowercased().capitalizingFirstLetter())
        let test = "the rain in Spain"
        print(test.capitalizingFirstLetter())
        let test1 = "the rain in Spain. noi dung"
        print(test1.capitalizedFirstLetter)
        
//        if AVCaptureDevice.authorizationStatus(for: AVMediaType.video) ==  AVAuthorizationStatus.authorized {
//            // Already Authorized
//            print("Already Authorized")
//        } else {
//            AVCaptureDevice.requestAccess(for: AVMediaType.video, completionHandler: { (granted: Bool) -> Void in
//                if granted == true {
//                    // User granted
//                    print("User granted")
//                } else {
//                    // User rejected
//                    print("User rejected")
//                    DispatchQueue.main.asyncAfter(deadline: .now()) {
//                        Commons.showDialogConfirm(title: "Thông báo", content: "cần truy cập camera", titleButton: "Đồng ý") {
//                            if let url = URL(string:UIApplication.openSettingsURLString) {
//                                DispatchQueue.main.asyncAfter(deadline: .now()) {
//                                    UIApplication.shared.openURL(url)
//                                }
//                            }
//                        }
//                    }
//                }
//            })
//        }
        
//        if CLLocationManager.locationServicesEnabled() {
//             switch CLLocationManager.authorizationStatus() {
//                case .notDetermined, .restricted, .denied:
//                    print("No access")
//                case .authorizedAlways, .authorizedWhenInUse:
//                    print("Access")
//                }
//            } else {
//                print("Location services are not enabled")
//        }
        
        //self.showPermissionLocation()
        
//        locManager.requestWhenInUseAuthorization()
//        if CLLocationManager.locationServicesEnabled() {
//            switch CLLocationManager.authorizationStatus() {
//            case .notDetermined:
//                //locManager.requestWhenInUseAuthorization()
//                break
//            case .restricted, .denied:
//                print("No access")
//                Commons.showDialogConfirm(title: "Thông báo", content: "cần truy cập vị trí", titleButton: "Đồng ý") {
//                    if let url = URL(string:UIApplication.openSettingsURLString) {
//                        self.showSettingsForApp()
//                    }
//                }
//                break
//            case .authorizedAlways, .authorizedWhenInUse:
//                print("Access")
//                guard let currentLocation = locManager.location else {
//                    return
//                }
//                print(currentLocation.coordinate.latitude)
//                print(currentLocation.coordinate.longitude)
//                break
//            }
//        } else {
//            print("Location services are not enabled")
//        }
        
        
//        getCamPermission { (completed) in
//            print(completed)
//        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }



}
