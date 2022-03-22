//
//  VideoRecord.swift
//  VegaFintech
//
//  Created by tran dinh thong on 6/13/21.
//  Copyright © 2021 Vega. All rights reserved.
//

import UIKit

import AVFoundation

class VideoRecordViewController: BaseViewControllers, AVCaptureFileOutputRecordingDelegate {

    @IBOutlet weak var camPreview: UIView!
    
    init() {
        super.init(nibName: "VideoRecordViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    let cameraButton = UIView()

    let captureSession = AVCaptureSession()

    let movieOutput = AVCaptureMovieFileOutput()

    var previewLayer: AVCaptureVideoPreviewLayer!

    var activeInput: AVCaptureDeviceInput!

    var outputURL: URL!

    override func viewDidLoad() {
        super.viewDidLoad()
    
        if setupSession() {
            setupPreview()
            startSession()
        }
    
        cameraButton.isUserInteractionEnabled = true
    
        let cameraButtonRecognizer = UITapGestureRecognizer(target: self, action: #selector(VideoRecordViewController.startCapture))
    
        cameraButton.addGestureRecognizer(cameraButtonRecognizer)
    
        cameraButton.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
    
        cameraButton.backgroundColor = UIColor.red
    
        camPreview.addSubview(cameraButton)
    
    }

    func setupPreview() {
        // Configure previewLayer
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = camPreview.bounds
        previewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        camPreview.layer.addSublayer(previewLayer)
    }

    //MARK:- Setup Camera

    func setupSession() -> Bool {
    
        captureSession.sessionPreset = AVCaptureSession.Preset.high
    
        // Setup Camera
        let camera = AVCaptureDevice.default(for: AVMediaType.video)!
    
        do {
        
            let input = try AVCaptureDeviceInput(device: camera)
        
            if captureSession.canAddInput(input) {
                captureSession.addInput(input)
                activeInput = input
            }
        } catch {
            print("Error setting device video input: \(error)")
            return false
        }
    
        // Setup Microphone
        let microphone = AVCaptureDevice.default(for: AVMediaType.audio)!
    
        do {
            let micInput = try AVCaptureDeviceInput(device: microphone)
            if captureSession.canAddInput(micInput) {
                captureSession.addInput(micInput)
            }
        } catch {
            print("Error setting device audio input: \(error)")
            return false
        }
    
    
        // Movie output
        if captureSession.canAddOutput(movieOutput) {
            captureSession.addOutput(movieOutput)
        }
    
        return true
    }

    func setupCaptureMode(_ mode: Int) {
        // Video Mode
    
    }

    //MARK:- Camera Session
    func startSession() {
    
        if !captureSession.isRunning {
            videoQueue().async {
                self.captureSession.startRunning()
            }
        }
    }

    func stopSession() {
        if captureSession.isRunning {
            videoQueue().async {
                self.captureSession.stopRunning()
            }
        }
    }

    func videoQueue() -> DispatchQueue {
        return DispatchQueue.main
    }

    func currentVideoOrientation() -> AVCaptureVideoOrientation {
        var orientation: AVCaptureVideoOrientation
    
        switch UIDevice.current.orientation {
            case .portrait:
                orientation = AVCaptureVideoOrientation.portrait
            case .landscapeRight:
                orientation = AVCaptureVideoOrientation.landscapeLeft
            case .portraitUpsideDown:
                orientation = AVCaptureVideoOrientation.portraitUpsideDown
            default:
                 orientation = AVCaptureVideoOrientation.landscapeRight
         }
    
         return orientation
     }

    @objc func startCapture() {
    
        startRecording()
    
    }
    
    @IBAction func btnStart(_ sender: UIButton) {
        startRecording()
    }
    
    @IBAction func btnStop(_ sender: UIButton) {
        stopRecording()
    }


    //EDIT 1: I FORGOT THIS AT FIRST

    func tempURL() -> URL? {
        let directory = NSTemporaryDirectory() as NSString
    
        if directory != "" {
            let path = directory.appendingPathComponent(NSUUID().uuidString + ".mp4")
            return URL(fileURLWithPath: path)
        }
    
        return nil
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
        //let vc = segue.destination as! VideoPlaybackViewController
    
        //vc.videoURL = sender as? URL
    
    }

    func startRecording() {
        
        if movieOutput.isRecording == false {
            
            let connection = movieOutput.connection(with: AVMediaType.video)
            
            if (connection?.isVideoOrientationSupported)! {
                connection?.videoOrientation = currentVideoOrientation()
            }
            
            if (connection?.isVideoStabilizationSupported)! {
                connection?.preferredVideoStabilizationMode = AVCaptureVideoStabilizationMode.auto
            }
            
            let device = activeInput.device
            
            if (device.isSmoothAutoFocusSupported) {
                
                do {
                    try device.lockForConfiguration()
                    device.isSmoothAutoFocusEnabled = false
                    device.unlockForConfiguration()
                } catch {
                    print("Error setting configuration: \(error)")
                }
                
            }
            
            //EDIT2: And I forgot this
            outputURL = tempURL()
            movieOutput.startRecording(to: outputURL, recordingDelegate: self)
            
        }
        else {
            stopRecording()
        }
        
    }

   func stopRecording() {
    
       if movieOutput.isRecording == true {
           movieOutput.stopRecording()
        }
   }

    func capture(_ captureOutput: AVCaptureFileOutput!, didStartRecordingToOutputFileAt fileURL: URL!, fromConnections connections: [Any]!) {
    
        print("start record ------------")
    }

    func fileOutput(_ output: AVCaptureFileOutput, didFinishRecordingTo outputFileURL: URL, from connections: [AVCaptureConnection], error: Error?) {
    
        if (error != nil) {
        
            print("Error recording movie: \(error!.localizedDescription)")
        
        } else {
        
            let videoRecorded = outputURL! as URL
            print("co video ------------")
            //performSegue(withIdentifier: "showVideo", sender: videoRecorded)
            let vc = VideoPlayback()
            vc.videoURL = videoRecorded
            pushToViewController(vc, true)
        
        }
    
    }

}



class VideoPlayback: BaseViewControllers {

    let avPlayer = AVPlayer()
    var avPlayerLayer: AVPlayerLayer!

    var videoURL: URL!
    //connect this to your uiview in storyboard
    //@IBOutlet weak var videoView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        let videoView = UIView(frame: CGRect(x: 16, y: 96, width: 356, height: 367))
        videoView.backgroundColor = .green
        addSubViews([videoView])
        //playVideoInView(videoView: videoView, videoURL: videoURL)
        avPlayerLayer = AVPlayerLayer(player: avPlayer)
        avPlayerLayer.frame = view.bounds
        avPlayerLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        videoView.layer.insertSublayer(avPlayerLayer, at: 0)

        view.layoutIfNeeded()

        let playerItem = AVPlayerItem(url: videoURL as URL)
        avPlayer.replaceCurrentItem(with: playerItem)

        avPlayer.play()
    }
    
    
}

//extension BaseViewControllers {
//    var avPlayer: AVPlayer {
//        get{
//            return AVPlayer()
//        }
//    }
//    //let avPlayer = AVPlayer()
//    var avPlayerLayer: AVPlayerLayer {
//        get{
//            return AVPlayerLayer(player: avPlayer)
//        }
//    }
//    func playVideoInView(videoView: UIView, videoURL: URL){
//        avPlayerLayer.frame = view.bounds
//        avPlayerLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
//        videoView.layer.insertSublayer(avPlayerLayer, at: 0)
//        view.layoutIfNeeded()
//        let playerItem = AVPlayerItem(url: videoURL as URL)
//        avPlayer.replaceCurrentItem(with: playerItem)
//        avPlayer.play()
//    }
//}


