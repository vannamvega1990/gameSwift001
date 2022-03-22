//
//  RecordVideoViewController.swift
//  VegaFintech
//
//  Created by Tu Dao on 6/16/21.
//  Copyright © 2021 Vega. All rights reserved.
//

import UIKit
import MobileCoreServices

class RecordVideoViewController: UIViewController {
    
    init() {
        super.init(nibName: "RecordVideoViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

  
  @IBAction func record(_ sender: AnyObject) {
    VideoHelper.startMediaBrowser(delegate: self, sourceType: .camera)
  }
  
  @objc func video(_ videoPath: String, didFinishSavingWithError error: Error?, contextInfo info: AnyObject) {
    let title = (error == nil) ? "Success" : "Error"
    let message = (error == nil) ? "Video was saved" : "Video failed to save"
    
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil))
    //present(alert, animated: true, completion: nil)
    present(alert, animated: true, completion: {
        let url = self.pathToUrl(path: videoPath)
        self.playVideoType1(linkURL: url)
    })
  }
  
}

// MARK: - UIImagePickerControllerDelegate

extension RecordVideoViewController: UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        dismiss(animated: true, completion: nil)
        
        guard let mediaType = info[UIImagePickerController.InfoKey.mediaType] as? String,
            mediaType == (kUTTypeMovie as String),
            let url = info[UIImagePickerController.InfoKey.mediaURL] as? URL,
            UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(url.path)
            else { return }
        
        // Handle a movie capture
        UISaveVideoAtPathToSavedPhotosAlbum(url.path, self, #selector(video(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
//        dismiss(animated: true, completion: nil)
//
//        guard let mediaType = info[UIImagePickerControllerMediaType] as? String,
//            mediaType == (kUTTypeMovie as String),
//            let url = info[UIImagePickerControllerMediaURL] as? URL,
//            UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(url.path)
//            else { return }
//
//        // Handle a movie capture
//        UISaveVideoAtPathToSavedPhotosAlbum(url.path, self, #selector(video(_:didFinishSavingWithError:contextInfo:)), nil)
//    }
    
}

// MARK: - UINavigationControllerDelegate

extension RecordVideoViewController: UINavigationControllerDelegate {
}

