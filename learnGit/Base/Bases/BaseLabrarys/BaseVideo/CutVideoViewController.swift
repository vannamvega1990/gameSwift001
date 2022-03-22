//
//  CutVideoViewController.swift
//  VegaFintech
//
//  Created by Tu Dao on 6/16/21.
//  Copyright © 2021 Vega. All rights reserved.
//

import AVFoundation
import UIKit
import Photos
import AVKit
import MobileCoreServices

class CutVideoViewController: BaseViewControllers {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let url = getUrlOfLocalFile(nameFile1: "sample_video_1", ofType1: "mp4")
        BaseVideo.singleton.cropVideo(sourceURL1: url!, statTime: 0, endTime: 1)
    }


}

extension BaseVideo {
    
//    func cropVideo(sourceURL1: NSURL, statTime:Float, endTime:Float)
//    {
//        let manager = FileManager.defaultManager()
//
//        guard let documentDirectory = try? manager.URLForDirectory(.DocumentDirectory, inDomain: .UserDomainMask, appropriateForURL: nil, create: true) else {return}
//        guard let mediaType = "mp4" as? String else {return}
//        guard let url = sourceURL1 as? NSURL else {return}
//
//        if mediaType == kUTTypeMovie as String || mediaType == "mp4" as String {
//            let asset = AVAsset(URL: url)
//            let length = Float(asset.duration.value) / Float(asset.duration.timescale)
//            print("video length: \(length) seconds")
//
//            let start = statTime
//            let end = endTime
//
//            var outputURL = documentDirectory.URLByAppendingPathComponent("output")
//            do {
//                try manager.createDirectoryAtURL(outputURL, withIntermediateDirectories: true, attributes: nil)
//                let name = Moment.newName()
//                outputURL = outputURL.URLByAppendingPathComponent("\(name).mp4")
//            }catch let error {
//                print(error)
//            }
//
//            //Remove existing file
//            _ = try? manager.removeItemAtURL(outputURL)
//
//
//            guard let exportSession = AVAssetExportSession(asset: asset, presetName: AVAssetExportPresetHighestQuality) else {return}
//            exportSession.outputURL = outputURL
//            exportSession.outputFileType = AVFileTypeMPEG4
//
//            let startTime = CMTime(seconds: Double(start ?? 0), preferredTimescale: 1000)
//            let endTime = CMTime(seconds: Double(end ?? length), preferredTimescale: 1000)
//            let timeRange = CMTimeRange(start: startTime, end: endTime)
//
//            exportSession.timeRange = timeRange
//            exportSession.exportAsynchronouslyWithCompletionHandler{
//                switch exportSession.status {
//                case .Completed:
//                    print("exported at \(outputURL)")
//                   self.saveVideoTimeline(outputURL)
//                case .Failed:
//                    print("failed \(exportSession.error)")
//
//                case .Cancelled:
//                    print("cancelled \(exportSession.error)")
//
//                default: break
//                }
//            }
//        }
//    }
    
    
    func cropVideo(sourceURL1: URL, statTime:Float, endTime:Float)
    {
        let manager = FileManager.default
        
        guard let documentDirectory = try? manager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true) else {return}
        let mediaType = "mp4"
        if mediaType == kUTTypeMovie as String || mediaType == "mp4" as String {
            let asset = AVAsset(url: sourceURL1 as URL)
            let length = Float(asset.duration.value) / Float(asset.duration.timescale)
            print("video length: \(length) seconds")
            
            let start = statTime
            let end = endTime
            
            var outputURL = documentDirectory.appendingPathComponent("output")
            do {
                try manager.createDirectory(at: outputURL, withIntermediateDirectories: true, attributes: nil)
                outputURL = outputURL.appendingPathComponent("\(UUID().uuidString).\(mediaType)")
            }catch let error {
                print(error)
            }
            
            //Remove existing file
            _ = try? manager.removeItem(at: outputURL)
            
            
            guard let exportSession = AVAssetExportSession(asset: asset, presetName: AVAssetExportPresetHighestQuality) else {return}
            exportSession.outputURL = outputURL
            exportSession.outputFileType = .mp4
            
            let startTime = CMTime(seconds: Double(start ), preferredTimescale: 1000)
            let endTime = CMTime(seconds: Double(end ), preferredTimescale: 1000)
            let timeRange = CMTimeRange(start: startTime, end: endTime)
            
            exportSession.timeRange = timeRange
            exportSession.exportAsynchronously{
                switch exportSession.status {
                case .completed:
                    print("exported at \(outputURL)")
                    currentVC.playVideoType1(linkURL: outputURL)
                    currentVC.saveVideoToPhotos(urlToYourVideo: "", url: outputURL)
                case .failed:
                    print("failed \(exportSession.error)")
                    
                case .cancelled:
                    print("cancelled \(exportSession.error)")
                    
                default: break
                }
            }
        }
    }
}
