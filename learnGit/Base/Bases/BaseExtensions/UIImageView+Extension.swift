//
//  UIImageView+Extension.swift
//  VegaFintech
//
//  Created by Tu Dao on 5/31/21.
//  Copyright © 2021 Vega. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {  // for swift 4.2 syntax just use ===> mode: UIView.ContentMode
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
            }.resume()
    }
    func setTintColor(color: UIColor){
        image = image?.withRenderingMode(.alwaysTemplate)
        tintColor = color
    }
    // copy uiimage ----------------
    func copyUIImage() -> UIImage{
        let newCgIm = (image!.cgImage)!.copy()
        let newImage = UIImage(cgImage: newCgIm!, scale: image!.scale, orientation: image!.imageOrientation)
        return newImage
    }
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {  // for swift 4.2 syntax just use ===> mode: UIView.ContentMode
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
    
    // load ảnh có timeout --------------
    public func imageFromURL(urlString: String, extraImage:UIImage? = nil) { // chuẩn ----------
        
        //let activityIndicator = UIActivityIndicatorView(style: .gray)
        print("------ link anh \(urlString)")
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.color = .orange
        activityIndicator.frame = CGRect.init(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
        activityIndicator.startAnimating()
        
        guard let serviceUrl = URL(string: urlString) else { return }
        var request = URLRequest(url: serviceUrl)
        
        if self.image == nil{
            self.addSubview(activityIndicator)
        }else{
            self.addSubview(activityIndicator)
        }
        let session = URLSession.shared //1
        request.timeoutInterval = 1000
        
        let session1: URLSession = {
            let configuration = URLSessionConfiguration.default
            configuration.timeoutIntervalForRequest = 5
            configuration.timeoutIntervalForResource = 5
            return URLSession(configuration: configuration, delegate: nil, delegateQueue: nil)
        }()
        
        //let task = URLSession.shared.dataTask(with: NSURL(string: urlString)! as URL, completionHandler: { (data, response, error) -> Void in
        let task = session1.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                      print("------  lỗi response \(response.debugDescription)")
                      DispatchQueue.main.async {
                          activityIndicator.removeFromSuperview()
                          self.image = extraImage
                          return
                      }
                      return
                  }
            if error != nil {
                print("------  lỗi response \(error.debugDescription)")
                DispatchQueue.main.async {
                    activityIndicator.removeFromSuperview()
                    self.image = extraImage
                    return
                }
                return
                //print(error ?? "No Error")
                //self.image = extraImage
            }
            DispatchQueue.main.async(execute: { () -> Void in
                print("------  có data")
                let image = UIImage(data: data!)
                activityIndicator.removeFromSuperview()
                self.image = image ?? extraImage
            })
            
        }).resume()
    }
}
