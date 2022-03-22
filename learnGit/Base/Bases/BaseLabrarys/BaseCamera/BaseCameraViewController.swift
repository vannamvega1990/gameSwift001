//
//  BaseCameraViewController.swift
//  VegaFintech
//
//  Created by tran dinh thong on 6/5/21.
//  Copyright © 2021 Vega. All rights reserved.
//

import UIKit

class BaseCameraViewController: BaseViewControllers {
    
    @IBOutlet weak var camview: UIView!
    
    init() {
        super.init(nibName: "BaseCameraViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showCameraInView(camView: camview)
    }
    
    @IBAction func changeCamera(_ sender: UIButton) {
        //onOffFlashLight(on: true)
        switchCamera()
    }
    
    @IBAction func takePhoto(_ sender: UIButton) {
        makePhoto()
//        takePhotoFromCamera { (imgData: UIImage?) in
//            if let imgData = imgData {
//                self.saveImageToPhotos(imgData: imgData)
//            }
//        }
    }
    
    @IBAction func onOffFlash(_ sender: UIButton) {
        
        toggleFlash()
        
        //onOffFlashLight(on: true)
        //DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            //self.onOffFlashLight(on: false)
        //}
//        if let state = getStateOfFlash() {
//            switch state {
//            case .off:
//                onOffFlashLight(on: true)
//                break
//            default:
//                onOffFlashLight(on: false)
//                break
//            }
//        }
        
    }

}


extension BaseViewControllers {
    
    // go to base camra viewcontroller ----------------
    func gotoBaseCameraViewController(){
        let vc = BaseCameraViewController()
        pushToViewController(vc, true)
    }
}
