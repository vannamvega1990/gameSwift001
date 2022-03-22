//
//  BaseAudio.swift
//  VegaFintech
//
//  Created by Tu Dao on 6/14/21.
//  Copyright © 2021 Vega. All rights reserved.
//

import UIKit
import AVFoundation

extension AVPlayer {
    var isPlaying: Bool {
        return rate != 0 && error == nil
    }
}

class BaseAudio {
    static let shared = BaseAudio()
    var player: AVAudioPlayer?
    var player1 : AVPlayer?
    @objc func playerDidFinishPlaying(note: NSNotification) {
        print("Video Finished")
    }
    init() {
        NotificationCenter.default.addObserver(self, selector: #selector(playerDidFinishPlaying), name: .AVPlayerItemDidPlayToEndTime, object: nil)
    }
    func playSound_Local(name:String, withExtension:String) {
        guard let url = Bundle.main.url(forResource: name, withExtension: withExtension) else { return
        }
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)

            /* The following line is required for the player to work on iOS 11. Change the file type accordingly*/
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)

            /* iOS 10 and earlier require the following line:
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileTypeMPEGLayer3) */

            guard let player = player else { return }
            player.play()
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func pause_audio_online(){
        guard let player = player1 else {return}
        if player.isPlaying {
            player.pause()
        }else{
            //player.seek(to: .zero)
            player.play()
        }
        
    }
    
    func pause_audio_local(){
        guard let player = player else {return}
        player.pause()
    }
    
    func stop_audio_online(){
        //guard let player = player1 else {return}
        player1 = nil
    }
    
    func stop_audio_local(){
        guard let player = player else {return}
        player.stop()
    }
    
    func playSoundOnline(urlString:String){
        if let player1 = player1, player1.isPlaying {
            return
        }
        guard  let url = URL(string:urlString )
            else
        {
            print("error to get the mp3 file")
            return
        }
        do{
            //try AVAudioSession.sharedInstance().setCategory(.playback, mode.default)
            try AVAudioSession.sharedInstance().setCategory(.playback)
            try AVAudioSession.sharedInstance().setActive(true)
            player1 = try AVPlayer(url: url as URL)
            guard let playerOnline = player1 else
            {
                return
            }
            
            playerOnline.play()
        } catch let error {
            print(error.localizedDescription)
        }
    }
}

extension BaseViewControllers {
    // play audio in local ------------------
    func playSound_Local(name:String, withExtension:String){
        BaseAudio.shared.playSound_Local(name:name, withExtension:withExtension)
    }
    // play audio online ------------------
    func playSoundOnline(urlString:String){
        BaseAudio.shared.playSoundOnline(urlString: urlString)
    }
    func stop_audio_online(){
        BaseAudio.shared.stop_audio_online()
    }
    
    func stop_audio_local(){
        BaseAudio.shared.stop_audio_local()
    }
    func pause_audio_online(){
       BaseAudio.shared.pause_audio_online()
    }
    
    func pause_audio_local(){
        BaseAudio.shared.pause_audio_local()
    }
    
}

