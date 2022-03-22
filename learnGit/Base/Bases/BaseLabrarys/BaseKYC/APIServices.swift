//
//  APIServices.swift
//  VegaFintecheKYC
//
//  Created by Dương Tú on 26/01/2021.
//

import Foundation
import UIKit

class APIServices {
    func requestUploadOCRFront(image: UIImage, completion: @escaping (_ any: OCRFront) -> Void) {
        let url = Constants.API.OCRFRONT
        guard let data: Data = image.jpegData(compressionQuality: 1) else {
            return
        }
        
        sendFile(urlPath: url, fileName: "image.jpg", data: data) { (response, data, error) in
            NSLog("Complete: \(String(describing: data))")
            do {
                if let  data = data {
                    
                    //let shit = try! JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                    //print(shit)
                    
                    let dataString = String(data: data, encoding: .utf8)
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                                     // try to read out a dictionary
                                     print(json)
                    }
                    
                    let responseData = try JSONDecoder().decode(OCRFront.self, from: data)
                    completion(responseData)
                } else {
                    print("Data nil!")
                }
            } catch let jsonErr {
                print("Error decoding Json", jsonErr)
            }
        }
    }
    
    func requestUploadOCRBack(image: UIImage, completion: @escaping (_ any: OCRBack) -> Void) {
        let url = Constants.API.OCRBACK
        guard let data: Data = image.jpegData(compressionQuality: 1) else {
            return
        }
        
        sendFile(urlPath: url, fileName: "image.jpg", data: data) { (response, data, error) in
            do {
                if let  data = data {
                    
                    let dataString = String(data: data, encoding: .utf8)
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                                     // try to read out a dictionary
                                     print(json)
                    }
                    
                    let responseData = try JSONDecoder().decode(OCRBack.self, from: data)
                    completion(responseData)
                } else {
                    print("Data nil!")
                }
            } catch let jsonErr {
                print("Error decoding Json", jsonErr)
            }
        }
    }
    
    func compare2Face(identityImage: UIImage, faceImage: UIImage, completion: @escaping (_ any: Face2Face) -> Void) {
        guard var url: URL = URL(string: Constants.API.COMPARE2FACE) else {
            return
        }

        url.appendQueryItem(name: "threshold", value: "0.5")
        
        guard let identityData: Data = identityImage.jpegData(compressionQuality: 1) else {
            return
        }
        
        guard let faceData: Data = faceImage.jpegData(compressionQuality: 1) else {
            return
        }

        var request: URLRequest = URLRequest(url: url)
         
        request.httpMethod = "POST"
        
        let boundary = "boundary" + Date().timeIntervalSince1970.description
        var listData = [Data]()
        listData.append(identityData)
        listData.append(faceData)
        let fullData = listPhotoDataToFormData(listData: listData, boundary: boundary, parameters: nil)
        
        request.setValue("multipart/form-data; boundary=" + boundary,
                          forHTTPHeaderField: "Content-Type")
        
        // REQUIRED!

        request.setValue(String(fullData.count), forHTTPHeaderField: "Content-Length")
        request.httpBody = fullData
        request.httpShouldHandleCookies = false
        request.setValue(Constants.KEY.appID, forHTTPHeaderField: "X-Vega-App-Id")
        request.setValue(Constants.KEY.accessToken, forHTTPHeaderField: "X-Vega-Access-Token")
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            do {
                if let  data = data {
                    print(url)
                    let responseData = try JSONDecoder().decode(Face2Face.self, from: data)
                    print(responseData)
                    completion(responseData)
                } else {
                    print("Data nil!")
                }
            } catch let jsonErr {
                print("Error decoding Json", jsonErr)
            }
        }
        task.resume()
    }
    
    private func sendFile(
        urlPath:String,
        fileName:String,
        data:Data,
        completion: @escaping (URLResponse?, Data?, Error?) -> Void) {

        guard let url: URL = URL(string: urlPath) else {
            return
        }
        
        var request1: URLRequest = URLRequest(url: url)
         
        request1.httpMethod = "POST"
        
        let boundary = "boundary"
        let fullData = photoDataToFormData(data:data,boundary:boundary,fileName:fileName)
        
        request1.setValue("multipart/form-data; boundary=" + boundary,
                          forHTTPHeaderField: "Content-Type")
        
        // REQUIRED!
        request1.setValue(String(fullData.count), forHTTPHeaderField: "Content-Length")
        request1.httpBody = fullData
        //request1.httpShouldHandleCookies = false
        request1.setValue(Constants.KEY.appID, forHTTPHeaderField: "X-Vega-App-Id")
        request1.setValue(Constants.KEY.accessToken, forHTTPHeaderField: "X-Vega-Access-Token")
        
        let task = URLSession.shared.dataTask(with: request1) { (data, response, error) in
            completion(response,data,error)
        }
        task.resume()
    }

    func photoDataToFormData(data:Data,boundary:String,fileName:String) -> Data {
        var fullData = Data()

        // 1 - Boundary should start with --
        let lineOne = "--" + boundary + "\r\n"
        NSLog(lineOne)
        fullData.append(lineOne.data(using: .utf8, allowLossyConversion: false)!)

        // 2
        let lineTwo = "Content-Disposition: form-data; name=\"image\"; filename=\"" + fileName + "\"\r\n"
        NSLog(lineTwo)
        fullData.append(lineTwo.data(using: .utf8, allowLossyConversion: false)!)

        // 3
        let lineThree = "Content-Type: image/jpeg\r\n\r\n"
        NSLog(lineThree)
        fullData.append(lineThree.data(using: .utf8, allowLossyConversion: false)!)

        // 4
        NSLog(data.description)
        fullData.append(data)

        // 5
        let lineFive = "\r\n"
        NSLog(lineFive)
        fullData.append(lineFive.data(using: .utf8, allowLossyConversion: false)!)

        // 6 - The end. Notice -- at the start and at the end
        let lineSix = "--" + boundary + "--\r\n"
        NSLog(lineSix)
        fullData.append(lineSix.data(using: .utf8, allowLossyConversion: false)!)

        return fullData
    }
    
//    func photoDataToFormData(listData:[Data],boundary:String, parameters:[String:String]?) -> Data {
//        var fullData = Data()
//        for (index, data) in listData.enumerated() {
//            // 1 - Boundary should start with --
//            let lineOne = "--" + boundary + "\r\n"
//            NSLog(lineOne)
//            fullData.append(lineOne.data(using: .utf8, allowLossyConversion: false)!)
//
//            // 2
//            let lineTwo = "Content-Disposition: form-data; name=\"image\"; filename=\"image_0\(index + 1).jpg\"\r\n"
//            NSLog(lineTwo)
//            fullData.append(lineTwo.data(using: .utf8, allowLossyConversion: false)!)
//
//            // 3
//            let lineThree = "Content-Type: image/jpeg\r\n\r\n"
//            NSLog(lineThree)
//            fullData.append(lineThree.data(using: .utf8, allowLossyConversion: false)!)
//
//            // 4
//            NSLog(data.description)
//            fullData.append(data)
//
//            // 5
//            let lineFive = "\r\n"
//            NSLog(lineFive)
//            fullData.append(lineFive.data(using: .utf8, allowLossyConversion: false)!)
//        }
//        if parameters != nil {
//            for (key, value) in parameters! {
//                let str = "--\(boundary)\r\n" + "Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n" + "\(value)\r\n"
//                let data = str.data(using: .utf8, allowLossyConversion: true)
//
//                fullData.append(data!)
//            }
//        }
//
//        // 6 - The end. Notice -- at the start and at the end
//        let lineSix = "--" + boundary + "--\r\n"
//        NSLog(lineSix)
//        fullData.append(lineSix.data(using: .utf8, allowLossyConversion: false)!)
//
//        return fullData
//    }
    
    func listPhotoDataToFormData(listData:[Data],boundary:String, parameters:[String:String]?) -> Data {
        var uploadData = Data()
        // add image
        for (index, data) in listData.enumerated() {
            uploadData.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
            uploadData.append("Content-Disposition: form-data; name=\"image_0\(index + 1)\"; filename=\"image.jpg\"\r\n".data(using: .utf8)!)
            uploadData.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
            uploadData.append(data)
        }
        // add parameters
        if parameters != nil {
            for (key, value) in parameters! {
                uploadData.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
                uploadData.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n\(value)".data(using: .utf8)!)
            }
        }
        uploadData.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)
        return uploadData
    }
}

extension URL {

    mutating func appendQueryItem(name: String, value: String?) {

        guard var urlComponents = URLComponents(string: absoluteString) else { return }

        // Create array of existing query items
        var queryItems: [URLQueryItem] = urlComponents.queryItems ??  []

        // Create query item
        let queryItem = URLQueryItem(name: name, value: value)

        // Append the new query item in the existing query items array
        queryItems.append(queryItem)

        // Append updated query items array in the url component object
        urlComponents.queryItems = queryItems

        // Returns the url from new url components
        self = urlComponents.url!
    }
}
