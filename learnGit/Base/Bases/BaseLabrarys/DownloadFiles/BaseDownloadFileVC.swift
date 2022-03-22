//
//  BaseDownloadFileVC.swift
//  VegaFintech
//
//  Created by THONG TRAN on 09/10/2021.
//  Copyright © 2021 Vega. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class BaseDownloadFileVC: UIViewController ,URLSessionDelegate,URLSessionDataDelegate,
                          URLSessionDownloadDelegate{
    
    //var url : URL?
    var downloadTask: URLSessionDownloadTask?
    var session: URLSession?
    var buffer:NSMutableData = NSMutableData()
    var timer = Timer()
    let timeInterval:TimeInterval = 1
    var count = 3
    
    var completedDowloadingClosure:((URL)->Void)?
    
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var progress: UIProgressView!

    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        downloadTask?.cancel()
    }
    
    func urlSession(_ session: URLSession, didBecomeInvalidWithError error: Error?) {
        print("session: didBecomeInvalidWithError: \(error?.localizedDescription)")
    }
    //    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
    //        print("Your data is here!")
    //    }
    
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        debugPrint("Download finished: \(location)")
        
        completedDowloadingClosure?(location)
        
        //        try? FileManager.default.removeItem(at: location)
        
        //copy downloaded data to your documents directory with same names as source file
        let documentsUrl =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        
        //let destinationUrl = documentsUrl!.appendingPathComponent(location.lastPathComponent)
        let destinationUrl = documentsUrl!.appendingPathComponent("123.mp4")
        
        //try? FileManager.default.moveItem(at: location, to: destinationUrl)
        
        //let dataFromURL = try? Data(contentsOf: location)
        //try? dataFromURL?.write(to: destinationUrl, options: [.atomic])
        //print(destinationUrl)
        //self.playVideo(link: "\(destinationUrl)")
        
    }
    
    
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        let progress = Float(totalBytesWritten / totalBytesExpectedToWrite)
        print("bytesWritten : \(bytesWritten)")
        print("totalBytesWritten : \(totalBytesWritten)")
        print("totalBytesExpectedToWrite : \(totalBytesExpectedToWrite)")
        print("Making progress: \(progress)")
    }
    
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        print("session: task: didCompleteWithError: \(error?.localizedDescription)")
        session.finishTasksAndInvalidate()
    }

    func downloadAction(linkFile: String){
        super.viewDidLoad()
        //self.timer = Timer.scheduledTimer(timeInterval: timeInterval, target: self, selector: #selector(self.handleTimer), userInfo: nil, repeats: true)
        
        let configuration = URLSessionConfiguration.background(withIdentifier: "backgroundSession")
        session = URLSession(configuration: configuration, delegate: self, delegateQueue: OperationQueue.main)
        
        let link001 = "https://icdn.dantri.com.vn/thumb_w/640/2021/02/19/img-8773-1613708474470.jpg"
        let link = "https://video-hw.xvideos-cdn.com/videos/3gp/c/5/a/xvideos.com_c5abd4577fba82501df1092b634aa858.mp4?e=1613731906&ri=1024&rs=85&h=18871cbde8d2a8c87f17ed1aaebecb36"
        
        //let url = URL(string: "https://unsplash.it/200/300/?random")!
        //let url = URL(string: link001)!
        if let url = URL(string: linkFile) {
            print(url.pathExtension)
            downloadTask = session?.downloadTask(with: url)
            downloadTask!.resume()
        }else{
            self.showSimpleAlert(title: "note", ms: "link file ko dung")
        }
    }
    
    func stopDownload(){
        downloadTask?.cancel()
        session?.finishTasksAndInvalidate()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.timer = Timer.scheduledTimer(timeInterval: timeInterval, target: self, selector: #selector(self.handleTimer), userInfo: nil, repeats: true)
        
        let configuration = URLSessionConfiguration.background(withIdentifier: "backgroundSession")
        session = URLSession(configuration: configuration, delegate: self, delegateQueue: OperationQueue.main)
        
        let link001 = "https://icdn.dantri.com.vn/thumb_w/640/2021/02/19/img-8773-1613708474470.jpg"
        let link = "https://video-hw.xvideos-cdn.com/videos/3gp/c/5/a/xvideos.com_c5abd4577fba82501df1092b634aa858.mp4?e=1613731906&ri=1024&rs=85&h=18871cbde8d2a8c87f17ed1aaebecb36"
        
        //let url = URL(string: "https://unsplash.it/200/300/?random")!
        let url = URL(string: link001)!
        print(url.pathExtension)
        downloadTask = session?.downloadTask(with: url)
        
        
        //        downloadTask = session?.downloadTask(with: url, completionHandler: { (urlOrNil, responseOrNil, errorOrNil) in
        //            guard let fileURL = urlOrNil else { return }
        //            do {
        //                let documentsURL = try
        //                    FileManager.default.url(for: .documentDirectory,
        //                                            in: .userDomainMask,
        //                                            appropriateFor: nil,
        //                                            create: false)
        //                //let documentsUrl =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        //                //let destinationUrl = documentsUrl!.appendingPathComponent("123.mp4")
        //
        //                let savedURL = documentsURL.appendingPathComponent(fileURL.lastPathComponent)
        //                try FileManager.default.moveItem(at: fileURL, to: savedURL)
        //            } catch {
        //                print ("file error: \(error)")
        //            }
        //        })
        
        downloadTask!.resume()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    @IBAction func soundOnOffPressed(_ sender: UISwitch) {
        soundEnable = !soundEnable
    }
    
    @objc func handleTimer(){
        self.countLabel.text = "\(self.count)"
        count -= 1
        if count < 0 {
            self.timer.invalidate()
            //self.goToMainScreen()
        }
    }
    
}
