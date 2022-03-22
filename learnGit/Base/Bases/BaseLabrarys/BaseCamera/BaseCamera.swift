//
//  BaseCamera.swift
//  VegaFintech
//
//  Created by tran dinh thong on 6/5/21.
//  Copyright © 2021 Vega. All rights reserved.
//

import UIKit
import AVFoundation

class BaseCamera {
    
    static let shared = BaseCamera()
    
    var captureSession:AVCaptureSession?
    var videoPreviewLayer:AVCaptureVideoPreviewLayer?
    var videoCaptureDevice: AVCaptureDevice?
    var input: AnyObject?
    
    var stillImageOutput: AVCapturePhotoOutput!
    
    // show camera ------------------------
    func showcamera(camView:UIView){
        videoCaptureDevice = AVCaptureDevice.default(for: AVMediaType.video)
        do {
            input = try AVCaptureDeviceInput(device: videoCaptureDevice!)
        } catch {
            print("video device error")
        }
        captureSession = AVCaptureSession()
        captureSession?.addInput(input as! AVCaptureInput)
        
        
        
        
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession!)
        videoPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        videoPreviewLayer?.frame = camView.layer.bounds
        
        videoPreviewLayer?.connection?.videoOrientation = .portrait
        
        camView.layer.addSublayer(videoPreviewLayer!)
        captureSession?.startRunning()
        
        addCapturePhoto()
    }
    
    // change position camera ----------------
    func switchCameraTapped() {
        //Change camera source
        if let session = captureSession {
            //Indicate that some changes will be made to the session
            session.beginConfiguration()

            //Remove existing input
            guard let currentCameraInput: AVCaptureInput = session.inputs.first else {
                return
            }

            session.removeInput(currentCameraInput)

            //Get new input
            var newCamera: AVCaptureDevice! = nil
            if let input = currentCameraInput as? AVCaptureDeviceInput {
                if (input.device.position == .back) {
                    newCamera = cameraWithPosition(position: .front)
                } else {
                    newCamera = cameraWithPosition(position: .back)
                }
            }

            //Add input to session
            var err: NSError?
            var newVideoInput: AVCaptureDeviceInput!
            do {
                newVideoInput = try AVCaptureDeviceInput(device: newCamera)
            } catch let err1 as NSError {
                err = err1
                newVideoInput = nil
            }

            if newVideoInput == nil || err != nil {
                print("Error creating capture device input: \(err?.localizedDescription)")
            } else {
                session.addInput(newVideoInput)
            }
            //Commit all the configuration changes at once
            session.commitConfiguration()
        }
    }

    // Find a camera with the specified AVCaptureDevicePosition, returning nil if one is not found
    func cameraWithPosition(position: AVCaptureDevice.Position) -> AVCaptureDevice? {
        
        let discoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: AVMediaType.video, position: .unspecified)
        for device in discoverySession.devices {
            if device.position == position {
                return device
            }
        }
        return nil
    }
    
    // stop camera -------------
    func stopCamera(){
        self.captureSession?.stopRunning()
    }
    
    func addCapturePhoto(){
        stillImageOutput = AVCapturePhotoOutput()
        if let captureSession = captureSession,  captureSession.canAddOutput(stillImageOutput) {
            captureSession.addOutput(stillImageOutput)
        }
    }
    
    func makePhoto(vc:BaseViewControllers){
        
        
        
        var settings = AVCapturePhotoSettings()
        //settings.format = [AVVideoCodecKey: AVVideoCodecType.jpeg]
        if #available(iOS 11.0, *) {
            settings = AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecType.jpeg])
        } else {
            // Fallback on earlier versions
        }
        
        
//        let settings = AVCapturePhotoSettings()
//        let previewPixelType = settings.availablePreviewPhotoPixelFormatTypes.first!
//        let previewFormat = [kCVPixelBufferPixelFormatTypeKey as String: previewPixelType,
//                                     kCVPixelBufferWidthKey as String: 160,
//                                     kCVPixelBufferHeightKey as String: 160,
//                                     ]
//        settings.previewPhotoFormat = previewFormat
        
        stillImageOutput.capturePhoto(with: settings, delegate: vc)
        
        
        
        
        
//        let dataOutput = AVCaptureVideoDataOutput()
//        dataOutput.videoSettings = [(kCVPixelBufferPixelFormatTypeKey as String):NSNumber(value: kCVPixelFormatType_32BGRA)]
//        dataOutput.alwaysDiscardsLateVideoFrames = true
//
//
//
//
//
//        let stillImageOutput = AVCapturePhotoOutput()
//        let settings = AVCapturePhotoSettings()
//        let previewPixelType = settings.availablePreviewPhotoPixelFormatTypes.first!
//        let previewFormat = [kCVPixelBufferPixelFormatTypeKey as String: previewPixelType,
//                                     kCVPixelBufferWidthKey as String: 160,
//                                     kCVPixelBufferHeightKey as String: 160,
//                                     ]
//        settings.previewPhotoFormat = previewFormat
//        let capturePhotoSettings = AVCapturePhotoSettings()
//        if let videoConnection = stillImageOutput.connection(with: AVMediaType.video) {
//            //stillImageOutput.capturePhoto(with: settings, delegate: currentVC)
//        }
    }
    
    // take photo --------------------
    func takePhotoFromCamera(vc:UIViewController , completed: @escaping ((UIImage?)->Void)) {
        let stillImageOutput = AVCaptureStillImageOutput()
        if let videoConnection = stillImageOutput.connection(with: AVMediaType.video) {
            stillImageOutput.captureStillImageAsynchronously(from: videoConnection) {
                (imageDataSampleBuffer, error) -> Void in
                if let imageDataSampleBuffer = imageDataSampleBuffer {
                    let imageData = AVCaptureStillImageOutput.jpegStillImageNSDataRepresentation(imageDataSampleBuffer)
                    
                    UIImageWriteToSavedPhotosAlbum(UIImage(data: imageData!)!, vc, nil, nil)
                    
                    
                    if let imageData = imageData, let img = UIImage(data: imageData) {
                        completed(img)
                    }else{
                        completed(nil)
                    }
                    //UIImageWriteToSavedPhotosAlbum(UIImage(data: imageData!)!, nil, nil, nil)
                }
                
            }
        }
        //return nil
    }
    // setting camera -----------------
    func settings(){
        let settings = AVCapturePhotoSettings()
        let previewPixelType = settings.availablePreviewPhotoPixelFormatTypes.first!
        let previewFormat = [kCVPixelBufferPixelFormatTypeKey as String: previewPixelType,
                                     kCVPixelBufferWidthKey as String: 160,
                                     kCVPixelBufferHeightKey as String: 160,
                                     ]
        settings.previewPhotoFormat = previewFormat
        //self.cameraOutput.capturePhoto(with: settings, delegate: self)
    }
    
    func getStateOfFlash() -> AVCaptureDevice.TorchMode?{
        guard let device = AVCaptureDevice.default(for: .video) else { return nil }
        if device.hasTorch {
            return device.torchMode
        }
        return nil
    }
    // on off flash light ----------------
    func toggleTorch(on: Bool) {
        guard let device = AVCaptureDevice.default(for: .video) else { return }
        
        if device.hasTorch {
            do {
                try device.lockForConfiguration()
                
                if on == true {
                    device.torchMode = .on
                } else {
                    device.torchMode = .off
                }
                
                device.unlockForConfiguration()
            } catch {
                print("Torch could not be used")
            }
        } else {
            print("Torch is not available")
        }
    }
    // toogle flash ----------------------------
    func toggleFlash() {
        guard let device = AVCaptureDevice.default(for: AVMediaType.video) else { return }
        guard device.hasTorch else { return }

        do {
            try device.lockForConfiguration()

            if (device.torchMode == AVCaptureDevice.TorchMode.on) {
                device.torchMode = AVCaptureDevice.TorchMode.off
            } else {
                do {
                    try device.setTorchModeOn(level: 1.0)
                } catch {
                    print(error)
                }
            }

            device.unlockForConfiguration()
        } catch {
            print(error)
        }
    }
    // make video ----------------------
    func recordVideo(completion: @escaping (URL?, Error?) -> Void) {
        var captureDeviceVideoFound: Bool = false
        var captureDeviceAudioFound:Bool = false
        
        let discoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: AVMediaType.video, position: .unspecified)
        let devices = discoverySession.devices
        var captureDevice:AVCaptureDevice?
        var captureAudio:AVCaptureDevice?

        // Loop through all the capture devices on this phone
        for device in devices {
        // Make sure this particular device supports video
            if (device.hasMediaType(AVMediaType.video)) {
        // Finally check the position and confirm we've got the front camera
                if(device.position == AVCaptureDevice.Position.front) {

                    captureDevice = device as? AVCaptureDevice //initialize video
                    if captureDevice != nil {
                        print("Capture device found")
                        captureDeviceVideoFound = true;
                    }
                }
            }
            if(device.hasMediaType(AVMediaType.audio)){
                print("Capture device audio init")
                let captureAudio = device as? AVCaptureDevice //initialize audio
                captureDeviceAudioFound = true
            }
        }
        if(captureDeviceAudioFound && captureDeviceVideoFound){
            //beginSession()
            
            try? captureSession?.addInput(AVCaptureDeviceInput(device: captureDevice!))
            try? captureSession?.addInput(AVCaptureDeviceInput(device: captureAudio!))
        }
    }
    
    
    
    
}


extension BaseViewControllers: AVCapturePhotoCaptureDelegate {
    
//    @available(iOS 11.0, *)
//    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
//        print("before if let")
//
//        if let imageData = photo.fileDataRepresentation(){
//            let tempImage = UIImage(data: imageData)
//            print(tempImage!)
//            saveImageToPhotos(imgData: tempImage!)
//        }
//    }
    
//    private func photoOutput(_ captureOutput: AVCapturePhotoOutput, didFinishProcessingPhoto photoSampleBuffer: CMSampleBuffer?, previewPhoto previewPhotoSampleBuffer: CMSampleBuffer?, resolvedSettings: AVCaptureResolvedPhotoSettings, bracketSettings: AVCaptureBracketedStillImageSettings?, error: Error?) {
//
//        var photoData: Data?
//        var photoThumbnail: UIImage?
//        if let photoBuffer = photoSampleBuffer {
//            photoData = AVCapturePhotoOutput.jpegPhotoDataRepresentation(forJPEGSampleBuffer: photoBuffer, previewPhotoSampleBuffer: nil)
//        }
//
//        let previewWidth = Int(resolvedSettings.previewDimensions.width)
//        let previewHeight = Int(resolvedSettings.previewDimensions.height)
//
//        if let previewBuffer = previewPhotoSampleBuffer {
//            if let imageBuffer = CMSampleBufferGetImageBuffer(previewBuffer) {
//                let ciImagePreview = CIImage(cvImageBuffer: imageBuffer)
//                let context = CIContext()
//                if let cgImagePreview = context.createCGImage(ciImagePreview, from: CGRect(x: 0, y: 0, width:previewWidth , height:previewHeight )) {
//                    photoThumbnail = UIImage(cgImage: cgImagePreview)
//                }
//            }
//        }
//    }
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photoSampleBuffer: CMSampleBuffer?, previewPhoto previewPhotoSampleBuffer: CMSampleBuffer?, resolvedSettings: AVCaptureResolvedPhotoSettings, bracketSettings: AVCaptureBracketedStillImageSettings?, error: Error?) {
        if (error != nil) {
            print(error!.localizedDescription)
        }
        
        if (photoSampleBuffer != nil) {
            let photoData = AVCapturePhotoOutput.jpegPhotoDataRepresentation(forJPEGSampleBuffer: photoSampleBuffer!, previewPhotoSampleBuffer: nil)
            //let data = [AVCapturePhotoOutput JPEGPhotoDataRepresentationForJPEGSampleBuffer:photoSampleBuffer previewPhotoSampleBuffer:previewPhotoSampleBuffer];
            if let photoData = photoData, let image = UIImage(data: photoData){
                saveImageToPhotos(imgData: image)
            }
            //UIImage *image = [UIImage imageWithData:data];
        }
    }
    
    func makePhoto(){
        BaseCamera.shared.makePhoto(vc: self)
    }
    
    func onOffFlashLight(on: Bool){
        BaseCamera.shared.toggleTorch(on: on)
    }
    
    func getStateOfFlash() -> AVCaptureDevice.TorchMode?{
        return BaseCamera.shared.getStateOfFlash()
    }
    
    func toggleFlash(){
        BaseCamera.shared.toggleFlash()
    }
    
    
    
    

 }


extension UIViewController {
    func showCameraInView(camView:UIView){
        BaseCamera.shared.showcamera(camView: camView)
    }
    func switchCamera(){
        BaseCamera.shared.switchCameraTapped()
    }
    func takePhotoFromCamera(completed: @escaping (UIImage?)->Void){
        BaseCamera.shared.takePhotoFromCamera(vc: self, completed: completed)
    }
    
}






