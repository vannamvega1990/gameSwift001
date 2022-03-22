//
//  BuildVideoViewController.swift
//  VegaFintech
//
//  Created by Tu Dao on 6/17/21.
//  Copyright © 2021 Vega. All rights reserved.
//

import Foundation
import UIKit
import Photos
import AVKit

class BuildVideoViewController: BaseViewControllers {

    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var statelabel: UILabel!
    
    let baseVideo = BaseVideo.singleton
    
    var imgArray = [UIImage]()
    
    let videoYoutube = "https://r2---sn-i3belnel.googlevideo.com/videoplayback?expire=1623946405&ei=RSDLYNmLG46RgAP1sILQDw&ip=103.138.88.45&id=o-AGmKNnLs-886h66z9F8jluTSGHwfKOK3WDmz5nqKf6qN&itag=135&aitags=133,134,135,136,137,160,242,243,244,247,248,278,394,395,396,397,398,399&source=youtube&requiressl=yes&vprv=1&mime=video/mp4&ns=9Wvx_tCOo1MpTofiAQIByTEF&gir=yes&clen=75058433&dur=2842.166&lmt=1623815467033046&keepalive=yes&fexp=24001373,24007246&c=WEB&txp=5535432&n=xOHZkSmN3s7NJLPgu&sparams=expire,ei,ip,id,aitags,source,requiressl,vprv,mime,ns,gir,clen,dur,lmt&sig=AOq0QJ8wRgIhANXGg1Bor7XzCIqA80z2I3KR00buXNPfSIwMGqMqFDksAiEA9T19DluiVdv7KPdAznOT1SLPKtQ7SfbBz1vQA4tx4tY=&rm=sn-8qj-nboes7k,sn-npozr7l&req_id=d922acd4258ba3ee&redirect_counter=2&cms_redirect=yes&ipbypass=yes&mh=aT&mip=118.70.190.112&mm=30&mn=sn-i3belnel&ms=nxu&mt=1623924520&mv=m&mvi=2&pl=24&lsparams=ipbypass,mh,mip,mm,mn,ms,mv,mvi,pl&lsig=AG3C_xAwRQIhANU4EW7BfLNuue3Xp30uGm9jvcC2nFWpjbyVdg7gUpRDAiBIA539G7Nx6JQybvVfelzzEtwNxnNZE70bmE7wXGvE-Q%3D%3D"
    
   let videoYoutube1 = "https://r2---sn-npoeeney.googlevideo.com/videoplayback?expire=1623942522&ei=GhHLYLuXMYXk4QKVvpGADg&ip=103.138.88.45&id=o-AE4UwaR1lsBZnvv_orzqkWwj2ix8VlSTVaJdoBL5wVPr&itag=135&aitags=133,134,135,136,137,160,242,243,244,247,248,278&source=youtube&requiressl=yes&vprv=1&mime=video/mp4&ns=LL-gEaYwV-LR4_9TfB7do0gF&gir=yes&clen=17386008&dur=488.133&lmt=1623884493980871&keepalive=yes&fexp=24001373,24007246&c=WEB&txp=5516222&n=kOLa2Xlu-Lq5k1F1S&sparams=expire,ei,ip,id,aitags,source,requiressl,vprv,mime,ns,gir,clen,dur,lmt&sig=AOq0QJ8wRgIhAMgXAOGHTRcegr64GIHhc1hggo0cD8x4hlb9hZV2fomfAiEA8zwsQBSjvBFmFMo1RI2DALQvMkeGpYah9dZU27eVvX8=&rm=sn-8qj-nboed7l,sn-nposy7l&req_id=f0809e6e1c69a3ee&redirect_counter=2&cms_redirect=yes&ipbypass=yes&mh=QI&mip=123.24.205.169&mm=30&mn=sn-npoeeney&ms=nxu&mt=1623920669&mv=m&mvi=2&pl=25&lsparams=ipbypass,mh,mip,mm,mn,ms,mv,mvi,pl&lsig=AG3C_xAwRgIhAO5S66V4xLqjaFZwiSK5jKTu6WUdV104mAZVRtiTWSx9AiEAof46zQcJoKGYAOwKhbQivYGGsstNmQYS4oWZx2AxggQ%3D"
    
    var count: Int = 0
    var firstAsset: AVAsset?
    var secondAsset: AVAsset?
    
    var finishSecondVideo: Bool = false {
        didSet {
            if finishSecondVideo {
                buildFirstVideo()
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        BaseCommons.regisReceverNotificationcenter(self, BaseVideoNotificationKey.MAKE_VIDEO_FROM_IMAGE_ARRAY_COMPLITE, nil, selector: #selector(handleNotification(_:)))
        BaseCommons.regisReceverNotificationcenter(self, BaseVideoNotificationKey.MIX_VIDEOS_AUDIO_COMPLITE, nil, selector: #selector(handleNotificationMixVideo(_:)))
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //self.indicator.startAnimating()
        let url =   URL(string: videoYoutube)!
        let url1 =   URL(string: videoYoutube1)!
        self.statelabel.text = "nothing"
        self.indicator.stopAnimating()
        //self.statelabel.text = "making images array..........."
        
        
       // buildSecondVideo()
        
//        baseVideo.makeImageArrayFromVideo(url: url, numberImages:2) { (imgArr:[UIImage]) in
//            print(imgArr.count)
//            self.statelabel.text = "making video from images ..........."
//            self.indicator.startAnimating()
//            self.baseVideo.buildVideoFromImageArray(imageArray: self.baseVideo.selectedPhotosArray)
//        }
        
        
   
    }
    
    let urlVideo1 = NSURL(fileURLWithPath: Bundle.main.path(forResource: "bongda1", ofType: "mp4")!)
    
    let urlVideo2 = NSURL(fileURLWithPath: Bundle.main.path(forResource: "bongda2", ofType: "mp4")!)
    let audioUrl1 = NSURL(fileURLWithPath: Bundle.main.path(forResource: "sample_audio_1", ofType: "mp3")!)
    let audioUrl = NSURL(fileURLWithPath: Bundle.main.path(forResource: "AudioTextToSpeech", ofType: "mp3")!)
    
    @IBAction func btnMakeVideoPressed(_ sender: UIButton) {
        
        self.indicator.startAnimating()
        self.statelabel.text = "making images array..........."
        
        let url =   URL(string: videoYoutube)!
        let url1 =   URL(string: videoYoutube1)!
        
        
        //let audioUrl = NSURL(fileURLWithPath: Bundle.main.path(forResource: "sample_audio_1", ofType: "mp3")!)
        var audioAsset: AVAsset?
        audioAsset = AVAsset(url: audioUrl as URL)
        let time = baseVideo.getDurationAudio(asset: audioAsset!)
        let numerImageNeed = Int(time / 3)
        
        baseVideo.makeImageArrayFromArrayVideos(urls: [(urlVideo1 as URL), (urlVideo2 as URL)], numberImages:numerImageNeed) { (imgs:[UIImage]) in
            print(imgs.count)
            self.imgArray = imgs.reArrang().reArrang()
            if self.imgArray.count >= 6 {
                self.statelabel.text = "making video from images array..........."
                self.buildSecondVideo()
            }else{
                self.showDialogJK("so luong anh nho hon 6")
                self.statelabel.text = "so luong anh nho hon 6"
                self.indicator.stopAnimating()
            }
            
        }
        
    }

    func buildFirstVideo(){
        
        
//        self.baseVideo.buildVideoFromImageArray(imageArray: self.imgArray, indexVideo: 1, completion: {
//            (aset:AVAsset) in
//            self.firstAsset = aset
//            self.baseVideo.mixVideoAndAudio(firstAsset: self.firstAsset, secondAsset: self.secondAsset)
//        })
        
        if #available(iOS 11.0, *) {
            BaseVideo().buildVideoFromImageArray5(imageArray: self.imgArray, indexVideo: 1) { (url:URL?) in
                if let url = url {
                    let aset = AVAsset(url: url)
                    self.firstAsset = aset
                    //currentVC.playVideoType1(linkURL: url)
                    //self.baseVideo.mixVideoAndAudio(firstAsset: self.firstAsset, secondAsset: self.firstAsset)
                    //let audioUrl = NSURL(fileURLWithPath: Bundle.main.path(forResource: "sample_audio_1", ofType: "mp3")!)
                    //BaseEditVideo.singleton.mergeFilesWithUrl(videoUrl: url as NSURL, audioUrl: audioUrl)
                    self.statelabel.text = "merging Video And Audio..........."
                    BaseEditVideo.singleton.mergeVideoAndAudio(videoUrl: url, audioUrl: self.audioUrl as URL) { (e, url) in
                        print(url)
                        guard let url = url else {
                            DispatchQueue.main.async {
                                self.statelabel.text = "merging Video And Audio......false"
                            }
                            return
                        }
                        //currentVC.playVideoType1(linkURL: url)
                        //self.saveVideoToPhotos(urlToYourVideo: "", url: url)
                        
                        DispatchQueue.main.async {
                            self.statelabel.text = "add boder, logo to video........."
                        }
                        
                        self.baseVideo.makeBirthdayCard(fromVideoAt: url, forName: "") { (url:URL?) in
                            self.statelabel.text = "add boder, logo to video.........false"
                            if let url = url {
                                self.saveVideoToPhotos(urlToYourVideo: "", url: url)
                                self.playVideoType1(linkURL: url)
                                DispatchQueue.main.async {
                                    self.statelabel.text = "saved video........."
                                }
                            }
                        }
                    }
                }
            }
        } else {
            // Fallback on earlier versions
        }
        
    }
    func buildSecondVideo(){
        
        self.finishSecondVideo = true
        
        
//        var imgDogs = [UIImage]()
//        for image in 0..<3 {
//            //baseVideo.selectedPhotosArray.append(UIImage(named: "dog-\(image).jpg")!)
//            //imgDogs.append(UIImage(named: "dog-\(image).jpg")!)
//            imgDogs.append(self.imgArray[image])
//        }
////        BaseVideo().buildVideoFromImageArray(imageArray: imgDogs, indexVideo: 2) { (aset:AVAsset) in
////            self.secondAsset = aset
////            self.finishSecondVideo = true
////        }
//
//        if #available(iOS 11.0, *) {
//            BaseVideo().buildVideoFromImageArray5(imageArray: imgDogs, indexVideo: 2) { (url:URL?) in
//                if let url = url {
//                    let aset = AVAsset(url: url)
//                    self.secondAsset = aset
//                    currentVC.playVideoType1(linkURL: url)
//                    //self.finishSecondVideo = true
//                }
//            }
//        } else {
//            // Fallback on earlier versions
//        }
    }
    
    @objc func handleNotification(_ notification: NSNotification) {
        DispatchQueue.main.async {
            self.indicator.stopAnimating()
            self.statelabel.text = "Done video from images"
        }
        if let urlVideo = notification.userInfo?["dataUser"] as? NSURL {
            print(urlVideo)
            DispatchQueue.main.async {
                self.indicator.stopAnimating()
                self.statelabel.text = "Done video from images"
            }            
            //self.playVideoType1(linkURL: urlVideo as URL)
            //baseVideo.buildVideoFromImageArrayWithAnimation()
            
            count += 1
            if count == 1 {
                //firstAsset = AVAsset(url: urlVideo as URL)
               //self.playVideoType1(linkURL: urlVideo as URL)
            }else if count == 2 {
                //secondAsset = AVAsset(url: urlVideo as URL)
            }
            if count == 2 {
                //baseVideo.mixVideoAndAudio(firstAsset: firstAsset, secondAsset: secondAsset)
            }
            
        }
    }
    
    @objc func handleNotificationMixVideo(_ notification: NSNotification) {
        
        if let urlVideo = notification.userInfo?["dataUser"] as? URL {
            print(urlVideo)
            
            self.saveVideoToPhotos(urlToYourVideo: "", url: urlVideo)
            self.playVideoType1(linkURL: urlVideo as URL)
            
//            baseVideo.makeBirthdayCard(fromVideoAt: urlVideo, forName: "nam123") { (url:URL?) in
//                if let url = url {
//                    self.saveVideoToPhotos(urlToYourVideo: "", url: url)
//                    self.playVideoType1(linkURL: url)
//                }
//            }
            
            
        }
    }


}
