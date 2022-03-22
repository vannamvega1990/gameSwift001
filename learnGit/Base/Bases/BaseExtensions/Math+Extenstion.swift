//
//  Math+Extenstion.swift
//  VegaFintech
//
//  Created by Tu Dao on 6/1/21.
//  Copyright © 2021 Vega. All rights reserved.
//

import Foundation
import UIKit

extension CGPoint {
    func Multiply(factor:CGFloat) -> CGPoint {
        return CGPoint(x: self.x*factor, y:self.x*factor)
    }
    // change point position --------------------
    func moveToPoint(dx:CGFloat,dy:CGFloat) -> CGPoint{
        return CGPoint(x: self.x + dx, y: self.y + dy)
    }
    
}
// degrees To Radians -----------------
extension BinaryInteger {
    var degreesToRadians: CGFloat { CGFloat(self) * .pi / 180 }
}
// degrees To Radians -----------------
extension FloatingPoint {
    var degreesToRadians: Self { self * .pi / 180 }
    var radiansToDegrees: Self { self * 180 / .pi }
}

extension CGSize {
    func Multiply(factor:CGFloat) -> CGSize {
        return CGSize(width: self.width*factor, height: self.height*factor)
        //return CGPoint(x: self.x*factor, y:self.x*factor)
    }
}

extension CGRect {
    //resize CGRect at center, scale uiview at center ----------------
    func resizeAtCenter(offsetX:CGFloat,offsetY:CGFloat) -> CGRect{
//        let v = UIView(frame: self)
//        let org = self.origin.moveToPoint(dx: -offsetX, dy: -offsetY)
//        return CGRect(origin: org, size: CGSize(width: v.bounds.width + 2*offsetX, height: v.bounds.height + 2*offsetY))
        return self.insetBy(dx: offsetX, dy: offsetY)
    }
}
// re arrange array ----------------
extension Array {
    func reArrang() -> Array{
        return self.shuffled()
    }
}

extension UIViewController{
    func createRandomBool()  -> Bool{
        let randomBool = Bool.random()
        return randomBool
    }
    func createRandomInt(from:Int,to:Int)  -> Int{
//        let randomInt = Int.random(in: from...to)
//        return randomInt
        let randomNumInt     = Int.random(min: from, max: to)
        return randomNumInt
    }
    func createRandomFloat(from:Float,to:Float)  -> Float{
//        let randomFloat = Float.random(in: 1...6)
//        return randomFloat
        let randomNumFloat   = Float.random(min: from, max: to)
        return randomNumFloat
    }
    func createRandomDouble(from:Double,to:Double)  -> Double{
        let randomNumDouble  = Double.random(min: from, max: to)
        return randomNumDouble
    }
    func createRandomCGFloat(from:CGFloat,to:CGFloat)  -> CGFloat{
        let randomNumCGFloat = CGFloat.random(min: from, max: to)
        return randomNumCGFloat
    }
}

public extension Int {

    /// Returns a random Int point number between 0 and Int.max.
    static var random: Int {
        return Int.random(n: Int.max)
    }

    /// Random integer between 0 and n-1.
    ///
    /// - Parameter n:  Interval max
    /// - Returns:      Returns a random Int point number between 0 and n max
    static func random(n: Int) -> Int {
        return Int(arc4random_uniform(UInt32(n)))
    }

    ///  Random integer between min and max
    ///
    /// - Parameters:
    ///   - min:    Interval minimun
    ///   - max:    Interval max
    /// - Returns:  Returns a random Int point number between 0 and n max
    static func random(min: Int, max: Int) -> Int {
        return Int.random(n: max - min + 1) + min

    }
}

// MARK: Double Extension

public extension Double {

    /// Returns a random floating point number between 0.0 and 1.0, inclusive.
    static var random: Double {
        return Double(arc4random()) / 0xFFFFFFFF
    }

    /// Random double between 0 and n-1.
    ///
    /// - Parameter n:  Interval max
    /// - Returns:      Returns a random double point number between 0 and n max
    static func random(min: Double, max: Double) -> Double {
        return Double.random * (max - min) + min
    }
}

// MARK: Float Extension

public extension Float {

    /// Returns a random floating point number between 0.0 and 1.0, inclusive.
    static var random: Float {
        return Float(arc4random()) / 0xFFFFFFFF
    }

    /// Random float between 0 and n-1.
    ///
    /// - Parameter n:  Interval max
    /// - Returns:      Returns a random float point number between 0 and n max
    static func random(min: Float, max: Float) -> Float {
        return Float.random * (max - min) + min
    }
}

// MARK: CGFloat Extension

public extension CGFloat {

    /// Randomly returns either 1.0 or -1.0.
    static var randomSign: CGFloat {
        return (arc4random_uniform(2) == 0) ? 1.0 : -1.0
    }

    /// Returns a random floating point number between 0.0 and 1.0, inclusive.
    static var random: CGFloat {
        return CGFloat(Float.random)
    }

    /// Random CGFloat between 0 and n-1.
    ///
    /// - Parameter n:  Interval max
    /// - Returns:      Returns a random CGFloat point number between 0 and n max
    static func random(min: CGFloat, max: CGFloat) -> CGFloat {
        return CGFloat.random * (max - min) + min
    }
}
