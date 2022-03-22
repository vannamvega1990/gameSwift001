//
//  OCRScanViewController.swift
//  VegaFintech
//
//  Created by Tu Dao on 7/1/21.
//  Copyright © 2021 Vega. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit
import Vision


//class OCRScanViewController: FTBaseViewController {
//
//    init() {
//        super.init(nibName: "OCRScanViewController", bundle: nil)
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//
//    }
//
//
//}


extension UIViewController {
    func showAlert(title: String?, message: String?) {
//        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
//        self.present(alert, animated: true)
        print("title:\(title ?? "") - message:\(message ?? "")")
    }
    
    func checkConnection() {
        if !Reachability.isConnectedToNetwork(){
            let destinationVC = self.storyboard?.instantiateViewController(withIdentifier: "DisconnectViewController") as! DisconnectViewController
            self.navigationController?.present(destinationVC, animated: true, completion: nil)
        }
    }
}


extension OCRScanViewController: CaptureManagerDelegate {
    func processCapturedImage(image: UIImage) {
        self.image = image
    }
}

class OCRScanViewController: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate {
    @IBOutlet weak var captureButton: UIButton!
    
    @IBOutlet weak var sideLabel: UILabel!
//    @IBOutlet weak var sideLabelCenterYConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var textNoteLbael: UILabel!
    private let captureSession = AVCaptureSession()
    
    private lazy var previewLayer = AVCaptureVideoPreviewLayer(session: self.captureSession)
    
    private let videoDataOutput = AVCaptureVideoDataOutput()
    
    private var isTapped = false
    
    private var maskLayer = CAShapeLayer()
    
    public var isFront = true
    
    private var staticRect = CGRect()
    
    private let apiServices = APIServices()
    
    public var frontImage = UIImage()
    
    public var backImage = UIImage()
    
    var topShape = CAShapeLayer()
    
    var leftShape = CAShapeLayer()
    
    var rightShape = CAShapeLayer()
    
    var bottomShape = CAShapeLayer()
    
    var image: UIImage?
    
    var frontCallBack: FrontOCR?
    
    var backCallBack: BackOCR?
    
    var onDoneBlock : ((Bool) -> Void)?
    
    enum direction {
        case top
        case left
        case right
        case bottom
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkConnection()
        if isVN {
            self.sideLabel.text = "Mặt trước"
            self.textNoteLbael.text = "Bạn vui lòng đặt các viền của CMND/CCCD khớp với khung hình."
        } else {
            self.sideLabel.text = "Front side"
            self.textNoteLbael.text = "Make sure your ID borders match the frame."
        }
        self.requestCemeraPermission()
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.showCameraFeed()
        captureSession.startRunning()
    }
    
    @IBAction func captureAction(_ sender: Any) {
        self.isTapped = true
    }
    
    
    private func requestCemeraPermission() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized: // The user has previously granted access to the camera.
            self.setCameraInput()
            
        case .notDetermined: // The user has not yet been asked for camera access.
            AVCaptureDevice.requestAccess(for: .video) { granted in
                if granted {
                    self.setCameraInput()
                }
            }
            
        case .denied: // The user has previously denied access.
            return
            
        case .restricted: // The user can't grant access due to restrictions.
            return
        @unknown default:
            print("No camera access!")
        }
    }
    
    private func setCameraInput() {
        guard let device = AVCaptureDevice.DiscoverySession(
                deviceTypes: [.builtInWideAngleCamera],
                mediaType: .video,
                position: .back).devices.first else {
            return print("No back camera device found.")
        }
        let cameraInput = try! AVCaptureDeviceInput(device: device)
        self.captureSession.addInput(cameraInput)
        self.setCameraOutput()
//        if let device = AVCaptureDevice.default(.builtInTrueDepthCamera,
//                                                for: .video,
//                                                position: .back) {
//            let cameraInput = try! AVCaptureDeviceInput(device: device)
//            self.captureSession.addInput(cameraInput)
//        } else if let device = AVCaptureDevice.default(.builtInWideAngleCamera,
//                                                       for: .video,
//                                                       position: .back) {
//            let cameraInput = try! AVCaptureDeviceInput(device: device)
//            self.captureSession.addInput(cameraInput)
//        } else {
//            return
//        }
    }
    
    func isIdiomPhone() -> Bool {
        return UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.phone
    }
    
    func isIdiomPad() -> Bool {
        return UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad
    }
    
    func screenWidth() -> CGFloat {
        let screenSize = screenSizeOfDevice()
        return isIdiomPad() ? screenSize.maxSize : screenSize.minSize
    }
    
    func screenHeigth() -> CGFloat {
        return UIScreen.main.bounds.size.height + UIScreen.main.bounds.size.width - screenWidth()
    }
    
    func screenSizeOfDevice() -> (minSize : CGFloat, maxSize : CGFloat) {
        if UIScreen.main.bounds.size.width < UIScreen.main.bounds.size.height {
            return (UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height)
        } else {
            return (UIScreen.main.bounds.size.height, UIScreen.main.bounds.size.width)
        }
    }
    
    private func showCameraFeed() {
        self.previewLayer.videoGravity = .resizeAspect
        //self.view.layer.addSublayer(self.previewLayer)
        self.view.layer.insertSublayer(self.previewLayer, below: self.captureButton.layer)
        self.previewLayer.frame = self.view.frame
        // Create Visual Rect
//        self.staticRect = CGRect(x: self.previewLayer.frame.width / 2 - 150, y: self.previewLayer.frame.height / 2 - 100, width: 300, height: 200)
        
        switch UIDevice.current.userInterfaceIdiom {
        case .pad:
            self.staticRect = CGRect(x: self.previewLayer.frame.width / 2 - 300, y: self.previewLayer.frame.height / 2 - 200, width: 600, height: 400)
        case .phone:
            self.staticRect = CGRect(x: self.previewLayer.frame.width - screenWidth() + 10, y: self.previewLayer.frame.height / 2 - 100, width: screenWidth() - 20, height: (screenWidth() - 20)/85.6 * 53.98)
        default:
            self.staticRect = CGRect(x: self.previewLayer.frame.width - screenWidth() + 10, y: self.previewLayer.frame.height / 2 - 100, width: screenWidth() - 20, height: (screenWidth() - 20)/85.6 * 53.98)
        }
        createLayer(in: staticRect, isInRect: false)
    }
    
    private func setCameraOutput() {
        self.videoDataOutput.videoSettings = [(kCVPixelBufferPixelFormatTypeKey as NSString) : NSNumber(value: kCVPixelFormatType_32BGRA)] as [String : Any]
        self.videoDataOutput.alwaysDiscardsLateVideoFrames = true
        self.videoDataOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "camera_frame_processing_queue"))
        self.captureSession.addOutput(self.videoDataOutput)
        guard let connection = self.videoDataOutput.connection(with: AVMediaType.video), connection.isVideoOrientationSupported else { return }
        connection.videoOrientation = .portrait
    }
    
    private func detectRectangle(in image: CVPixelBuffer) {
        let request = VNDetectRectanglesRequest(completionHandler: { (request: VNRequest, error: Error?) in
            DispatchQueue.main.async {
                
                guard let results = request.results as? [VNRectangleObservation] else { return }
                //self.removeMask()
                guard let rect = results.first else{return}
//                self.drawBoundingBox(rect: rect)
                
                if self.isTapped {
                    self.isTapped = false
                    self.doPerspectiveCorrection(rect, from: image)
                }
            }
        })
        
        request.minimumAspectRatio = VNAspectRatio(1.3)
        request.maximumAspectRatio = VNAspectRatio(1.6)
        request.minimumSize = Float(0.5)
        request.maximumObservations = 1
        
        let imageRequestHandler = VNImageRequestHandler(cvPixelBuffer: image, options: [:])
        try? imageRequestHandler.perform([request])
    }
    
    func cropToBounds(image: UIImage, width: Double, height: Double) -> UIImage {

        let cgimage = image.cgImage!
        let contextImage: UIImage = UIImage(cgImage: cgimage)
        let contextSize: CGSize = contextImage.size
        var posX: CGFloat = 0.0
        var posY: CGFloat = 0.0
        var cgwidth: CGFloat = CGFloat(width)
        var cgheight: CGFloat = CGFloat(height)

        // See what size is longer and create the center off of that self.previewLayer.frame.width - screenWidth() + 10
        if contextSize.width > contextSize.height {
            posX = ((contextSize.width - contextSize.height) / 2)
            posY = 0
            cgwidth = contextSize.height
            cgheight = contextSize.height
        } else {
//            posX = self.previewLayer.frame.width - screenWidth() + 10
//            posY = self.previewLayer.frame.height / 2 - 100
            posX = 0
            posY = ((contextSize.height - contextSize.width) / 2)
            cgwidth = contextSize.width
            cgheight = contextSize.width
        }

        let rect: CGRect = CGRect(x: posX, y: posY, width: cgwidth, height: cgheight + 15)

        // Create bitmap image from context using the rect
        let imageRef: CGImage = cgimage.cropping(to: rect)!

        // Create a new image based on the imageRef and rotate back to the original orientation
        let image: UIImage = UIImage(cgImage: imageRef, scale: image.scale, orientation: image.imageOrientation)

        return image
    }
    
    func getImageFromSampleBuffer(sampleBuffer: CMSampleBuffer) ->UIImage? {
        guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else {
            return nil
        }
        CVPixelBufferLockBaseAddress(pixelBuffer, .readOnly)
        let baseAddress = CVPixelBufferGetBaseAddress(pixelBuffer)
        let width = CVPixelBufferGetWidth(pixelBuffer)
        let height = CVPixelBufferGetHeight(pixelBuffer)
        let bytesPerRow = CVPixelBufferGetBytesPerRow(pixelBuffer)
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedFirst.rawValue | CGBitmapInfo.byteOrder32Little.rawValue)
        guard let context = CGContext(data: baseAddress, width: width, height: height, bitsPerComponent: 8, bytesPerRow: bytesPerRow, space: colorSpace, bitmapInfo: bitmapInfo.rawValue) else {
            return nil
        }
        guard let cgImage = context.makeImage() else {
            return nil
        }
        let image = UIImage(cgImage: cgImage, scale: 1, orientation:.right)
        CVPixelBufferUnlockBaseAddress(pixelBuffer, .readOnly)
        return image
    }
    
    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        guard CMSampleBufferGetImageBuffer(sampleBuffer) != nil else {
            debugPrint("unable to get image from sample buffer")
            return
        }
        guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else {
            return
        }
        if self.isTapped {
            self.isTapped = false
            CVPixelBufferLockBaseAddress(pixelBuffer, .readOnly)
            let baseAddress = CVPixelBufferGetBaseAddress(pixelBuffer)
            let width = CVPixelBufferGetWidth(pixelBuffer)
            let height = CVPixelBufferGetHeight(pixelBuffer)
            let bytesPerRow = CVPixelBufferGetBytesPerRow(pixelBuffer)
            let colorSpace = CGColorSpaceCreateDeviceRGB()
            let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedFirst.rawValue | CGBitmapInfo.byteOrder32Little.rawValue)
            guard let context = CGContext(data: baseAddress, width: width, height: height, bitsPerComponent: 8, bytesPerRow: bytesPerRow, space: colorSpace, bitmapInfo: bitmapInfo.rawValue) else {
                return
            }
            guard let cgImage = context.makeImage() else {
                return
            }
            
            let image = UIImage(cgImage: cgImage, scale: 1, orientation:.right)
            CVPixelBufferUnlockBaseAddress(pixelBuffer, .readOnly)
            
            self.image = image
            let finalImg = cropToBounds(image: image, width: Double(screenWidth() - 20), height: Double((screenWidth() - 20)/85.6 * 53.98))
            let rolateImage = finalImg.rotate(radians: .pi * 1.5)
            if isFront == true {
                self.frontCallBack?.frontCallBack(image: rolateImage)
                self.onDoneBlock!(true)
            }else {
                self.backCallBack?.backCallBack(image: rolateImage)
                self.onDoneBlock!(true)
            }
            DispatchQueue.main.async {
                //let destinationVC = self.storyboard?.instantiateViewController(withIdentifier: "PreviewViewController") as! PreviewViewController
                
                let storyboard = UIStoryboard(name: "ResultOCR", bundle: nil)
                
                //let destinationVC = storyboard.instantiateViewController(withIdentifier: "testvc1") as! UIViewController // PreviewViewController
                let destinationVC = PreviewViewController()
                //destinationVC.view.backgroundColor = .red
                destinationVC.previewImage = finalImg
                destinationVC.isFront = self.isFront
                destinationVC.delegate = self
                self.navigationController?.present(destinationVC, animated: true, completion: nil)
            }
        }
        
//        self.detectRectangle(in: frame)
    }
    
    func drawBoundingBox(rect : VNRectangleObservation) {
        let transform = CGAffineTransform(scaleX: 1, y: -1).translatedBy(x: 0, y: -self.previewLayer.frame.height)
        let scale = CGAffineTransform.identity.scaledBy(x: self.previewLayer.frame.width, y: self.previewLayer.frame.height)
        let bounds = rect.boundingBox.applying(scale).applying(transform)
        
        //        var isEqualX = false
        //        var isEqualY = false
        //        var isEqualWidth = false
        //        var isEqualHeight = false
        //        if bounds.origin.x <= staticRect.origin.x + 20 && bounds.origin.x >= staticRect.origin.x - 20 {
        //            isEqualX = true
        //        }
        //        if bounds.origin.y <= staticRect.origin.y + 20 && bounds.origin.y >= staticRect.origin.y - 20 {
        //            isEqualY = true
        //        }
        //        if bounds.width <= staticRect.width + 20 && bounds.width >= staticRect.width - 20 {
        //            isEqualWidth = true
        //        }
        //        if bounds.height <= staticRect.height + 10 && bounds.height >= staticRect.height - 20 {
        //            isEqualHeight = true
        //        }
        //        if isEqualX && isEqualY && isEqualWidth && isEqualHeight {
        //            updateLayer(in: staticRect, isInRect: true)
        //        } else {
        //            updateLayer(in: staticRect, isInRect: false)
        //        }
        
        var isTopOK = false
        var isLeftOK = false
        var isRightOK = false
        var isBottomOK = false
        
        if bounds.minX <= staticRect.minX + 20 &&
            bounds.minX >= staticRect.minX - 20 &&
            bounds.minY <= staticRect.minY + 20 &&
            bounds.minY >= staticRect.minY - 20 &&
            bounds.maxX <= staticRect.maxX + 20 &&
            bounds.maxX >= staticRect.maxX - 20{
            isTopOK = true
            self.topShape.isHidden = false
        } else {
            isTopOK = false
            self.topShape.isHidden = true
        }
        
        if bounds.minX <= staticRect.minX + 20 &&
            bounds.minX >= staticRect.minX - 20 &&
            bounds.minY <= staticRect.minY + 20 &&
            bounds.minY >= staticRect.minY - 20 &&
            bounds.maxY <= staticRect.maxY + 20 &&
            bounds.maxY >= staticRect.maxY - 20 {
            isLeftOK = true
            self.leftShape.isHidden = false
        } else {
            isLeftOK = false
            self.leftShape.isHidden = true
        }
        
        if bounds.maxX <= staticRect.maxX + 20 &&
            bounds.maxX >= staticRect.maxX - 20 &&
            bounds.minY <= staticRect.minY + 20 &&
            bounds.minY >= staticRect.minY - 20 &&
            bounds.maxY <= staticRect.maxY + 20 &&
            bounds.maxY >= staticRect.maxY - 20 {
            isRightOK = true
            self.rightShape.isHidden = false
        } else {
            isRightOK = false
            self.rightShape.isHidden = true
        }
        
        if bounds.minX <= staticRect.minX + 20 &&
            bounds.minX >= staticRect.minX - 20 &&
            bounds.maxY <= staticRect.maxY + 20 &&
            bounds.maxY >= staticRect.maxY - 20 &&
            bounds.maxX <= staticRect.maxX + 20 &&
            bounds.maxX >= staticRect.maxX - 20 {
            isBottomOK = true
            self.bottomShape.isHidden = false
        } else {
            isBottomOK = false
            self.bottomShape.isHidden = true
        }
        
//        if isLeftOK && isRightOK && isTopOK && isBottomOK {
//            updateLayer(in: staticRect, isInRect: true)
//        } else {
//            updateLayer(in: staticRect, isInRect: false)
//        }
    }
    

    
    func createLayer(in rect: CGRect, isInRect: Bool) {
        //hole
        let path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: self.view.bounds.size.height), cornerRadius: 0)
        // margin side = 30 - top = 60
        let rectPath = UIBezierPath(roundedRect: rect, cornerRadius: 10)
        path.append(rectPath)
        path.usesEvenOddFillRule = true

        let fillLayer = CAShapeLayer()
        fillLayer.path = path.cgPath
        fillLayer.fillRule = .evenOdd
        fillLayer.fillColor = UIColor.black.cgColor
        fillLayer.opacity = 0.8
        
        maskLayer = CAShapeLayer()
        maskLayer.frame = rect
        maskLayer.cornerRadius = 10
        maskLayer.opacity = 0.75
        
//        if isInRect {
            maskLayer.borderColor = UIColor.green.cgColor
//        } else {
//            maskLayer.borderColor = UIColor.red.cgColor
//        }
        maskLayer.borderWidth = 5.0

        previewLayer.insertSublayer(fillLayer, at: 1)
        previewLayer.insertSublayer(maskLayer, above: fillLayer)
        
        self.topShape = drawShape(rect: rect, direction: .top)
        self.leftShape = drawShape(rect: rect, direction: .left)
        self.rightShape = drawShape(rect: rect, direction: .right)
        self.bottomShape = drawShape(rect: rect, direction: .bottom)
        
        hideAllDirection()
        
        previewLayer.addSublayer(topShape)
        previewLayer.addSublayer(leftShape)
        previewLayer.addSublayer(rightShape)
        previewLayer.addSublayer(bottomShape)
    }
    
    func drawShape(rect: CGRect, direction: direction) -> CAShapeLayer {
        let shape = CAShapeLayer()
        let path = UIBezierPath()

        switch direction {
        case .top:
            path.move(to: CGPoint(x: rect.minX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
            shape.frame = CGRect(x: rect.minX, y: rect.minY, width: rect.width, height: 5)
        case .left:
            path.move(to: CGPoint(x: rect.minX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
            shape.frame = CGRect(x: rect.minX, y: rect.minY, width: 5, height: rect.height)
        case .right:
            path.move(to: CGPoint(x: rect.maxX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
            shape.frame = CGRect(x: rect.maxX - 5, y: rect.minY, width: 5, height: rect.height)
        case .bottom:
            path.move(to: CGPoint(x: rect.minX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
            shape.frame = CGRect(x: rect.minX, y: rect.maxY - 5, width: rect.width, height: 5)
        }
        
        shape.cornerRadius = 10
        shape.path = path.cgPath
        shape.borderColor = UIColor.green.cgColor
        shape.borderWidth = 5
        return shape
    }
    
    private func updateLayer(in rect: CGRect, isInRect: Bool) {
        if isInRect {
            maskLayer.borderColor = UIColor.green.cgColor
        } else {
            maskLayer.borderColor = UIColor.red.cgColor
        }
    }
    
    func hideAllDirection() {
        self.topShape.isHidden = true
        self.leftShape.isHidden = true
        self.rightShape.isHidden = true
        self.bottomShape.isHidden = true
    }
    
    func doPerspectiveCorrection(_ observation: VNRectangleObservation, from buffer: CVImageBuffer) {
        
        var ciImage = CIImage(cvImageBuffer: buffer)

        let topLeft = observation.topLeft.scaled(to: ciImage.extent.size)
        let topRight = observation.topRight.scaled(to: ciImage.extent.size)
        let bottomLeft = observation.bottomLeft.scaled(to: ciImage.extent.size)
        let bottomRight = observation.bottomRight.scaled(to: ciImage.extent.size)
        
        ciImage = ciImage.applyingFilter("CIPerspectiveCorrection", parameters: [
            "inputTopLeft": CIVector(cgPoint: topLeft),
            "inputTopRight": CIVector(cgPoint: topRight),
            "inputBottomLeft": CIVector(cgPoint: bottomLeft),
            "inputBottomRight": CIVector(cgPoint: bottomRight),
        ])
        
        let context = CIContext()
        let cgImage = context.createCGImage(ciImage, from: ciImage.extent)
        let output = UIImage(cgImage: cgImage!)
        
        if self.isFront == true {
            self.frontImage = output
        }else {
            self.backImage = output
        }
        
//        let destinationVC = self.storyboard?.instantiateViewController(withIdentifier: "PreviewViewController") as! PreviewViewController
        
        let destinationVC = PreviewViewController()
        destinationVC.previewImage = output
        destinationVC.isFront = isFront
        destinationVC.delegate = self
        
        //let destinationVC = UIViewController()
        
        self.navigationController?.present(destinationVC, animated: true, completion: {
            self.dismiss(animated: true) {}
        })
        
    }
    
    func removeMask() {
        maskLayer.removeFromSuperlayer()
    }
}

extension OCRScanViewController: PreviewControllerDelegate {
    func userDidConfirm(image: UIImage, isFront: Bool) {
        if isFront {
            self.frontImage = image
            self.isFront = false
            if isVN {
                self.sideLabel.text = "Mặt sau"
                self.textNoteLbael.text = "Bạn vui lòng đặt các viền của CMND/CCCD khớp với khung hình."
            } else {
                self.sideLabel.text = "Back side"
                self.textNoteLbael.text = "Make sure your ID borders match the frame."
            }
        } else {
            self.backImage = image
            //let destinationVC = self.storyboard?.instantiateViewController(withIdentifier: "FaceMatchGuideViewController") as! FaceMatchGuideViewController
            let destinationVC = FaceMatchGuideViewController()
            destinationVC.frontImage = frontImage
            destinationVC.backImage = backImage
            
            //let destinationVC = UIViewController()
            self.navigationController?.pushViewController(destinationVC, animated: true)
        }
    }
}

extension CGPoint {
    func scaled(to size: CGSize) -> CGPoint {
        return CGPoint(x: self.x * size.width,
                       y: self.y * size.height)
    }
}


