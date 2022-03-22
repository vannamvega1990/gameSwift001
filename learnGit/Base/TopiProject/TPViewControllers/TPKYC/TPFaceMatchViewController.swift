//
//  TPFaceMatchViewController.swift
//  VegaFintech
//
//  Created by Tu Dao on 7/15/21.
//  Copyright © 2021 Vega. All rights reserved.
//

import UIKit
import Vision
import AVFoundation

class TPFaceMatchViewController: UIViewController {

    @IBOutlet weak var viewContainerCollection: BaseCollectionView!
    
    let session = AVCaptureSession()
    var previewLayer: AVCaptureVideoPreviewLayer!
    var frontImage = UIImage()
    
    var backImage = UIImage()
    let dataOutputQueue = DispatchQueue(
    label: "video data queue",
    qos: .userInitiated,
    attributes: [],
    autoreleaseFrequency: .workItem)
    
    init() {
        super.init(nibName: "TPFaceMatchViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupCollectionView() {
        viewContainerCollection.numberOfSections = 1
        viewContainerCollection.numberItemsInSection = 16
        //viewContainerCollection.registerCellWithClass(ImageCell1: UICollectionViewCell(), idCell: "cell")
        let nibCell = UINib(nibName: "TPFaceImageCollectionViewCell", bundle: nil)
        viewContainerCollection.registerCellWithNib(nib:nibCell, idCell:"cell")
        viewContainerCollection.CreateCellClorsure = {
            clv,index in
            let cell = clv.dequeueReusableCell(withReuseIdentifier: "cell", for: index)
            cell.backgroundColor = .red
            return cell
        }
        viewContainerCollection.setDelegateDatasource()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        configureCaptureSession()
    }



}

extension TPFaceMatchViewController {
    func configureCaptureSession() {
        // Define the capture device we want to use
        guard let camera = AVCaptureDevice.default(.builtInWideAngleCamera,
                                                   for: .video,
                                                   position: .front) else {
            return print("No front video camera available")
        }
        
        // Connect the camera to the capture session input
        do {
            let cameraInput = try AVCaptureDeviceInput(device: camera)
            session.addInput(cameraInput)
        } catch {
            return print(error.localizedDescription)
        }
        
        // Create the video data output
        let videoOutput = AVCaptureVideoDataOutput()
        videoOutput.setSampleBufferDelegate(self, queue: dataOutputQueue)
        videoOutput.videoSettings = [kCVPixelBufferPixelFormatTypeKey as String: kCVPixelFormatType_32BGRA]
        
        // Add the video output to the capture session
        session.addOutput(videoOutput)
        
        let videoConnection = videoOutput.connection(with: .video)
        videoConnection?.videoOrientation = .portrait
        
        // Configure the preview layer
        previewLayer = AVCaptureVideoPreviewLayer(session: session)
        previewLayer.videoGravity = .resizeAspectFill
        previewLayer.frame = view.bounds
        view.layer.insertSublayer(previewLayer, at: 0)
        session.startRunning()
    }
}
    
extension TPFaceMatchViewController: AVCaptureVideoDataOutputSampleBufferDelegate {
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        // 1
        guard let imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else {
            return
        }
        
//        let ciImage = CIImage(cvImageBuffer: imageBuffer)
//        let context = CIContext()
//        let cgImage = context.createCGImage(ciImage, from: ciImage.extent)
//        let output = UIImage(cgImage: cgImage!)
//
//        if isCaptured {
//            print("output")
//            switch currentYaw {
//            case .center:
//                currentYaw = .left
//                imageList[0] = output
//                DispatchQueue.main.async {
//                    self.faceCollection.reloadItems(at: [IndexPath(row: 0, section: 0)])
//                }
//                startDetect()
//            case .left:
//                currentYaw = .right
//                imageList[1] = output
//                DispatchQueue.main.async {
//                    self.faceCollection.reloadItems(at: [IndexPath(row: 1, section: 0)])
//                }
//                startDetect()
//            case .right:
//                self.isCaptured = false
//                self.imageList[2] = output
//                Constants.KEY.faceOCR = self.imageList
//
//
//
//                //self.faceCallBack?.faceCallBack(image: self.imageList)
//                //self.onDoneBlock!(true)
//
//
//
//                DispatchQueue.main.async {
//                    self.faceCollection.reloadItems(at: [IndexPath(row: 2, section: 0)])
//                    //self.dismiss(animated: false, completion: nil)
//                    self.showResult()
//                }
//            }
//        }
//
//        // 2
//        let detectFaceRequest = VNDetectFaceLandmarksRequest(completionHandler: detectedFace)
//
//        // 3
//        do {
//            try sequenceHandler.perform(
//                [detectFaceRequest],
//                on: imageBuffer,
//                orientation: .leftMirrored)
//        } catch {
//            print(error.localizedDescription)
//        }
    }
}
