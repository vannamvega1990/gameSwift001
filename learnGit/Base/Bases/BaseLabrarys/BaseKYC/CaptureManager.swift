//
//  CaptureManager.swift
//  VegaFintecheKYC
//
//  Created by Nguyễn Quang on 3/4/21.
//

import Foundation
import UIKit
import AVFoundation

protocol CaptureManagerDelegate: class {
    func processCapturedImage(image: UIImage)
}

class CaptureManager: NSObject {
    internal static let shared = CaptureManager()
    weak var delegate: CaptureManagerDelegate?
    var session: AVCaptureSession?

    override init() {
        super.init()
        session = AVCaptureSession()

        //setup input

        guard let device =  AVCaptureDevice.default(for: AVMediaType.video) else { return  }
        let input = try! AVCaptureDeviceInput(device: device)
        session?.addInput(input)

        //setup output
        let output = AVCaptureVideoDataOutput()
        output.videoSettings = [(kCVPixelBufferPixelFormatTypeKey as NSString) : NSNumber(value: kCVPixelFormatType_32BGRA)] as [String : Any]
        output.setSampleBufferDelegate(self, queue: DispatchQueue.main)
        session?.addOutput(output)
        guard let connection = output.connection(with: AVMediaType.video), connection.isVideoOrientationSupported else { return }
        connection.videoOrientation = .portrait
    }

    func statSession() {
        session?.startRunning()
    }

    func stopSession() {
        session?.stopRunning()
    }

    func getImageFromSampleBuffer(sampleBuffer: CMSampleBuffer) ->UIImage? {
        guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else {
            return nil
        }
        CVPixelBufferLockBaseAddress(pixelBuffer, .readOnly)
        let baseAddress = CVPixelBufferGetBaseAddress(pixelBuffer)
        let width = CVPixelBufferGetWidth(pixelBuffer)
        let height = CVPixelBufferGetHeight(pixelBuffer)
        let bytesPerRow = CVPixelBufferGetBytesPerRow(pixelBuffer)
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedFirst.rawValue | CGBitmapInfo.byteOrder32Little.rawValue)
        guard let context = CGContext(data: baseAddress, width: width, height: height, bitsPerComponent: 8, bytesPerRow: bytesPerRow, space: colorSpace, bitmapInfo: bitmapInfo.rawValue) else {
            return nil
        }
        guard let cgImage = context.makeImage() else {
            return nil
        }
        let image = UIImage(cgImage: cgImage, scale: 1, orientation:.right)
        CVPixelBufferUnlockBaseAddress(pixelBuffer, .readOnly)
        return image
    }
}

extension CaptureManager: AVCaptureVideoDataOutputSampleBufferDelegate {
    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputSampleBuffer sampleBuffer: CMSampleBuffer!, from connection: AVCaptureConnection!) {
        guard let outputImage = getImageFromSampleBuffer(sampleBuffer: sampleBuffer) else {
            return
        }
        delegate?.processCapturedImage(image: outputImage)
    }
}
