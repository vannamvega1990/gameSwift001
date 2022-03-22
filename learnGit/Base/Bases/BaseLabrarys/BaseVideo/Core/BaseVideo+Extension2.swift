//
//  BaseVideo+Extension2.swift
//  VegaFintech
//
//  Created by Tu Dao on 6/17/21.
//  Copyright © 2021 Vega. All rights reserved.
//

import Foundation
import UIKit
import Photos
import AVKit

//var firstAsset: AVAsset?
//var secondAsset: AVAsset?
//var audioAsset: AVAsset?

extension BaseVideo {

    func mixVideoAndAudio(firstAsset: AVAsset?, secondAsset: AVAsset?){ //, audioAsset: AVAsset?
        guard let firstAsset = firstAsset, let secondAsset = secondAsset else { return }
        
        //activityMonitor.startAnimating()
        
        // 1 - Create AVMutableComposition object. This object will hold your AVMutableCompositionTrack instances.
        let mixComposition = AVMutableComposition()
        
        // 2 - Create two video tracks
        guard let firstTrack = mixComposition.addMutableTrack(withMediaType: .video,
                                                              preferredTrackID: Int32(kCMPersistentTrackID_Invalid)) else { return }
        do {
            try firstTrack.insertTimeRange(CMTimeRangeMake(start: CMTime.zero, duration: firstAsset.duration),
                                           of: firstAsset.tracks(withMediaType: .video)[0],
                                           at: CMTime.zero)
        } catch {
            print("Failed to load first track")
            return
        }
        
        guard let secondTrack = mixComposition.addMutableTrack(withMediaType: .video,
                                                               preferredTrackID: Int32(kCMPersistentTrackID_Invalid)) else { return }
        do {
            try secondTrack.insertTimeRange(CMTimeRangeMake(start: CMTime.zero, duration: secondAsset.duration),
                                            of: secondAsset.tracks(withMediaType: .video)[0],
                                            at: firstAsset.duration)
        } catch {
            print("Failed to load second track")
            return
        }
        
        // 2.1
        let mainInstruction = AVMutableVideoCompositionInstruction()
        mainInstruction.timeRange = CMTimeRangeMake(start: CMTime.zero, duration: CMTimeAdd(firstAsset.duration, secondAsset.duration))
        
        // 2.2
        let firstInstruction = VideoHelper.videoCompositionInstruction(firstTrack, asset: firstAsset)
        firstInstruction.setOpacity(0.0, at: firstAsset.duration)
        let secondInstruction = VideoHelper.videoCompositionInstruction(secondTrack, asset: secondAsset)
        
        // 2.3
        mainInstruction.layerInstructions = [firstInstruction, secondInstruction]
        let mainComposition = AVMutableVideoComposition()
        mainComposition.instructions = [mainInstruction]
        mainComposition.frameDuration = CMTimeMake(value: 1, timescale: 30)
        mainComposition.renderSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        
        // 3 - Audio track
        let url123 = NSURL(fileURLWithPath: Bundle.main.path(forResource: "sample_audio_1", ofType: "mp3")!)
        var audioAsset: AVAsset?
        audioAsset = AVAsset(url: url123 as URL)
        if let loadedAudioAsset = audioAsset {
            let audioTrack = mixComposition.addMutableTrack(withMediaType: .audio, preferredTrackID: 0)
            do {
                try audioTrack?.insertTimeRange(CMTimeRangeMake(start: CMTime.zero, duration: CMTimeAdd(firstAsset.duration, secondAsset.duration)),
                                                of: loadedAudioAsset.tracks(withMediaType: .audio)[0] ,
                                                at: CMTime.zero)
            } catch {
                print("Failed to load Audio track")
            }
        }
        
        // 4 - Get path
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .short
        let date = dateFormatter.string(from: Date())
        let url = documentDirectory.appendingPathComponent("mergeVideo-\(date).mp4")
        
        // 5 - Create Exporter
        guard let exporter = AVAssetExportSession(asset: mixComposition, presetName: AVAssetExportPresetHighestQuality) else { return }
        exporter.outputURL = url
        exporter.outputFileType = AVFileType.mp4
        exporter.shouldOptimizeForNetworkUse = true
        exporter.videoComposition = mainComposition
        
        // 6 - Perform the Export
        exporter.exportAsynchronously() {
            DispatchQueue.main.async {
                //self.exportDidFinish(exporter)
                
                guard exporter.status == AVAssetExportSession.Status.completed,
                let outputURL = exporter.outputURL else { return }
                
                print(outputURL)
                //currentVC.playVideoType1(linkURL: outputURL)
                self.asset = AVAsset(url: self.imageArrayToVideoURL as URL)
                //self.exportVideoWithAnimation()
                let videoDataDict:[String: URL] = ["dataUser": outputURL]
                BaseCommons.registerTransmitNotificationcenter(BaseVideoNotificationKey.MIX_VIDEOS_AUDIO_COMPLITE, nil, videoDataDict)
            }
        }
    }

}
