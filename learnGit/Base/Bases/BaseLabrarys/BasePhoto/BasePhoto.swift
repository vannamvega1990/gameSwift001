//
//  BasePhoto.swift
//  VegaFintech
//
//  Created by tran dinh thong on 6/5/21.
//  Copyright © 2021 Vega. All rights reserved.
//

import UIKit

enum ImageSource {
    case photoLibrary
    case camera
}

class BasePhoto {
      
}

extension BaseViewControllers: UIImagePickerControllerDelegate, UINavigationControllerDelegate  {
    
    // create action sheet get photo from camera and photo ----------------
    func createActionSheetGetPhoto(){
        let array = [
            AlertAction(title: "Photos", style: .default, action: {
            self.selectImageFrom(.photoLibrary)
            }),
            AlertAction(title: "Camera", style: .default, action: {
            self.selectImageFrom(.camera)
            }),
            AlertAction(title: "Cancel", style: .cancel, action: nil)
        ]
        createActionSheet(title: "Get photo from", message: nil, subTitles: array)
    }
    
    // get photo from camera and photo ----------------
    func selectImageFrom(_ source: ImageSource){
        let imagePicker =  UIImagePickerController()
        imagePicker.delegate = self
        switch source {
        case .camera:
            imagePicker.sourceType = .camera
        case .photoLibrary:
            imagePicker.sourceType = .photoLibrary
        }
        present(imagePicker, animated: true, completion: nil)
    }
    
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        actionGetPhoto?(image)
        dismiss(animated: true, completion: nil)
    }
    

}
