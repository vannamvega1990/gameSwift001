//
//  MathUtity.swift
//  learnGit
//
//  Created by TRAN THONG on 4/3/22.
//

import Foundation

class MathUtity {
    
    class func createVector(rootPoint: CGPoint, to point: CGPoint) -> CGVector{
        let dx = point.x - rootPoint.x
        let dy = point.y - rootPoint.y
        print("------dx\(dx)------dy\(dy)")
        return CGVector(dx: dx, dy: dy)
    }
    class func getDegreeOfVector(vector: CGVector) -> CGFloat?{ // return to radiant
        if vector.dy == 0 && vector.dx >= 0 {
            return 0
        }
        if vector.dy == 0 && vector.dx < 0 {
            return .pi
        }
        if vector.dx == 0 && vector.dy >= 0 {
            return .pi/2
        }
        if vector.dx == 0 && vector.dy < 0 {
            return -.pi/2
        }
        if vector.dy > 0 {
            let goc = atan2(vector.dx, vector.dy)
            print("------1eee\(goc)")
            let goc1 = .pi/2 - goc
            let goc2 = .pi - (goc + .pi/2)
            return goc >= 0 ? (goc1) : (goc2)
        }
        if vector.dy < 0 {
            let goc = atan2(vector.dx, vector.dy)
            print("------eee\(goc)")
            let goc1 = -.pi - (.pi/2 + goc)
            let goc2 = .pi/2 - goc 
            return goc <= 0 ? (goc1) : (goc2)
            //return -.pi/3
        }
        return nil
        //return atan2(vector.dx, -vetcor.dy) * 180.0 / CGFloat.pi
    }
    
    class func gocDoixung(goc: CGFloat) -> CGFloat{
        return .pi + goc
    }
    
    class func reduceGocOver180(goc: CGFloat) -> CGFloat {
        if goc <= .pi && goc >= -.pi {
            return goc
        }else if goc > .pi {
            return -2 * .pi + goc
        }else {
            return 2 * .pi + goc
        }
    }
    
    class func getDegree2Vector(fromVecter: CGVector, toVector: CGVector) -> CGFloat {
        let goc1 = MathUtity.getDegreeOfVector(vector: fromVecter)!
        let goc2 = MathUtity.getDegreeOfVector(vector: toVector)!
        return goc2 - goc1
    }
    
    class func convertAnchorPont(point: CGPoint, oldAnchopoint: CGPoint, objectFrame: CGRect) -> CGPoint {
        let x_goc = objectFrame.origin.x - objectFrame.size.width * oldAnchopoint.x
        let y_goc = objectFrame.origin.y - objectFrame.size.height * oldAnchopoint.y
        let dx = point.x - x_goc
        let x: CGFloat = dx / objectFrame.size.width
        let dy = point.y - y_goc
        let y: CGFloat = dy / objectFrame.size.height
        return CGPoint(x: x, y: y)
    }
    
    class func DegreeToRadiant(goc: CGFloat) -> CGFloat{
        return goc * CGFloat.pi / 180.0 
    }
    
    
    class func RadiantToDegree(goc: CGFloat) -> CGFloat{
        return goc * 180.0 / CGFloat.pi
    }
}
