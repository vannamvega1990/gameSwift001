//
//  Common.swift
//  mathFun360
//
//  Created by tran thong on 7/2/19.
//  Copyright © 2019 petter. All rights reserved.
//

import UIKit
import Foundation
import AVFoundation

var soundEnable:Bool = true
var inchToCm:CGFloat = 2.54

class Common {
    
    static let shared = Common()
    var player: AVAudioPlayer?
    
    func createRandomNumber(MaxValue:Int)->Int{
        let num = arc4random_uniform(UInt32(MaxValue))
        return Int(num)
    }
    
    
    
    func saveScore(value:String){
        UserDefaults.standard.set(value, forKey: keyScore)
    }
    func getScore()->String?{
        let score : String? = UserDefaults.standard.object(forKey: keyScore) as? String
        if let scoreGirl = score {
            return scoreGirl
        }
        return nil
    }
    
    func playSound(_ soundName:String, _ duoiFile:String) {
        guard let url = Bundle.main.url(forResource: soundName, withExtension: duoiFile) else {
            print("url not found")
            return
        }
        
        do {
            /// this codes for making this app ready to takeover the device audio
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
            try AVAudioSession.sharedInstance().setActive(true)
            
            /// change fileTypeHint according to the type of your audio file (you can omit this)
            
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            
            // no need for prepareToPlay because prepareToPlay is happen automatically when calling play()
            player!.play()
        } catch let error as NSError {
            print("error: \(error.localizedDescription)")
        }
    }
    
    func taoRungLac(_ view:UIView){
        UIView.animate(withDuration: 0.1, animations: {
            view.frame.origin.x -= 3
        }) { (bool) in
            UIView.animate(withDuration: 0.1, animations: {
                view.frame.origin.x += 6
            }) { (bool) in
                view.frame.origin.x -= 3
            }
        }
    }
    
    // centimet--- cm -----
    func getSizeOfScreenUnitCm() -> (Rong: CGFloat,Cao: CGFloat){
        let boundScreen = UIScreen.main.bounds
        print("width - \(boundScreen.width)")
        print("height - \(boundScreen.height)")
        print("scale - \(UIScreen.main.scale)")
        
        let scale = UIScreen.main.scale
        let ppi = scale * ((UIDevice.current.userInterfaceIdiom == .pad) ? 132 : 163)
        let width = UIScreen.main.bounds.size.width * scale // don vi pixel
        let height = UIScreen.main.bounds.size.height * scale // don vi pixel
        print("ppi - \(ppi)")
        
        let horizontal = width / ppi //don vi la inch
        let vertical = height / ppi // don vi la inch
        
        let diagonal = sqrt(pow(horizontal, 2) + pow(vertical, 2)) // don vi inch
        let screenSizeUnitInch = String(format: "%0.1f", diagonal)
        print("kich thuoc inch man hinh \(screenSizeUnitInch)")
        print("kich thuoc inch chieu rong \(horizontal)")
        print("kich thuoc inch chieu cao \(vertical)")
        return(horizontal*inchToCm,vertical*inchToCm)
    }
    
    func convertCmToDonviIphone(thamsoDauvaoCm: CGFloat) -> CGFloat{
        //let thamsoDauvaoCm: CGFloat = 1.6 // don vi cm
        let thamsoDauvaoInch = CGFloat(thamsoDauvaoCm / inchToCm)
        let scale = UIScreen.main.scale
        let ppi = scale * ((UIDevice.current.userInterfaceIdiom == .pad) ? 132 : 163)
        let thamsoDauVaoPixel = thamsoDauvaoInch * ppi
        let thamsoDauVaoSauChuyendoi = CGFloat(thamsoDauVaoPixel / scale)
        return thamsoDauVaoSauChuyendoi
    }
    
    
    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size
        
        let widthRatio  = targetSize.width  / image.size.width
        let heightRatio = targetSize.height / image.size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
}
