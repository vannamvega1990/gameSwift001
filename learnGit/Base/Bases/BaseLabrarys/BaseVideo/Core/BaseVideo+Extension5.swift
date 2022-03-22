//
//  BaseVideo+Extension5.swift
//  VegaFintech
//
//  Created by Tu Dao on 6/18/21.
//  Copyright © 2021 Vega. All rights reserved.
//

import Foundation
import UIKit
import Photos
import AVKit


@available(iOS 11.0, *)
extension BaseVideo {

// make video from image array ---------------------------

    func buildVideoFromImageArray5(imageArray: [UIImage], indexVideo: Int, completion: @escaping(URL?) -> ()){
        
        let imagesPerSecond: TimeInterval = 1 //each image will be stay for 3 secs
        let fps: Int32 = 1
        let framePerSecond: Int32 = Int32(self.imagesPerSecond) //Int64(self.imagesPerSecond)
        let frameDuration = CMTimeMake(value: Int64(self.imagesPerSecond), timescale: fps)
        var frameCount: Int64 = 0
        var appendSucceeded = true
        
        DispatchQueue.main.async {
            let settings = RenderSettings()
            //settings.fps = framePerSecond
            let imageAnimator = ImageAnimator(renderSettings: settings,imagearr: imageArray)
            imageAnimator.render() {
                //self.displayVideo()
                let u:String=tempurl
                //let player = AVPlayer(url: URL(fileURLWithPath: u))
                let url = URL(fileURLWithPath: u)
                completion(url)
            }
        }
        
    }
}
