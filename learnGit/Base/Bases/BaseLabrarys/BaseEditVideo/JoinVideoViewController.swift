//
//  JoinVideoViewController.swift
//  VegaFintech
//
//  Created by Tu Dao on 6/14/21.
//  Copyright © 2021 Vega. All rights reserved.
//

import UIKit
import AVFoundation
import Photos


class JoinVideoViewController: BaseViewControllers{
    
    
    var arrayVideos = [AVAsset]() //Videos Array
    var atTimeM: CMTime = CMTimeMake(value: 0, timescale: 0)
    var lastAsset: AVAsset!
    var layerInstructionsArray = [AVVideoCompositionLayerInstruction]()
    var completeTrackDuration: CMTime = CMTimeMake(value: 0, timescale: 1)
    var videoSize: CGSize = CGSize(width: 0.0, height: 0.0)

    func mergeVideoArray(){

        let mixComposition = AVMutableComposition()
        for videoAsset in arrayVideos{
            let videoTrack = mixComposition.addMutableTrack(withMediaType: AVMediaType.video, preferredTrackID: Int32(kCMPersistentTrackID_Invalid))
            guard videoTrack != nil else {
                return
            }
            do {
                if videoAsset == arrayVideos.first{
                    atTimeM = CMTime.zero
                } else{
                    atTimeM = lastAsset!.duration
                }
                //try videoTrack!.insertTimeRange(CMTimeRangeMake(start: CMTime.zero, duration: videoAsset.duration), of: videoAsset.tracks(withMediaType: AVMediaType.video)[0], at: atTimeM)
                try videoTrack!.insertTimeRange(CMTimeRangeMake(start: CMTime.zero, duration: videoAsset.duration),
                                                of: videoAsset.tracks(withMediaType: AVMediaType.video)[0],
                at: atTimeM)
                videoSize = videoTrack!.naturalSize
            } catch let error as NSError {
                print("error: \(error)")
            }
            //totalTime += videoAsset.duration // <-- Update the total time for all videos.
            
            completeTrackDuration = CMTimeAdd(completeTrackDuration, videoAsset.duration)
            let videoInstruction = AVMutableVideoCompositionLayerInstruction(assetTrack: videoTrack!)
            if videoAsset != arrayVideos.last{
                videoInstruction.setOpacity(0.0, at: videoAsset.duration)
            }
            layerInstructionsArray.append(videoInstruction)
            lastAsset = videoAsset
        }

        let mainInstruction = AVMutableVideoCompositionInstruction()
        mainInstruction.timeRange = CMTimeRangeMake(start: CMTime.zero, duration: completeTrackDuration)
        mainInstruction.layerInstructions = layerInstructionsArray

        let mainComposition = AVMutableVideoComposition()
        mainComposition.instructions = [mainInstruction]
        mainComposition.frameDuration = CMTimeMake(value: 1, timescale: 30)
        mainComposition.renderSize = CGSize(width: videoSize.width, height: videoSize.height)

        let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .short
        let date = dateFormatter.string(from: NSDate() as Date)
        let savePath = (documentDirectory as NSString).appendingPathComponent("mergeVideo-\(date).mov")
        let url = NSURL(fileURLWithPath: savePath)

        let exporter = AVAssetExportSession(asset: mixComposition, presetName: AVAssetExportPresetHighestQuality)
        exporter!.outputURL = url as URL
        exporter!.outputFileType = AVFileType.mov
        exporter!.shouldOptimizeForNetworkUse = true
        exporter!.videoComposition = mainComposition
        exporter!.exportAsynchronously {

            PHPhotoLibrary.shared().performChanges({
                PHAssetChangeRequest.creationRequestForAssetFromVideo(atFileURL: exporter!.outputURL!)
            }) { saved, error in
                if saved {
                    let alertController = UIAlertController(title: "Your video was successfully saved", message: nil, preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alertController.addAction(defaultAction)
                    self.present(alertController, animated: true, completion: nil)
                } else{
                    print("video erro: \(error)")

                }
            }
        }
    }


}
