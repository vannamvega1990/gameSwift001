//
//  VideoPlaybackViewController.swift
//  VegaFintech
//
//  Created by Tu Dao on 6/14/21.
//  Copyright © 2021 Vega. All rights reserved.
//

import Foundation
import AVFoundation
import UIKit



class VideoPlaybackViewController: BaseViewControllers {

    let avPlayer = AVPlayer()
    var avPlayerLayer: AVPlayerLayer!

    var videoURL: URL!
    //connect this to your uiview in storyboard
    //@IBOutlet weak var videoView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        let videoView = UIView() //frame: CGRect(x: 16, y: 96, width: 356, height: 367)
        videoView.frame = bounds.resizeAtCenter(offsetX: 56, offsetY: 56)//.insetBy(dx: 56, dy: 56)
        videoView.backgroundColor = .green
        addSubViews([videoView])
        //playVideoInView(videoView: videoView, videoURL: videoURL)
        avPlayerLayer = AVPlayerLayer(player: avPlayer)
        avPlayerLayer.frame = videoView.bounds
        avPlayerLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        videoView.layer.insertSublayer(avPlayerLayer, at: 0)

        view.layoutIfNeeded()

        let playerItem = AVPlayerItem(url: videoURL as URL)
        avPlayer.replaceCurrentItem(with: playerItem)

        avPlayer.play()
    }
    
    
}
