//
//  PreviewViewController.swift
//  VegaFintecheKYC
//
//  Created by Dương Tú on 25/01/2021.
//

import UIKit

let isVN = true

protocol PreviewControllerDelegate {
    func userDidConfirm(image: UIImage, isFront: Bool)
}

extension UIImage {
    func rotate(radians: CGFloat) -> UIImage {
        let rotatedSize = CGRect(origin: .zero, size: size)
            .applying(CGAffineTransform(rotationAngle: CGFloat(radians)))
            .integral.size
        UIGraphicsBeginImageContext(rotatedSize)
        if let context = UIGraphicsGetCurrentContext() {
            let origin = CGPoint(x: rotatedSize.width / 2.0,
                                 y: rotatedSize.height / 2.0)
            context.translateBy(x: origin.x, y: origin.y)
            context.rotate(by: radians)
            draw(in: CGRect(x: -origin.y, y: -origin.x,
                            width: size.width, height: size.height))
            let rotatedImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()

            return rotatedImage ?? self
        }

        return self
    }
}

//class PreviewViewController: UIViewController {
//
//    init() {
//        super.init(nibName: "PreviewViewController", bundle: nil)
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//}

class PreviewViewController: FTBaseViewController {

    init() {
        super.init(nibName: "PreviewViewController", bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    var previewImage = UIImage()
    var delegate: PreviewControllerDelegate?
    var isFront = false
    var counter = 5
    var timer = Timer()
    private var presentingController: UIViewController?
    @IBOutlet weak var reCaptureBtn: UIButton!
    @IBOutlet weak var reCaptureLabel: UILabel!
    @IBOutlet weak var reCaptureView: UIView!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var confirmLabel: UILabel!
    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet weak var descriptionLabel: UILabel!

//    @IBOutlet weak var desLabelCenterYConstraint: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()
        checkConnection()
        setupLanguage()
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        createLayer()
        
        self.presentingController = presentingViewController
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (timer) in
            self.counter -= 1
            if isVN {
                self.timerLabel.text = "(\(self.counter) giây)"
            } else {
                self.timerLabel.text = "(\(self.counter) second)"
            }
            if self.counter == 0 {
                self.confirm()
            }
        }
    }

    func setupLanguage() {
        if isVN {
            reCaptureLabel.text = "Chụp lại"
            descriptionLabel.text = "Xác nhận ảnh chụp?"
            confirmLabel.text = "Xác nhận và tiếp tục"
        } else {
            reCaptureLabel.text = "Retake"
            descriptionLabel.text = "Confirm?"
            confirmLabel.text = "Confirm and Continue"
        }
    }

    @IBAction func reCaptureAction(_ sender: Any) {
        timer.invalidate()
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func confirmAction(_ sender: Any) {
        confirm()
    }

    func confirm() {
        timer.invalidate()
        self.delegate?.userDidConfirm(image: previewImage, isFront: isFront)
        
        
        if isFront == true {
            Constants.KEY.frontOCR = previewImage
        }else {
            Constants.KEY.backOCR = previewImage
        }
        //testImage(img: previewImage)
        self.dismiss(animated: true, completion: {
            //self.presentingController?.dismiss(animated: false, completion: nil)
        })
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

    func createLayer() {
        var rect = CGRect(x: self.view.layer.frame.width / 2 - 155, y: self.view.layer.frame.height / 2 - 100, width: 300, height: 200)

        switch UIDevice.current.userInterfaceIdiom {
        case .pad:
            rect = CGRect(x: self.view.layer.frame.width / 2 - 300, y: self.view.layer.frame.height / 2 - 200, width: 600, height: 400)
//            self.desLabelCenterYConstraint.constant = 300
        case .phone:
            rect = CGRect(x: self.view.layer.frame.width - screenWidth() + 10, y: self.view.layer.frame.height / 2 - 100, width: screenWidth() - 20, height: (screenWidth() - 20)/85.6 * 55.0)
//            rect = CGRect(x: self.view.layer.frame.width / 2 - 150, y: self.view.layer.frame.height / 2 - 100, width: 300, height: 200)
//            self.desLabelCenterYConstraint.constant = 150
        default:
            rect = CGRect(x: self.view.layer.frame.width - screenWidth() + 10, y: self.view.layer.frame.height / 2 - 100, width: screenWidth() - 20, height: (screenWidth() - 20)/85.6 * 55.0)
//            rect = CGRect(x: self.view.layer.frame.width / 2 - 150, y: self.view.layer.frame.height / 2 - 100, width: 300, height: 200)
//            self.desLabelCenterYConstraint.constant = 300
        }
        //hole
        let path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: self.view.bounds.size.height), cornerRadius: 0)
        let rectPath = UIBezierPath(roundedRect: rect, cornerRadius: 10)
        path.append(rectPath)
        path.usesEvenOddFillRule = true

        let fillLayer = CAShapeLayer()
        fillLayer.path = path.cgPath
        fillLayer.fillRule = .evenOdd
        fillLayer.fillColor = UIColor.black.cgColor
        fillLayer.opacity = 0.8

        let maskLayer = CAShapeLayer()
        maskLayer.frame = rect
        maskLayer.cornerRadius = 10

        maskLayer.borderColor = UIColor.green.cgColor
        maskLayer.borderWidth = 5.0

        let rolateImage = self.previewImage.rotate(radians: .pi * 1.5)

        let imageView = UIImageView(frame: rect)
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.image = rolateImage
        imageView.backgroundColor = .black
        let layerView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height))
        layerView.layer.insertSublayer(fillLayer, at: 0)
        layerView.layer.insertSublayer(maskLayer, above: fillLayer)

        self.view.addSubview(imageView)
        self.view.addSubview(layerView)
        self.view.bringSubviewToFront(self.reCaptureView)
        self.view.bringSubviewToFront(self.confirmButton)
        self.view.bringSubviewToFront(self.timerLabel)
        self.view.bringSubviewToFront(self.descriptionLabel)
        self.view.bringSubviewToFront(self.confirmLabel)
    }
}
