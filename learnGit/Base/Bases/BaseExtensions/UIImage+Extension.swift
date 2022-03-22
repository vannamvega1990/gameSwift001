//
//  UIImageExtension.swift
//  VegaFintech
//
//  Created by Tu Dao on 5/31/21.
//  Copyright © 2021 Vega. All rights reserved.
//

import UIKit
import Foundation

extension UIImage{
    
}

extension UIImage
{
    // image to base64 ---------------------------
    func base64Encode() -> String?
    {
        guard let imageData = self.pngData() else {
            return nil
        }
        
        let base64String = (imageData as NSData).base64EncodedString(options: [])
        return base64String
    }
    
    func convertToData() -> Data?{
        let data1 = self.jpegData(compressionQuality: 1)
        return data1
    }
    
    // resize image ---------------------------
    func resizeImage1(_ image:UIImage,newWidth:CGFloat)->UIImage{
        let scale=newWidth/image.size.width
        let newHeight=image.size.height*scale
        UIGraphicsBeginImageContext(CGSize(width:newWidth,height:newHeight))
        image.draw(in:CGRect(x:0,y:0,width:newWidth,height:newHeight))
        let newImage=UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
    
    // resize image ---------------------------
    func resizeImage(newWidth:CGFloat)->UIImage{
        let scale=newWidth/self.size.width
        let newHeight=self.size.height*scale
        UIGraphicsBeginImageContext(CGSize(width:newWidth,height:newHeight))
        self.draw(in:CGRect(x:0,y:0,width:newWidth,height:newHeight))
        let newImage=UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
    
    // crop image ---------------------------
    func crop( rect: CGRect) -> UIImage {
        var rect = rect
        rect.origin.x*=self.scale
        rect.origin.y*=self.scale
        rect.size.width*=self.scale
        rect.size.height*=self.scale
        let imageRef = self.cgImage!.cropping(to: rect)
        let image = UIImage(cgImage: imageRef!, scale: self.scale, orientation: self.imageOrientation)
        return image
    }
    
    //corner radius uiimage ----------------------
    public func withRoundedCorners(radius: CGFloat? = nil) -> UIImage? {
        let maxRadius = min(size.width, size.height) / 2
        let cornerRadius: CGFloat
        if let radius = radius, radius > 0 && radius <= maxRadius {
            cornerRadius = radius
        } else {
            cornerRadius = maxRadius
        }
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        let rect = CGRect(origin: .zero, size: size)
        UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius).addClip()
        draw(in: rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    // make a copy --------------
    func copyUIImage() -> UIImage{
        let shallowZebra = UIImage(cgImage: self.cgImage!)
        let zebraData = self.pngData()
        let newZebra = UIImage(data: zebraData!)
        return newZebra!
//        let zebra = UIImage(named: "an_image_of_a_zebra")
//        print(zebra?.CGImage) // check the address
//        let shallowZebra = UIImage(CGImage: zebra!.CGImage!)
//        print(shallowZebra.CGImage!) // same address
//
//        let zebraData = UIImagePNGRepresentation(zebra!)
//        let newZebra = UIImage(data: zebraData!)
//        print(newZebra?.CGImage) // new address
    }
    
    // change tincolor -----------------
    
    func setTintColor(with color: UIColor, isOpaque: Bool = false) -> UIImage? {
        let format = imageRendererFormat
        format.opaque = isOpaque
        return UIGraphicsImageRenderer(size: size, format: format).image { _ in
            color.set()
            withRenderingMode(.alwaysTemplate).draw(at: .zero)
        }
    }
    
    // save image to photos ------------------
    func saveToPhotos(selector: Selector){
        //UIImageWriteToSavedPhotosAlbum(pickedImage, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
        UIImageWriteToSavedPhotosAlbum(self, currentVC, selector, nil)
        
        //UIImageWriteToSavedPhotosAlbum(image, self,#selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
    }
}
