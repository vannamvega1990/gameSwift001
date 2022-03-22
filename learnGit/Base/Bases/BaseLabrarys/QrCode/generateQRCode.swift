//
//  generateQRCode.swift
//  VegaFintech
//
//  Created by tran dinh thong on 6/13/21.
//  Copyright © 2021 Vega. All rights reserved.
//

import UIKit


extension UIViewController {
    func generateQRCode(from string: String) -> UIImage? {
        let data = string.data(using: String.Encoding.ascii)

        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 3, y: 3)

            if let output = filter.outputImage?.transformed(by: transform) {
                return UIImage(ciImage: output)
            }
        }

        return nil
    }
}
