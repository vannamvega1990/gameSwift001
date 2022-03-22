////
////  DownloadFilesViewController.swift
////  VegaFintech
////
////  Created by Tu Dao on 6/16/21.
////  Copyright © 2021 Vega. All rights reserved.
////
//
//import UIKit
//
//enum StateDownload {
//    case none
//    case downloading
//    case finish
//}
//
//class DownloadFilesViewController: UIViewController {
//    
//   
//    var stateDownload: StateDownload = .none
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//       
//        
//        
//    }
//    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        
//    }
//    
//    // MARK: btn download pressed ==================
//    
//    @IBAction func btnDownloadPressed(_ sender: UIButton) {
//      
//        if stateDownload != .downloading {
//            if let linkFile = self.textview.text, let url = URL(string: linkFile){
//                let configuration = URLSessionConfiguration.background(withIdentifier: "backgroundSession")
//                session = URLSession(configuration: configuration, delegate: self, delegateQueue: OperationQueue.main)
//                
//                self.stackViewStateLabel.isHidden = true
//                self.formatFile = url.pathExtension
//                self.fileName = url.lastPathComponent
//                
//                print(url.pathExtension)
//                print(url.lastPathComponent)
//                downloadTask = session?.downloadTask(with: url)
//                downloadTask!.resume()
//                
//                stateDownload = .downloading
//                self.stateDownloadLabel.text = "State: Downloading..."
//                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//                    self.btnDownload.setTitle("Stop", for: .normal)
//                    self.btnDownload.backgroundColor = .red
//                }
//            }
//        }
//        else if stateDownload == .downloading {
//            session?.finishTasksAndInvalidate()
//            downloadTask?.cancel(byProducingResumeData: { (data) in
//                self.stateDownload = .none
//                self.stateDownloadLabel.text = "State: Cancel"
//                self.btnDownload.setTitle("Download", for: .normal)
//                self.btnDownload.backgroundColor = UIColor(rgb: 0x009051)
//            })
//            
//        }
//        
//    }
//    
//    // MARK: add circle progress ======================
//    
//    private func showProgress(percent: Float){
//        progressLayer.strokeEnd = CGFloat((percent * 1.0) / 100)
//    }
//    
//    fileprivate func drawCircle() {
//        let circlePath = UIBezierPath(arcCenter: self.view.center, radius: CGFloat(60), startAngle: CGFloat(0), endAngle:CGFloat(Double.pi * 2), clockwise: true)
//        
//        let circlePath001 = UIBezierPath(arcCenter: self.view.center, radius: CGFloat(60), startAngle: CGFloat(-Double.pi/2), endAngle:CGFloat((Double.pi * 3) / 2), clockwise: true)
//        
//        let shapeLayer = CAShapeLayer()
//        shapeLayer.path = circlePath.cgPath
//        
//        //change the fill color
//        shapeLayer.fillColor = UIColor.clear.cgColor
//        //you can change the stroke color
//        shapeLayer.strokeColor = UIColor.lightGray.cgColor
//        //you can change the line width
//        shapeLayer.lineWidth = 6.0
//        
//        view.layer.addSublayer(shapeLayer)
//        
//        progressLayer.path = circlePath001.cgPath
//        progressLayer.fillColor = UIColor.clear.cgColor
//        progressLayer.lineCap = .round
//        progressLayer.lineWidth = 6
//        progressLayer.strokeEnd = 0
//        progressLayer.strokeColor = UIColor(rgb: 0x009051).cgColor
//        view.layer.addSublayer(progressLayer)
//        
//    }
//    
//    // MARK: animation circle progress =========================
//    
//    private func animateCircularProgress(duration: TimeInterval) {
//        let circularProgressAnimation = CABasicAnimation(keyPath: "strokeEnd")
//        circularProgressAnimation.duration = duration
//        circularProgressAnimation.toValue = 1
//        circularProgressAnimation.fillMode = .forwards
//        circularProgressAnimation.isRemovedOnCompletion = false
//        progressLayer.add(circularProgressAnimation, forKey: "progressAnim")
//    }
//    
//    // MARK: xu ly textfild khi nhap link ===================
//    
//    func textViewDidBeginEditing(_ textView: UITextView){
//        if textview.text == "Enter your link here ..." {
//            textview.textColor = UIColor.black
//            textview.text=""
//        }
//        
//    }
//    
//    func textViewDidEndEditing(_ textView: UITextView){
//        if textview.text==""{
//            textView.textColor = UIColor.lightGray
//            textView.text="Enter your link here ..."
//        }
//    }
//    
//    // MARK: show alert with textfild =======================
//    
//}
