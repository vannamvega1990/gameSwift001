//
//  BaseVideo.swift
//  VegaFintech
//
//  Created by Tu Dao on 6/14/21.
//  Copyright © 2021 Vega. All rights reserved.
//

import Foundation
import UIKit
import Photos
import AVKit

struct BaseVideoNotificationKey {
    static let MAKE_VIDEO_FROM_IMAGE_ARRAY_COMPLITE: String                      = "MAKE_VIDEO_FROM_IMAGE_ARRAY_COMPLITE"
    static let MIX_VIDEOS_AUDIO_COMPLITE: String                      = "MIX_VIDEOS_AUDIO_COMPLITE"
}

class BaseVideo{
    
    static let singleton = BaseVideo()
    
    let outputSize = CGSize(width: 1280, height: 720)//CGSize(width: 1920, height: 1280) //1280 × 720
    let imagesPerSecond: TimeInterval = 3 //each image will be stay for 3 secs
    var selectedPhotosArray = [UIImage]()
    var imageArrayToVideoURL = NSURL()
    let audioIsEnabled: Bool = false //if your video has no sound
    var asset: AVAsset!
    
    // getImageFromVideo --------------
    func getImageFromVideo(vidURL: URL, positionTime:Double=0, completion: @escaping(UIImage?) -> ()){
        DispatchQueue.global(qos: .background).async {
            //let vidURL = NSURL(fileURLWithPath:filePath)
            let asset = AVURLAsset(url: vidURL as URL)
            let generator = AVAssetImageGenerator(asset: asset)
            generator.appliesPreferredTrackTransform = true
            
            //let duration = getDurationUrlVideo(asset:asset)
            //let radom = currentVC.createRandomDouble(from: 0, to: duration)
            //let timestamp = CMTime(seconds: 2, preferredTimescale: 60)
            let timestamp = CMTime(seconds: positionTime, preferredTimescale: 60)
            
            do {
                
                DispatchQueue.global(qos: .background).async {
                    
                }
                
                let imageRef = try generator.copyCGImage(at: timestamp, actualTime: nil)
                let img = UIImage(cgImage: imageRef)
                completion(img)
            }
            catch let error as NSError
            {
                print("Image generation failed with error \(error)")
                completion(nil)
            }
        }
    }
    
    // get duration of video online -----------
    func getDurationUrlVideo(asset:AVURLAsset) -> Double{
        let durationInSeconds = asset.duration.seconds
        print(durationInSeconds)
        return durationInSeconds
    }
    
    // get duration of video online -----------
    func getDurationAudio(asset:AVAsset) -> Double{
        let durationInSeconds = asset.duration.seconds
        print(durationInSeconds)
        return durationInSeconds
    }
    
    // make array images from video -----------
    func makeImageArrayFromVideo(url: URL, numberImages: Int = 1, completion: @escaping([UIImage]) -> () ){
        let dispatchGroup = DispatchGroup()
        let queue1 = DispatchQueue(label: "com.gcd.myQueue", attributes: .concurrent)
        let semaphore = DispatchSemaphore(value: 1)
        
        let queue2 = DispatchQueue.global()
        //let queue = DispatchQueue(label: "que", qos: .background, attributes: .concurrent, autoreleaseFrequency: .workItem, target: nil)
        let queue = DispatchQueue(label: "que", qos: .background)
        
        var oldRandom: Double = 8
        for _ in 0...numberImages-1 {
            queue.async(group: dispatchGroup, qos: .userInitiated) {
                semaphore.wait()
                
                let asset = AVURLAsset(url: url)
                let duration = self.getDurationUrlVideo(asset:asset)
                
                var radom = currentVC.createRandomDouble(from: 0, to: duration)
//                while(abs(radom - oldRandom) <= 16){
//                    radom = currentVC.createRandomDouble(from: 0, to: duration)
//                }
                
                radom = oldRandom + 11
                oldRandom = radom
                self.getImageFromVideo(vidURL: url as URL, positionTime:radom ) { (img:UIImage?) in
                    if let img = img {
                        self.selectedPhotosArray.append(img)
                        
                        DispatchQueue.main.async {
                            //currentVC.testImage(img: img)
                        }
                        
                    }
                }
                sleep(1)
                semaphore.signal()
            }
            
        }
        dispatchGroup.notify(queue: .main) {
            //print(self.images.count)
            //self.imageScrollView.display(image: self.images[self.index]!)
            completion(self.selectedPhotosArray)
            self.selectedPhotosArray.removeAll()
        }
        
    }

    var tempPhotosArray = [UIImage]()
    var count: Int = 0
    func makeImageArrayFromArrayVideos(urls: [URL], numberImages: Int = 1, completion: @escaping([UIImage]) -> () ){
        
        let numberImageForEachVideo = (numberImages / urls.count) + 1
        for i in 0...urls.count-1 {
            
                
                self.makeImageArrayFromVideo(url: urls[i], numberImages: numberImageForEachVideo) { (imgs: [UIImage]) in
                    print(imgs.count)
                    self.tempPhotosArray.append(contentsOf: imgs)
                    self.count += 1
                    if self.count >= urls.count {
                        completion(self.tempPhotosArray)
                    }
                }
        
                
            }
            
        
        
            
        
        
    }

}


extension UIViewController {
    // play video 1 ------------------------
    func playVideoType1(linkURL: URL) {
        //let videoURL = URL(string:"https://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4")
        let videoURL = linkURL  //URL(string:link)
        let player = AVPlayer(url: videoURL)
        DispatchQueue.main.async {
            let playerViewController = AVPlayerViewController()
            playerViewController.player = player
            self.present(playerViewController, animated: true) {
                playerViewController.player!.play()
            }
        }
    }
    // play video 2 ------------------------
    func playvideoType2(tempurl: String){
        let videoview = UIView()
        videoview.frame = bounds.resizeAtCenter(offsetX: 16, offsetY: 16)
        addSubViews([videoview])
        let u:String=tempurl
        let player = AVPlayer(url: URL(fileURLWithPath: u))
        let playerController = AVPlayerViewController()
        playerController.player = player
        self.addChild(playerController)
        videoview.addSubview(playerController.view)
        playerController.view.frame.size=(videoview.frame.size)
        playerController.view.contentMode = .scaleAspectFit
        playerController.view.backgroundColor=UIColor.clear
        videoview.backgroundColor=UIColor.clear
        player.play()
    }
    
    // play video 2 ------------------------
    func playvideoType3(video_url: URL){
        let vc = VideoPlaybackViewController()
        vc.videoURL = video_url//URL(fileURLWithPath: video_url)
        presentViewController(vc, transitionStyle: .flipHorizontal, modalPresentationStyle: .formSheet)
        
    }
    
    // Url To Path ------------------
    func urlToPath(url: URL) -> String {
        return url.path
    }
    
    // Path To Url ------------------
    func pathToUrl(path: String) -> URL {
        return URL(fileURLWithPath: path)
    }
    // getPathOfLocalFile ------------
    func getPathOfLocalFile(nameFile: String , ofType: String) -> String?{
        return Bundle.main.path(forResource: nameFile, ofType: ofType)
    }
    
    // getUrlOfLocalFile ------------
    func getUrlOfLocalFile(nameFile1: String , ofType1: String) -> URL?{
        if let path = getPathOfLocalFile(nameFile: nameFile1, ofType: ofType1){
            let url123 = NSURL(fileURLWithPath: path)
            return url123 as URL
        }
        return nil
    }
    
    // save video to photos --------------------
    func saveVideoToPhotos2(videoPath: String, url: URL? = nil, selector: Selector?){
        //UISaveVideoAtPathToSavedPhotosAlbum(url.path, self, #selector(video(_:didFinishSavingWithError:contextInfo:)), nil)
        var path = videoPath
        if let url = url {
            path = url.path
        }
        UISaveVideoAtPathToSavedPhotosAlbum(path, self, selector, nil)
    }
    
    // save video to photos --------------------
    func saveVideoToPhotos(urlToYourVideo:String, url:URL? = nil){
        PHPhotoLibrary.requestAuthorization { status in
            guard status == .authorized else {
                self.showSimpleAlert(title: "thong bao", ms: "chua co quyen truy cap photo")
                return
            }
            PHPhotoLibrary.shared().performChanges({
                if let url = url {
                    PHAssetChangeRequest.creationRequestForAssetFromVideo(atFileURL: url)
                }else{
                    PHAssetChangeRequest.creationRequestForAssetFromVideo(atFileURL: URL(fileURLWithPath: urlToYourVideo) as URL)
                }
                
            }) { saved, error in
                if saved {
                    let alertController = UIAlertController(title: "Your video was successfully saved", message: nil, preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alertController.addAction(defaultAction)
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
    //------------------------------
    func savedPhotosAvailable() -> Bool {
      guard !UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum) else { return true }
      
      let alert = UIAlertController(title: "Not Available", message: "No Saved Album found", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil))
      present(alert, animated: true, completion: nil)
      return false
    }
    
    
    
}
