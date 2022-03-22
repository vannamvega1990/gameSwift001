//
//  TPFaceMatchGuideViewController.swift
//  VegaFintech
//
//  Created by Tu Dao on 7/15/21.
//  Copyright © 2021 Vega. All rights reserved.
//

import UIKit

class TPFaceMatchGuideViewController: TPBaseViewController {
    
    var frontImage = UIImage()
    var backImage = UIImage()
    var counter = 0
    var timer = Timer()
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label3: UILabel!
    @IBOutlet weak var label4: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkConnection()
        setupLanguage()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (timer) in
            self.counter += 1
            if self.counter == 10 {
                //let destinationVC = self.storyboard?.instantiateViewController(withIdentifier: "FaceMatchViewController") as! FaceMatchViewController
                let storyboard = UIStoryboard(name: "ResultOCR", bundle: nil)
                
                let destinationVC = storyboard.instantiateViewController(withIdentifier: "FaceMatchViewController1") as! FaceMatchViewController1
                //let destinationVC = FaceMatchViewController()
                self.navigationController?.pushViewController(destinationVC, animated: true)
            }
        }
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        timer.invalidate()
    }
    
    func setupLanguage() {
        if isVN {
            label1.text = "Xác thực khuôn mặt với ảnh trong giấy tờ"
            label2.text = "Không đeo kính"
            label3.text = "Chụp ảnh rõ nét, không rung, méo, lóa"
            label4.text = "Để điện thoại cách xa mặt từ 40 - 50 cm"
            self.nextButton.setTitle("Đã hiểu", for: .normal)
        } else {
            label1.text = "Verify whether two images of your face belong to the same person"
            label2.text = "No glasses or face mask"
            label3.text = "Clear and readable information"
            label4.text = "Keep the device 40 - 50 cm away from your face"
            self.nextButton.setTitle("I understand", for: .normal)
        }
    }

    @IBAction func confirmAction(_ sender: Any) {
        
//        let storyboard = UIStoryboard(name: "ResultOCR", bundle: nil)
//        let destinationVC = storyboard.instantiateViewController(withIdentifier: "FaceMatchViewController1") as! FaceMatchViewController1
//        destinationVC.frontImage = frontImage
//        destinationVC.backImage = backImage
        
        let destinationVC = TPFaceMatchViewController()
        self.navigationController?.pushViewController(destinationVC, animated: true)
    }
}


