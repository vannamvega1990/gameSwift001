//
//  DisconnectViewController.swift
//  VegaFintecheKYC
//
//  Created by Dương Tú on 24/02/2021.
//

import UIKit

class DisconnectViewController: UIViewController {
    var reachability: Reachability!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reachability = Reachability()
        NotificationCenter.default.addObserver(self, selector: #selector(self.reachabilityChanged(_:)), name: ReachabilityChangedNotification, object: reachability)
        do {
            try reachability?.startNotifier()
        } catch {
            print("could not start reachability notifier")
        }
        
    }
    
    //MARK: Kiểm tra internet connection liên tục khi có thông báo kết nối/ngắt
    @objc func reachabilityChanged(_ note: Notification) {
        if let reachability = note.object as? Reachability {
            if reachability.isReachable {
                //TODO: Xử lý ngay lập tức khi có kết nối
                print("Reachable")
                reachableInternet()
            } else {
                //TODO: Xử lý ngay lập tức khi bị mất mạng
                print("un Reachable")
                reachableNotInternet()
            }
        }
    }
    
    open func reachableInternet() {
        self.dismiss(animated: true, completion: nil)
    }
    
    open func reachableNotInternet() {
        
    }
    
    @IBAction func confirmAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
