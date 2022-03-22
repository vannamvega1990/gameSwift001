//
//  eKYCsdk.swift
//  VegaFintecheKYC
//
//  Created by Nguyễn Quang on 4/2/21.
//

import UIKit
import AVFoundation
import AVKit
import Vision

protocol FrontOCR {
    func frontCallBack(image: UIImage)
}

protocol BackOCR {
    func backCallBack(image: UIImage)
}

protocol FaceOCR {
    func faceCallBack(image: [UIImage])
}

protocol ResultOCR {
    func resultCallBack(image: OCRResult)
}

open class VegaFintecheKYC: NSObject, FrontOCR, BackOCR, FaceOCR, ResultOCR {
    var frontImg: UIImage?
    var backImg: UIImage?
    var faceImg: [UIImage]?
    var resultOCR: OCRResult?
    
    func faceCallBack(image: [UIImage]) {
        self.faceImg = image
    }
    
    func resultCallBack(image: OCRResult) {
        self.resultOCR = image
    }
    
    func frontCallBack(image: UIImage) {
        self.frontImg = image
    }
    
    func backCallBack(image: UIImage) {
        self.backImg = image
    }
    
    public static let shared = VegaFintecheKYC()
    
    
    
    func `init`() {
        
    }
    
    public func setLicenseKey(_ accessToken: String, _ appID: String) {
        Constants.KEY.accessToken = accessToken
        Constants.KEY.appID = appID
    }
    
    func loadSDKBundle() -> Bundle {
        let bundle = Bundle.main
        guard let path = bundle.path(forResource: "eKYCResources", ofType: "bundle") else {return bundle}
        guard let bundlePath = Bundle(path: path) else {return bundle}
        if bundlePath.isLoaded == false {
            bundlePath.load()
        }
        return bundlePath
    }
    
    func loadSDKStoryboard(_ bundle: Bundle) -> UIStoryboard {
        //let storyboard = UIStoryboard(name: "eKYCStoryboard", bundle: bundle)
        let storyboard = UIStoryboard(name: "ResultOCR", bundle: bundle)
        
        return storyboard
    }
    
    public func goToScanFrontView(completion: @escaping (_ any: UIImage?) -> Void) {
        var result: UIImage?
        let sdkBundle = self.loadSDKBundle()
        let sdkStoryboard = self.loadSDKStoryboard(sdkBundle)
        let currentVC = self.getCurrentViewController()
        //let scanVC = sdkStoryboard.instantiateViewController(withIdentifier: "ScanViewController") as! ScanViewController
        let scanVC = OCRScanViewController()
        scanVC.isFront = true
        scanVC.frontCallBack = self
        scanVC.onDoneBlock = { result in
            if self.frontImg != nil {
                completion(self.frontImg)
            }
        }
        let nav = UINavigationController()
        scanVC.modalPresentationStyle = .fullScreen
        nav.modalPresentationStyle = .fullScreen
        nav.viewControllers = [scanVC]
        
        currentVC?.present(nav, animated: true, completion: nil)
    }
    
    public func goToScanBackView(completion: @escaping (_ any: UIImage?) -> Void) {
        var result: UIImage?
        let sdkBundle = self.loadSDKBundle()
        let sdkStoryboard = self.loadSDKStoryboard(sdkBundle)
        let currentVC = self.getCurrentViewController()
        //let scanVC = sdkStoryboard.instantiateViewController(withIdentifier: "ScanViewController") as! ScanViewController
        let scanVC = OCRScanViewController()
        scanVC.backCallBack = self
        scanVC.isFront = false
        scanVC.onDoneBlock = { result in
            if self.backImg != nil {
                completion(self.backImg)
            }
        }
        let nav = UINavigationController()
        scanVC.modalPresentationStyle = .fullScreen
        nav.modalPresentationStyle = .fullScreen
        nav.viewControllers = [scanVC]
        currentVC?.present(nav, animated: true, completion: nil)
    }
    
    public func goToScanFaceView(completion: @escaping (_ any: [UIImage]?) -> Void) {
        var result: [UIImage]?
        let sdkBundle = self.loadSDKBundle()
        let sdkStoryboard = self.loadSDKStoryboard(sdkBundle)
        let currentVC = self.getCurrentViewController()
        let scanVC = sdkStoryboard.instantiateViewController(withIdentifier: "FaceMatchViewController") as! FaceMatchViewController
        scanVC.faceCallBack = self
        scanVC.onDoneBlock = { result in
            if self.faceImg != nil {
                completion(self.faceImg)
            }
        }
        let nav = UINavigationController()
        scanVC.modalPresentationStyle = .fullScreen
        nav.modalPresentationStyle = .fullScreen
        nav.viewControllers = [scanVC]
        currentVC?.present(nav, animated: true, completion: nil)
    }
    
    public func goToResultView(_ frontImg: UIImage, _ backImg: UIImage, faceImg: [UIImage], completion: @escaping (_ any: OCRResult?) -> Void)  {
//        var model: OCRResult?
//        let sdkBundle = self.loadSDKBundle()
//        //let sdkStoryboard = self.loadSDKStoryboard(sdkBundle)
//        let currentVC = self.getCurrentViewController()
//        
//        let sdkStoryboard = UIStoryboard(name: "ResultOCR", bundle: nil)
//        
//        let resultVC = sdkStoryboard.instantiateViewController(withIdentifier: "ResultViewController") as! ResultViewController
//        resultVC.faceIdentity = faceImg[0]
//        resultVC.frontImage = frontImg
//        resultVC.backImage = backImg
//        resultVC.resultCallBack = self
//        resultVC.onDoneBlock = { result in
//            if self.resultOCR != nil {
//                completion(self.resultOCR)
//            }
//        }
//        let nav = UINavigationController()
//        resultVC.modalPresentationStyle = .fullScreen
//        nav.modalPresentationStyle = .fullScreen
//        nav.viewControllers = [resultVC]
//        currentVC?.present(nav, animated: true, completion: nil)
    }
    
    func getCurrentViewController() -> UIViewController? {
        return topViewControllerWithRootViewController(UIApplication.shared.keyWindow?.rootViewController)
    }
    
    func topViewControllerWithRootViewController(_ rootViewController : UIViewController?) -> UIViewController? {
        guard let rootVC = rootViewController else {
            return nil
        }
        
        if rootVC is UITabBarController {
            let tabBarVC = rootVC as! UITabBarController
            return topViewControllerWithRootViewController(tabBarVC.selectedViewController)
        } else if rootVC is UINavigationController {
            let navigationController = rootVC as! UINavigationController
            return topViewControllerWithRootViewController(navigationController.visibleViewController)
        } else if let presentedVC = rootVC.presentedViewController {
            return topViewControllerWithRootViewController(presentedVC)
        } else {
            return rootVC
        }
    }
}
