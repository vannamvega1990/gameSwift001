//
//  BaseAudioPlayViewController.swift
//  VegaFintech
//
//  Created by Tu Dao on 6/14/21.
//  Copyright © 2021 Vega. All rights reserved.
//

import UIKit


class BaseAudioPlayViewController: BaseViewControllers {
    
    init() {
        super.init(nibName: "BaseAudioPlayViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @IBOutlet weak var numberSong: UILabel!
    @IBOutlet weak var timerCount: UILabel!
    var songsArray = [
                    "https://file-examples-com.github.io/uploads/2017/11/file_example_MP3_5MG.mp3",
                    "http://vnno-zn-5-tf-mp3-s1-zmp3.zadn.vn/f227642e6c6a8534dc7b/4748361903092901302?authen=exp=1623895923~acl=/f227642e6c6a8534dc7b/*~hmac=252bd29c36acf09aadee9c8e99f9417e"
    ]
    
    // read plist file ------------------
    // Decodeable, decode, encode ------------------
    struct Root : Decodable {
        let musicsArray : [Song]
    }
    struct Song : Decodable {
        let name, link : String
    }
    
    var songs = [Song]()
    
    
    func readSongs(){
        let url = Bundle.main.url(forResource: "musics", withExtension:"plist")!
        do {
            let data = try Data(contentsOf: url)
            let result = try PropertyListDecoder().decode(Root.self, from: data)
            self.songs = result.musicsArray
        } catch {
            print(error)
            
        }
    }
    
    
    
    @objc func playerDidFinishPlaying(note: NSNotification) {
        print("Video Finished")
        if !isRepeat {
            stop_audio_online()
            play()
        }
    }
    func play(){
        if let player1 = BaseAudio.shared.player1, player1.isPlaying {
            return
        }
        let random = createRandomInt(from: 0, to: songs.count-1)
        numberSong.text = "\(random+1)"
        playSoundOnline(urlString: songs[random].link )
    }
    @objc func overTimePlay(){
        countTime += 1
        timerCount.text = "\(countTime)"
        print(countTime)
        if countTime >=  hourOnce {
            stop_audio_online()
            stopTimer()
            countTime = 0
        }
    }
    var countTime = 0 // don vi giay s
    var timer:Timer?
    func startTimer(){
        countTime = 0
        timer = createTimer(timeInterval: 1, selector: #selector(overTimePlay), repeats: true)
    }
    func stopTimer(){
        if timer != nil {
            timer!.invalidate()
        }
        timer = nil
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        readSongs()
        NotificationCenter.default.addObserver(self, selector: #selector(playerDidFinishPlaying), name: .AVPlayerItemDidPlayToEndTime, object: nil)
        startTimer()
    }
    
    var isRepeat: Bool = true
    @IBAction func btnRepeat(_ sender: UIButton) {
        isRepeat = !isRepeat
        sender.backgroundColor = isRepeat ? UIColor.white : UIColor.orange
    }
    
    @IBAction func btnPlay(_ sender: UIButton) {
        //stopTimer()
        //startTimer()
        if timer != nil {
            play()
        }
    }
    
    @IBAction func btnPause(_ sender: UIButton) {
        let player1 =  BaseAudio.shared.player1
        guard player1 != nil  else {
            return
        }
        if let player1 = player1, player1.isPlaying {
            //sender.setTitle("Resum", for: .normal)
            sender.setTitle("Test", for: .normal)
        }else{
            //sender.setTitle("Pause", for: .normal)
            sender.setTitle("Re json", for: .normal)
        }
        
        pause_audio_online()
    }
    
    @IBAction func btnGoScreen(_ sender: UIButton) {
        let vc = BaseAudioPlayViewController2()
        let player1 =  BaseAudio.shared.player1
        if player1 == nil {
            pushToViewController(vc, true)
        }
    }
    
    @IBAction func btnStop(_ sender: UIButton) {
        stop_audio_online()
    }


}

extension UIViewController {
    
}

//Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(self.hideLoader), userInfo: nil, repeats: false)
//if listDeviceObjectShow2.isEmpty == true {
//    self.hideLoader()
//}

// timer = Timer()
//self.timer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(self.hideLoader), userInfo: nil, repeats: false)
