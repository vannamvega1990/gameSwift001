//
//  BaseNetwork.swift
//  VegaFintech
//
//  Created by Tu Dao on 6/2/21.
//  Copyright © 2021 Vega. All rights reserved.
//

import Foundation

class BaseNetwork {
    static let shared = BaseNetwork()
    private class func sendHTTPrequest(_ request:URLRequest,_ callbak:@escaping (Data?,URLResponse?,Error?)->Void){
        let session=URLSession(configuration:.default)
        let task2=session.dataTask(with:request){
            abomin,response,error in
            print("error:")
            print(error as Any)
            print("response:")
            print(response as Any)
            print("data:")
            print(abomin as Any)
            if let y=abomin{
                let tokenParts=y.map{
                    data->String in
                    return String(format:"%02.2hhX",data)
                }
                print("responseHexDump:")
                print(tokenParts.joined())
                let logger=NSString(data:y,encoding:String.Encoding.utf8.rawValue)
                print("responseString:")
                print(logger as Any)
            }
            DispatchQueue.main.async{
                callbak(abomin,response,error)
            }
            session.finishTasksAndInvalidate()
        }
        task2.resume()
    }
    class func simpleGet1(){
        //let camera = UIImage(data: try! Data(contentsOf: URL(string: "https://cdn4.iconfinder.com/data/icons/ionicons/512/icon-camera-128.png")!))!
        //let redCamera = camera.tinted(with: .red)
    }
    class func simpleGet() {
        let url=URL(string:"rootdirectory"+"iOS/loader.php?header=ios&act=booking_akuntant_customer&orderid=1")
        DispatchQueue.global(qos:.userInteractive).async{
            let data=try? Data(contentsOf:url!)
            let probe=NSString(data:data!,encoding:String.Encoding.utf8.rawValue)
            print(probe as Any)
            if let outer=try? JSONSerialization.jsonObject(with:data!,options:.mutableContainers){
                if let inter=outer as? NSDictionary{
                    print(inter)
                }
            }
        }
    }
    
    class func simpleget2(){
        let Language = "ios"
        let rootdirectory = "https://"
        let url=URL(string:rootdirectory+"iOS/ios_place_cats.php?language="+Language)
        print(url as Any)
        let data=try? Data(contentsOf:url!)
        if nil==data{
            return
        }
        let logger=NSString(data:data!,encoding:String.Encoding.utf8.rawValue)
        print(logger as Any)
        //placecats=try! JSONSerialization.jsonObject(with:data!,options:.mutableContainers) as! NSMutableArray
    }
    class func properHTTPost(_ there:String,_ content:[String:Any],_ callbak:@escaping (Data?,URLResponse?,Error?)->Void,headers:[String:String?]=[:]){
        print(there)
        print(content)
        var request=URLRequest(url:URL(string:there)!)
        request.httpBody=try! JSONSerialization.data(withJSONObject:content,options:[])
        request.httpMethod="POST"
        request.addValue("application/json",forHTTPHeaderField:"Content-Type")
        for (k,v) in headers{
            request.setValue(v,forHTTPHeaderField:k)
        }
        sendHTTPrequest(request,callbak)
    }
    class func fragileHTTP(_ there:String,_ content:String,_ callbak:@escaping (Data?,URLResponse?,Error?)->Void,headers:[String:String?]=[:],method:String?="POST"){
        print(there)
        //print(content)
        var request=URLRequest(url:URL(string:there)!)
        request.httpBody=content.data(using:.utf8)
        request.httpMethod=method
        request.timeoutInterval = 10000
        for (k,v) in headers{
            request.setValue(v,forHTTPHeaderField:k)
        }
        sendHTTPrequest(request,callbak)
    }
    
    class func fragileHTTPNobody(_ there:String,_ callbak:@escaping (Data?,URLResponse?,Error?)->Void,headers:[String:String?]=[:],method:String?="POST"){
        print(there)
        //print(content)
        var request=URLRequest(url:URL(string:there)!)
        //request.httpBody=content.data(using:.utf8)
        request.httpMethod=method
        request.timeoutInterval = 10000
        for (k,v) in headers{
            request.setValue(v,forHTTPHeaderField:k)
        }
        sendHTTPrequest(request,callbak)
    }
}
