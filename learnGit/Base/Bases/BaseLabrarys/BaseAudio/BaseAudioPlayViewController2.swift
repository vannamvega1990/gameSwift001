//
//  BaseAudioPlayViewController.swift
//  VegaFintech
//
//  Created by Tu Dao on 6/14/21.
//  Copyright © 2021 Vega. All rights reserved.
//

import UIKit
import AVFoundation



// ---------- play many sound online -------------------
class BaseAudioPlayViewController2: BaseViewControllers {
    
    
    init() {
        super.init(nibName: "BaseAudioPlayViewController2", bundle: nil)
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
    var countTimesPlay: Int = 0
    
    func readSongs(){
        let url = Bundle.main.url(forResource: "musics", withExtension:"plist")!
        do {
            let data = try Data(contentsOf: url)
            let result = try PropertyListDecoder().decode(Root.self, from: data)
            self.songs = result.musicsArray
            let soundFileNames = self.songs.map { (song:Song) -> String in
                return song.link
            }
            indexSong = createRandomInt(from: 0, to: self.songs.count-1)
            countTimesPlay = 1
            GSAudio.sharedInstance.playSound(soundFileName: self.songs[indexSong].link)
            //GSAudio.sharedInstance.playSounds(soundFileNames: soundFileNames, withDelay: 1.0)

        } catch {
            print(error)
            
        }
    }
    
    
    var indexSong: Int = 0
    @objc func playerDidFinishPlaying(note: NSNotification) {
        print("Video Finished")
//        indexSong += 1
//        if indexSong >= min(songs.count, 6) {
//            //indexSong = 0
//        }else{
//            GSAudio.sharedInstance.playSound(soundFileName: self.songs[indexSong].link)
//        }
        indexSong = createRandomInt(from: 0, to: self.songs.count-1)
        countTimesPlay += 1
        if countTimesPlay <= 16 {
            GSAudio.sharedInstance.playSound(soundFileName: self.songs[indexSong].link)
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
        DispatchQueue.main.async {
            self.timerCount.text = "\(self.countTime)"
        }
        
        print(countTime)
        if countTime >=  hourOnce {
            stop_audio_online()
            stopTimer()
            //countTime = 0
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
        //DispatchQueue.global(qos: .unspecified).async {
         //   self.startTimer()
        //}
        
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
    
    @IBAction func btnStop(_ sender: UIButton) {
        //stop_audio_online()
    }


}


class GSAudio: NSObject, AVAudioPlayerDelegate {

    static let sharedInstance = GSAudio()

    private override init() {}

    var players = [URL:AVPlayer]()
    var duplicatePlayers = [AVPlayer]()
    var playerArray:[AVPlayer?] = [AVPlayer?]()

    func playSound (soundFileName: String){

        let soundFileNameURL = URL(string: soundFileName)!

        if let player = players[soundFileNameURL] { //player for sound has been found

            if player.isPlaying == false { //player is not in use, so use that one
                //player.prepareToPlay()
                player.play()

            } else { // player is in use, create a new, duplicate, player and use that instead

                //let duplicatePlayer = try! AVAudioPlayer(contentsOf: soundFileNameURL)
                let duplicatePlayer = try! AVPlayer(url: soundFileNameURL)
                //use 'try!' because we know the URL worked before.

                //duplicatePlayer.delegate = self
                //assign delegate for duplicatePlayer so delegate can remove the duplicate once it's stopped playing

                duplicatePlayers.append(duplicatePlayer)
                //add duplicate to array so it doesn't get removed from memory before finishing

                //duplicatePlayer.prepareToPlay()
                duplicatePlayer.play()

            }
        } else { //player has not been found, create a new player with the URL if possible
            do{
                //let player = try AVAudioPlayer(contentsOf: soundFileNameURL)
//                players[soundFileNameURL] = player
//                player.prepareToPlay()
//                player.play()
                
//                try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
//                try AVAudioSession.sharedInstance().setActive(true)
//
//                /* The following line is required for the player to work on iOS 11. Change the file type accordingly*/
//                let player = try AVAudioPlayer(contentsOf: soundFileNameURL, fileTypeHint: AVFileType.mp3.rawValue)
//                players[soundFileNameURL] = player
//                player.prepareToPlay()
//                player.play()
                
                if playerArray.count >= 1 {
                    for i in 0...playerArray.count-1{
                        playerArray[i] = nil
                        playerArray.removeAll()
                    }
                }
                
                try AVAudioSession.sharedInstance().setCategory(.playback)
                try AVAudioSession.sharedInstance().setActive(true)
                let player1: AVPlayer? = try AVPlayer(url: soundFileNameURL as URL)
                guard let playerOnline = player1 else
                {
                    return
                }
                players[soundFileNameURL] = player1
                playerArray.append(playerOnline)
                playerOnline.play()
                
                
            } catch {
                print("Could not play sound file!")
            }
        }
    }


    func playSounds(soundFileNames: [String]){

        for soundFileName in soundFileNames {
            playSound(soundFileName: soundFileName)
        }
    }

    func playSounds(soundFileNames: String...){
        for soundFileName in soundFileNames {
            playSound(soundFileName: soundFileName)
        }
    }

    func playSounds(soundFileNames: [String], withDelay: Double) { //withDelay is in seconds
        for (index, soundFileName) in soundFileNames.enumerated() {
            let delay = withDelay*Double(index)
            let _ = Timer.scheduledTimer(timeInterval: delay, target: self, selector: #selector(playSoundNotification(notification:)), userInfo: ["fileName":soundFileName], repeats: false)
        }
    }

    @objc func playSoundNotification(notification: NSNotification) {
        if let soundFileName = notification.userInfo?["fileName"] as? String {
            playSound(soundFileName: soundFileName)
         }
     }

    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        //duplicatePlayers.removeAtIndex(duplicatePlayers.indexOf(player))
        let index = duplicatePlayers.firstIndex{$0 === player} // 0
        duplicatePlayers.remove(at: index!)
        //Remove the duplicate player once it is done
    }

}










