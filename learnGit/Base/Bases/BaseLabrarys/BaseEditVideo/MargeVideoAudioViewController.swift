//
//  MargeVideoAudioViewController.swift
//  VegaFintech
//
//  Created by Tu Dao on 6/16/21.
//  Copyright © 2021 Vega. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit
import AssetsLibrary

class MargeVideoAudioViewController: BaseViewControllers {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .orange

        //let videoUrl : URL =  URL(fileURLWithPath: Bundle.main.path(forResource: "sample_video_2", ofType: "mp4")!)
        //let audioUrl : URL = URL(fileURLWithPath: Bundle.main.path(forResource: "sample_audio_1", ofType: "mp3")!)
        
        let videoYoutube = "https://r5---sn-npoeenle.googlevideo.com/videoplayback?expire=1623914017&ei=waHKYIC-JKexs8IPlN-omAk&ip=103.138.88.45&id=o-AHzY1TUAvEMGbrC7PKe3yz_nG4qUm9trh84Gl3KLr4vG&itag=299&aitags=133,134,135,136,160,242,243,244,247,278,298,299,302,303,308&source=youtube&requiressl=yes&vprv=1&mime=video/mp4&ns=CLJyVCSuZbpuDGqVgQywJjgF&gir=yes&clen=7063622&dur=199.139&lmt=1595726888954232&keepalive=yes&fexp=9466586,24001373,24007246&beids=9466586&c=WEB&txp=6216222&n=9hGAhDARHzLs9A7RR&sparams=expire,ei,ip,id,aitags,source,requiressl,vprv,mime,ns,gir,clen,dur,lmt&sig=AOq0QJ8wRAIgeEqOn9ASdhITa4PY2-oILFS0MIPLNczmiD9O3p1HarcCIDA7ZF-BKMv1jKDSGP111XwXzIuVSIjLXXqsJNTXkY8V&rm=sn-8qj-nbol776,sn-npose7z&req_id=f242bf1dc950a3ee&redirect_counter=2&cms_redirect=yes&ipbypass=yes&mh=Ve&mip=123.24.205.169&mm=30&mn=sn-npoeenle&ms=nxu&mt=1623888814&mv=u&mvi=5&pl=25&lsparams=ipbypass,mh,mip,mm,mn,ms,mv,mvi,pl&lsig=AG3C_xAwRAIgb80A-mIxG5xr7BRXKeT2kAH_HDbMCIXeqz2KTrHrIeECIH0hTsikgN8q0BBVdTiUdHKiCzEWY4JSNkTND0-CteZM"
        
        var videoUrl : NSURL =  NSURL(fileURLWithPath: Bundle.main.path(forResource: "sample_video_2", ofType: "mp4")!)
        let audioUrl : NSURL = NSURL(fileURLWithPath: Bundle.main.path(forResource: "sample_audio_1", ofType: "mp3")!)
        
        let url =   URL(string: videoYoutube)!
        videoUrl = url as NSURL

        // video in local -----------
        //BaseEditVideo.singleton.mergeFilesWithUrl(videoUrl: videoUrl, audioUrl: audioUrl)
        
        
        // video in online -----------
//        BaseEditVideo.singleton.mergeVideoAndAudio(videoUrl: videoUrl as URL, audioUrl: audioUrl as URL) { (e:Error?, url:URL?) in
//            print(e.debugDescription)
//            print(url)
//            self.playVideoType1(linkURL: url!)
//        }
        
        
        
        
        
        
        
    }
    

    

}


extension BaseEditVideo {
    func mergeFilesWithUrl(videoUrl:NSURL, audioUrl:NSURL)
    {
        let mixComposition : AVMutableComposition = AVMutableComposition()
        var mutableCompositionVideoTrack : [AVMutableCompositionTrack] = []
        var mutableCompositionAudioTrack : [AVMutableCompositionTrack] = []
        let totalVideoCompositionInstruction : AVMutableVideoCompositionInstruction = AVMutableVideoCompositionInstruction()
        //start merge
        
        let aVideoAsset : AVAsset = AVAsset(url: videoUrl as URL)
        let aAudioAsset : AVAsset = AVAsset(url: audioUrl as URL)
        
        mutableCompositionVideoTrack.append(mixComposition.addMutableTrack(withMediaType: AVMediaType.video, preferredTrackID: kCMPersistentTrackID_Invalid)!)
        mutableCompositionAudioTrack.append( mixComposition.addMutableTrack(withMediaType: AVMediaType.audio, preferredTrackID: kCMPersistentTrackID_Invalid)!)
        
        let aVideoAssetTrack : AVAssetTrack = aVideoAsset.tracks(withMediaType: AVMediaType.video)[0]
        let aAudioAssetTrack : AVAssetTrack = aAudioAsset.tracks(withMediaType: AVMediaType.audio)[0]
        
        
        
        do{
            try mutableCompositionVideoTrack[0].insertTimeRange(CMTimeRangeMake(start: CMTime.zero, duration: aVideoAssetTrack.timeRange.duration), of: aVideoAssetTrack, at: CMTime.zero)
            
            //In my case my audio file is longer then video file so i took videoAsset duration
            //instead of audioAsset duration
            
            try mutableCompositionAudioTrack[0].insertTimeRange(CMTimeRangeMake(start: CMTime.zero, duration: aVideoAssetTrack.timeRange.duration), of: aAudioAssetTrack, at: CMTime.zero)
            
            //Use this instead above line if your audiofile and video file's playing durations are same
            
            //            try mutableCompositionAudioTrack[0].insertTimeRange(CMTimeRangeMake(kCMTimeZero, aVideoAssetTrack.timeRange.duration), ofTrack: aAudioAssetTrack, atTime: kCMTimeZero)
            
        }catch{
            
        }
        
        totalVideoCompositionInstruction.timeRange = CMTimeRangeMake(start: CMTime.zero,duration: aVideoAssetTrack.timeRange.duration )
        
        let mutableVideoComposition : AVMutableVideoComposition = AVMutableVideoComposition()
        mutableVideoComposition.frameDuration = CMTimeMake(value: 1, timescale: 30)
        
        mutableVideoComposition.renderSize = CGSizeMake(1280,720)
        
        //        playerItem = AVPlayerItem(asset: mixComposition)
        //        player = AVPlayer(playerItem: playerItem!)
        //
        //
        //        AVPlayerVC.player = player
        
        
        
        //find your video on this URl
        let savePathUrl : NSURL = NSURL(fileURLWithPath: NSHomeDirectory() + "/Documents/newVideo.mp4")
        
        let assetExport: AVAssetExportSession = AVAssetExportSession(asset: mixComposition, presetName: AVAssetExportPresetHighestQuality)!
        assetExport.outputFileType = AVFileType.mp4
        assetExport.outputURL = savePathUrl as URL
        assetExport.shouldOptimizeForNetworkUse = true
        
        assetExport.exportAsynchronously { () -> Void in
            switch assetExport.status {
                
            case AVAssetExportSession.Status.completed:
                
                //Uncomment this if u want to store your video in asset
                currentVC.playVideoType1(linkURL: savePathUrl as URL)
                let assetsLib = ALAssetsLibrary()
                assetsLib.writeVideoAtPath(toSavedPhotosAlbum: savePathUrl as URL, completionBlock: nil)
                
                print("success")
            case  AVAssetExportSession.Status.failed:
                print("failed \(assetExport.error)")
            case AVAssetExportSession.Status.cancelled:
                print("cancelled \(assetExport.error)")
            default:
                print("complete")
                
            }
        }
        
        
    }
    
    
    /// Merges video and sound while keeping sound of the video too
    ///
    /// - Parameters:
    ///   - videoUrl: URL to video file
    ///   - audioUrl: URL to audio file
    ///   - shouldFlipHorizontally: pass True if video was recorded using frontal camera otherwise pass False
    ///   - completion: completion of saving: error or url with final video
    func mergeVideoAndAudio(videoUrl: URL,
                            audioUrl: URL,
                            shouldFlipHorizontally: Bool = false,
                            completion: @escaping (_ error: Error?, _ url: URL?) -> Void) {

        let mixComposition = AVMutableComposition()
        var mutableCompositionVideoTrack = [AVMutableCompositionTrack]()
        var mutableCompositionAudioTrack = [AVMutableCompositionTrack]()
        var mutableCompositionAudioOfVideoTrack = [AVMutableCompositionTrack]()

        //start merge

        let aVideoAsset = AVAsset(url: videoUrl)
        let aAudioAsset = AVAsset(url: audioUrl)

        let compositionAddVideo = mixComposition.addMutableTrack(withMediaType: AVMediaType.video,
                                                                       preferredTrackID: kCMPersistentTrackID_Invalid)

        let compositionAddAudio = mixComposition.addMutableTrack(withMediaType: AVMediaType.audio,
                                                                     preferredTrackID: kCMPersistentTrackID_Invalid)

        let compositionAddAudioOfVideo = mixComposition.addMutableTrack(withMediaType: AVMediaType.audio,
                                                                            preferredTrackID: kCMPersistentTrackID_Invalid)

        let aVideoAssetTrack: AVAssetTrack = aVideoAsset.tracks(withMediaType: AVMediaType.video)[0]
        let aAudioOfVideoAssetTrack: AVAssetTrack? = aVideoAsset.tracks(withMediaType: AVMediaType.audio).first
        let aAudioAssetTrack: AVAssetTrack = aAudioAsset.tracks(withMediaType: AVMediaType.audio)[0]

        // Default must have tranformation
        compositionAddVideo?.preferredTransform = aVideoAssetTrack.preferredTransform

        if shouldFlipHorizontally {
            // Flip video horizontally
            var frontalTransform: CGAffineTransform = CGAffineTransform(scaleX: -1.0, y: 1.0)
            frontalTransform = frontalTransform.translatedBy(x: -aVideoAssetTrack.naturalSize.width, y: 0.0)
            frontalTransform = frontalTransform.translatedBy(x: 0.0, y: -aVideoAssetTrack.naturalSize.width)
            compositionAddVideo?.preferredTransform = frontalTransform
        }

        mutableCompositionVideoTrack.append(compositionAddVideo!)
        mutableCompositionAudioTrack.append(compositionAddAudio!)
        mutableCompositionAudioOfVideoTrack.append(compositionAddAudioOfVideo!)

        do {
            try mutableCompositionVideoTrack[0].insertTimeRange(CMTimeRangeMake(start: CMTime.zero,
                                                                                duration: aVideoAssetTrack.timeRange.duration),
                                                                of: aVideoAssetTrack,
                                                                at: CMTime.zero)

            //In my case my audio file is longer then video file so i took videoAsset duration
            //instead of audioAsset duration
            try mutableCompositionAudioTrack[0].insertTimeRange(CMTimeRangeMake(start: CMTime.zero,
                                                                                duration: aVideoAssetTrack.timeRange.duration),
                                                                of: aAudioAssetTrack,
                                                                at: CMTime.zero)

            // adding audio (of the video if exists) asset to the final composition
            if let aAudioOfVideoAssetTrack = aAudioOfVideoAssetTrack {
                try mutableCompositionAudioOfVideoTrack[0].insertTimeRange(CMTimeRangeMake(start: CMTime.zero,
                                                                                           duration: aVideoAssetTrack.timeRange.duration),
                                                                           of: aAudioOfVideoAssetTrack,
                                                                           at: CMTime.zero)
            }
        } catch {
            print(error.localizedDescription)
        }

        // Exporting
        let savePathUrl: URL = URL(fileURLWithPath: NSHomeDirectory() + "/Documents/newVideo.mp4")
        do { // delete old video
            try FileManager.default.removeItem(at: savePathUrl)
        } catch { print(error.localizedDescription) }

        let assetExport: AVAssetExportSession = AVAssetExportSession(asset: mixComposition, presetName: AVAssetExportPresetHighestQuality)!
        assetExport.outputFileType = AVFileType.mp4
        assetExport.outputURL = savePathUrl
        assetExport.shouldOptimizeForNetworkUse = true

        assetExport.exportAsynchronously { () -> Void in
            switch assetExport.status {
            case AVAssetExportSession.Status.completed:
                print("success")
                completion(nil, savePathUrl)
            case AVAssetExportSession.Status.failed:
                print("failed \(assetExport.error?.localizedDescription ?? "error nil")")
                completion(assetExport.error, nil)
            case AVAssetExportSession.Status.cancelled:
                print("cancelled \(assetExport.error?.localizedDescription ?? "error nil")")
                completion(assetExport.error, nil)
            default:
                print("complete")
                completion(assetExport.error, nil)
            }
        }

    }
}


extension BaseEditVideo {
    func CGSizeMake(_ w: CGFloat,_ h: CGFloat) -> CGSize {
        return CGSize(width: w, height: h)
    }
}
