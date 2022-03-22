
//
//  FaceMatchViewController.swift
//  VegaFintecheKYC
//
//  Created by Dương Tú on 28/01/2021.
//

import UIKit
import Vision
import AVFoundation

class FaceMatchViewController: UIViewController {
    
//    init() {
//        super.init(nibName: "FaceMatchViewController", bundle: nil)
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    var sequenceHandler = VNSequenceRequestHandler()
    
    @IBOutlet var faceView: FaceView!
    //  @IBOutlet var laserView: LaserView!
    @IBOutlet weak var faceCollection: UICollectionView!
    @IBOutlet weak var faceCollectionCenterYConstant: NSLayoutConstraint!
    @IBOutlet weak var faceLabel: UILabel!
    
    var frontImage = UIImage()
    
    var backImage = UIImage()
    var apiService = APIServices()
    var progressCircle: CircularProgressView!
    let session = AVCaptureSession()
    var previewLayer: AVCaptureVideoPreviewLayer!
    
    let dataOutputQueue = DispatchQueue(
        label: "video data queue",
        qos: .userInitiated,
        attributes: [],
        autoreleaseFrequency: .workItem)
    
    var faceViewHidden = false
    
    var maxX: CGFloat = 0.0
    var midY: CGFloat = 0.0
    var maxY: CGFloat = 0.0
    var isCaptured = false
    var currentYaw = faceDirect.center
    public var imageList = [UIImage]()
    var isDetecting = false
    var confirmIcon = UIImageView()
    var faceCallBack: FaceOCR?
    var onDoneBlock : ((Bool) -> Void)?
    
    enum faceDirect {
        case center
        case left
        case right
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkConnection()
        configureCaptureSession()

        maxX = view.bounds.maxX
        midY = view.bounds.midY
        maxY = view.bounds.maxY

        //session.startRunning()
//
        //imageList.append(bundledImage(named: "center")!)
        //imageList.append(bundledImage(named: "left")!)
        //imageList.append(bundledImage(named: "right")!)
        imageList.append(UIImage(named: "center")!)
        imageList.append(UIImage(named: "left")!)
        imageList.append(UIImage(named: "right")!)
//
        faceCollection.dataSource = self
        faceCollection.delegate = self
        faceCollection.allowsSelection = true
//
//        createHole()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //startDetect()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //self.navigationController?.isNavigationBarHidden = false
    }
    
    func startTimer() {
        DispatchQueue.main.async {
            Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { (timer) in
                print("capture")
                self.isCaptured = true
                self.confirmIcon.isHidden = false
                self.progressCircle.toggleProgress(isCaptured: true)
            }
        }
    }
    
//    func stopTimer() {
//        guard timer != nil else { return }
//        timer?.invalidate()
//        timer = nil
//    }
    
    func startDetect() {
        self.isDetecting = true
        DispatchQueue.main.async {
            self.confirmIcon.isHidden = true
            self.progressCircle.toggleProgress(isCaptured: false)
            self.isCaptured = false
            
            switch self.currentYaw {
            case .center:
                if isVN {
                    self.faceLabel.text = "Nhìn thẳng vào khung hình"
                } else {
                    self.faceLabel.text = "Center"
                }
                
                self.faceCollection.selectItem(at: IndexPath(row: 0, section: 0), animated: true, scrollPosition: .centeredHorizontally)
            case .left:
                if isVN {
                    self.faceLabel.text = "👈  Nhìn phía bên trái"
                } else {
                    self.faceLabel.text = "👈  Left"
                }
                self.faceCollection.selectItem(at: IndexPath(row: 1, section: 0), animated: true, scrollPosition: .centeredHorizontally)
            case .right:

                if isVN {
                    self.faceLabel.text = "Nhìn phía bên phải  👉"
                } else {
                    self.faceLabel.text = "Right  👉"
                }
                self.faceCollection.selectItem(at: IndexPath(row: 2, section: 0), animated: true, scrollPosition: .centeredHorizontally)
            }
        }
    }
    
    //show Progress
//    @objc func handleTap() {
//        progressCircle.progressAnimation(duration: 0)
//    }
    
    func createHole() {
        //hole
        let radius: CGFloat = self.view.frame.width / 2 - 30 // Half of screen width - side margin
        switch UIDevice.current.userInterfaceIdiom {
        case .pad:
            self.faceCollectionCenterYConstant.constant = 100
        case .phone:
            self.faceCollectionCenterYConstant.constant = 0
        default:
            self.faceCollectionCenterYConstant.constant = 0
        }
        let path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: self.view.bounds.size.height), cornerRadius: 0)
        // margin side = 30 - top = 60
        let circlePath = UIBezierPath(roundedRect: CGRect(x: 30, y: 60, width: 2 * radius, height: 2 * radius), cornerRadius: radius)
        path.append(circlePath)
        path.usesEvenOddFillRule = true

        let fillLayer = CAShapeLayer()
        fillLayer.path = path.cgPath
        fillLayer.fillRule = .evenOdd
        fillLayer.fillColor = view.backgroundColor?.cgColor
        fillLayer.opacity = 0.8
        faceView.layer.insertSublayer(fillLayer, below: self.faceCollection.layer)
        
        confirmIcon = UIImageView(frame: CGRect(x: view.bounds.size.width / 2 - 32, y: 60 + radius - 32, width: 64, height: 64))
        confirmIcon.image = bundledImage(named: "confirmBtn")
        confirmIcon.isHidden = true
        //progress
        progressCircle = CircularProgressView(frame: CGRect(x: 30, y: 60, width: 2 * radius, height: 2 * radius))
        faceView.addSubview(progressCircle)
        faceView.addSubview(confirmIcon)
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
    
    func bundledImage(named: String) -> UIImage? {
        let image = UIImage(named: named)
        let bundle = self.loadSDKBundle()
        if image == nil {
            return UIImage(named: named, in: bundle, compatibleWith: nil)
        }
        return image
    }
    
    func showResult() {
//        let destinationVC = self.storyboard?.instantiateViewController(withIdentifier: "ResultViewController") as! ResultViewController
//        destinationVC.faceIdentity = self.imageList[0]
//        destinationVC.frontImage = self.frontImage
//        destinationVC.backImage = self.backImage
//        self.navigationController?.pushViewController(destinationVC, animated: true)
    }
}

// MARK: - Video Processing methods

extension FaceMatchViewController {
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
    }
}

// MARK: - AVCaptureVideoDataOutputSampleBufferDelegate methods

extension FaceMatchViewController: AVCaptureVideoDataOutputSampleBufferDelegate {
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        // 1
        guard let imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else {
            return
        }
        
        let ciImage = CIImage(cvImageBuffer: imageBuffer)
        let context = CIContext()
        let cgImage = context.createCGImage(ciImage, from: ciImage.extent)
        let output = UIImage(cgImage: cgImage!)
        
        if isCaptured {
            print("output")
            switch currentYaw {
            case .center:
                currentYaw = .left
                imageList[0] = output
                DispatchQueue.main.async {
                    self.faceCollection.reloadItems(at: [IndexPath(row: 0, section: 0)])
                }
                startDetect()
            case .left:
                currentYaw = .right
                imageList[1] = output
                DispatchQueue.main.async {
                    self.faceCollection.reloadItems(at: [IndexPath(row: 1, section: 0)])
                }
                startDetect()
            case .right:
                self.isCaptured = false
                self.imageList[2] = output
                Constants.KEY.faceOCR = self.imageList
                self.faceCallBack?.faceCallBack(image: self.imageList)
                self.onDoneBlock!(true)
                DispatchQueue.main.async {
                    self.faceCollection.reloadItems(at: [IndexPath(row: 2, section: 0)])
                    self.dismiss(animated: false, completion: nil)
//                    self.showResult()
                }
            }
        }
        
        // 2
        let detectFaceRequest = VNDetectFaceLandmarksRequest(completionHandler: detectedFace)

        // 3
        do {
            try sequenceHandler.perform(
                [detectFaceRequest],
                on: imageBuffer,
                orientation: .leftMirrored)
        } catch {
            print(error.localizedDescription)
        }
    }
}

extension FaceMatchViewController {
    func convert(rect: CGRect) -> CGRect {
        // 1
        let origin = previewLayer.layerPointConverted(fromCaptureDevicePoint: rect.origin)
        
        // 2
        let size = previewLayer.layerPointConverted(fromCaptureDevicePoint: rect.size.cgPoint)
        
        // 3
        return CGRect(origin: origin, size: size.cgSize)
    }
    
    // 1
    func landmark(point: CGPoint, to rect: CGRect) -> CGPoint {
        // 2
        let absolute = point.absolutePoint(in: rect)
        
        // 3
        let converted = previewLayer.layerPointConverted(fromCaptureDevicePoint: absolute)
        
        // 4
        return converted
    }
    
    func landmark(points: [CGPoint]?, to rect: CGRect) -> [CGPoint]? {
        guard let points = points else {
            return nil
        }
        
        return points.compactMap { landmark(point: $0, to: rect) }
    }
    
    func updateFaceView(for result: VNFaceObservation) {
        defer {
            DispatchQueue.main.async {
                self.faceView.setNeedsDisplay()
            }
        }
        //draw face
//        let box = result.boundingBox
//        faceView.boundingBox = convert(rect: box)
//
//        guard let landmarks = result.landmarks else {
//            return
//        }
//
//        if let leftEye = landmark(
//            points: landmarks.leftEye?.normalizedPoints,
//            to: result.boundingBox) {
//            faceView.leftEye = leftEye
//        } else {
//            faceView.leftEye = []
//        }
//
//        if let rightEye = landmark(
//            points: landmarks.rightEye?.normalizedPoints,
//            to: result.boundingBox) {
//            faceView.rightEye = rightEye
//        } else {
//            faceView.rightEye = []
//        }
//
//        if let leftEyebrow = landmark(
//            points: landmarks.leftEyebrow?.normalizedPoints,
//            to: result.boundingBox) {
//            faceView.leftEyebrow = leftEyebrow
//        }
//
//        if let rightEyebrow = landmark(
//            points: landmarks.rightEyebrow?.normalizedPoints,
//            to: result.boundingBox) {
//            faceView.rightEyebrow = rightEyebrow
//        }
//
//        if let nose = landmark(
//            points: landmarks.nose?.normalizedPoints,
//            to: result.boundingBox) {
//            faceView.nose = nose
//        }
//
//        if let outerLips = landmark(
//            points: landmarks.outerLips?.normalizedPoints,
//            to: result.boundingBox) {
//            faceView.outerLips = outerLips
//        }
//
//        if let innerLips = landmark(
//            points: landmarks.innerLips?.normalizedPoints,
//            to: result.boundingBox) {
//            faceView.innerLips = innerLips
//        }
//
//        if let faceContour = landmark(
//            points: landmarks.faceContour?.normalizedPoints,
//            to: result.boundingBox) {
//            faceView.faceContour = faceContour
//        }
        
        //detect face direction
//        DispatchQueue.main.async {
//            if let yaw = result.yaw as? Float {
//                if self.currentYaw != yaw {
//                    self.count = 0
//                } else {
//                    self.count += 1
//                }
//                if yaw < 0 {
//                    self.faceLabel.text = "👈  Nhìn phía bên trái"
//                    self.faceCollection.selectItem(at: IndexPath(row: 1, section: 0), animated: true, scrollPosition: .centeredHorizontally)
//                } else if yaw > 0 {
//                    self.faceLabel.text = "Nhìn phía bên phải  👉"
//                    self.faceCollection.selectItem(at: IndexPath(row: 2, section: 0), animated: true, scrollPosition: .centeredHorizontally)
//                } else if yaw == 0 {
//                    self.faceLabel.text = "Nhìn thẳng"
//                    self.faceCollection.selectItem(at: IndexPath(row: 0, section: 0), animated: true, scrollPosition: .centeredHorizontally)
//                }
//            }
        //        }
        if isDetecting {
            if let yaw = result.yaw as? Float {
                switch currentYaw {
                case .center:
                    if yaw == 0 {
                        isDetecting = false
                        startTimer()
                    }
                case .left:
                    if yaw < 0 {
                        isDetecting = false
                        startTimer()
                    }
                case .right:
                    if yaw > 0 {
                        isDetecting = false
                        startTimer()
                    }
                }
            }
        }
    }
    
    func detectedFace(request: VNRequest, error: Error?) {
        // 1
        guard
            let results = request.results as? [VNFaceObservation],
            let result = results.first
        else {
            // 2
            faceView.clear()
            return
        }
        
        updateFaceView(for: result)
    }
}

extension FaceMatchViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellID = "faceCell"
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! FaceCollectionViewCell
        switch indexPath.row {
        case 0:
            cell.faceImage.image = imageList[indexPath.row]
            if cell.faceImage.image != bundledImage(named: "center") {
                cell.checkMarkIcon.isHidden = false
            }
        case 1:
            cell.faceImage.image = imageList[indexPath.row]
            if cell.faceImage.image != bundledImage(named: "left") {
                cell.checkMarkIcon.isHidden = false
            }
        case 2:
            cell.faceImage.image = imageList[indexPath.row]
            if cell.faceImage.image != bundledImage(named: "right") {
                cell.checkMarkIcon.isHidden = false
            }
        default:
            cell.faceImage.image = imageList[indexPath.row]
            if cell.faceImage.image != bundledImage(named: "center") {
                cell.checkMarkIcon.isHidden = false
            }
        }
        cell.faceImage.layer.masksToBounds = false
        cell.faceImage.layer.cornerRadius = cell.faceImage.frame.height / 2
        cell.faceImage.clipsToBounds = true
        cell.faceImage.contentMode = .scaleAspectFill
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let inset = self.view.frame.width / 2 - 54
        return UIEdgeInsets(top: 0, left: inset, bottom: 0, right: inset)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 108, height: 108)
    }
}

