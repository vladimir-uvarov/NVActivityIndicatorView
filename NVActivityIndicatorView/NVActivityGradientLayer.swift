//
//  NVActivityGradientLayer.swift
//  NVActivityIndicatorView
//
//  Created by  NearlyDeadHipo on 28.03.17.
//  Copyright © 2017 Vinh Nguyen. All rights reserved.
//

import UIKit

class WCGraintCircleLayer: CALayer {
    
    override init () {
        super.init()
    }
    
    convenience init(bounds:CGRect,position:CGPoint,fromColor:UIColor,toColor:UIColor,linewidth:CGFloat,toValue:CGFloat) {
        self.init()
        self.bounds = bounds
        self.position = position
        let colors : [UIColor] = self.graint(fromColor: fromColor, toColor:toColor, count:4)
        for i in 0..<colors.count-1 {
            let graint = CAGradientLayer()
            graint.bounds = CGRect(origin:CGPoint.zero, size: CGSize(width:bounds.width/2,height:bounds.height/2))
            let valuePoint = self.positionArrayWith(bounds: self.bounds)[i]
            graint.position = valuePoint
            print("iesimo graint position: \(graint.position)")
            let fromColor = colors[i]
            let toColor = colors[i+1]
            let colors : [CGColor] = [fromColor.cgColor,toColor.cgColor]
            let stopOne: CGFloat = 0.0
            let stopTwo: CGFloat = 1.0
            let locations : [CGFloat] = [stopOne,stopTwo]
            graint.colors = colors
            graint.locations = locations as [NSNumber]? // with Swift 2 and Swift 3 you can cast directly a `CGFloat` value to `NSNumber` and back
            graint.startPoint = self.startPoints()[i]
            graint.endPoint = self.endPoints()[i]
            self.addSublayer(graint)
            //Set mask
            let shapelayer = CAShapeLayer()
            let rect = CGRect(origin:CGPoint.zero,size:CGSize(width:self.bounds.width - 2 * linewidth,height: self.bounds.height - 2 * linewidth))
            shapelayer.bounds = rect
            shapelayer.position = CGPoint(x:self.bounds.width/2,y: self.bounds.height/2)
            shapelayer.strokeColor = UIColor.blue.cgColor
            shapelayer.fillColor = UIColor.clear.cgColor
            shapelayer.path = UIBezierPath(roundedRect: rect, cornerRadius: rect.width/2).cgPath
            shapelayer.lineWidth = linewidth
            shapelayer.lineCap = kCALineCapRound
            shapelayer.strokeStart = 0.010
            let finalValue = (toValue*0.99)
            shapelayer.strokeEnd = finalValue//0.99;
            self.mask = shapelayer
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func layerWithWithBounds(bounds:CGRect, position:CGPoint, fromColor:UIColor, toColor:UIColor, linewidth : CGFloat,toValue:CGFloat) -> WCGraintCircleLayer {
        let layer = WCGraintCircleLayer(bounds: bounds,position: position,fromColor:fromColor, toColor: toColor,linewidth: linewidth,toValue:toValue )
        return layer
    }
    
    func graint(fromColor:UIColor = UIColor.blue, toColor:UIColor = UIColor.white, count:Int) -> [UIColor]{
        var fromR:CGFloat = 0.0,fromG:CGFloat = 0.0,fromB:CGFloat = 0.0,fromAlpha:CGFloat = 0.0
        fromColor.getRed(&fromR,green: &fromG,blue: &fromB,alpha: &fromAlpha)
        
        var toR:CGFloat = 0.0,toG:CGFloat = 0.0,toB:CGFloat = 0.0,toAlpha:CGFloat = 0.0
        toColor.getRed(&toR,green: &toG,blue: &toB,alpha: &toAlpha)
        
        var result : [UIColor]! = [UIColor]()
        
        for i in 0...count {
            let oneR:CGFloat = fromR + (toR - fromR)/CGFloat(count) * CGFloat(i)
            let oneG : CGFloat = fromG + (toG - fromG)/CGFloat(count) * CGFloat(i)
            let oneB : CGFloat = fromB + (toB - fromB)/CGFloat(count) * CGFloat(i)
            let oneAlpha : CGFloat = fromAlpha + (toAlpha - fromAlpha)/CGFloat(count) * CGFloat(i)
            let oneColor = UIColor.init(red: oneR, green: oneG, blue: oneB, alpha: oneAlpha)
            result.append(oneColor)
            print(oneColor)
            
        }
        return result
    }
    
    func positionArrayWith(bounds:CGRect) -> [CGPoint]{
        let first = CGPoint(x:(bounds.width/4)*3,y: (bounds.height/4)*1)
        let second = CGPoint(x:(bounds.width/4)*3,y: (bounds.height/4)*3)
        let third = CGPoint(x:(bounds.width/4)*1,y: (bounds.height/4)*3)
        let fourth = CGPoint(x:(bounds.width/4)*1,y: (bounds.height/4)*1)
        print([first,second,third,fourth])
        return [first,second,third,fourth]
    }
    
    func startPoints() -> [CGPoint] {
        return [CGPoint.zero,CGPoint(x:1,y:0),CGPoint(x:1,y:1),CGPoint(x:0,y:1)]
    }
    
    func endPoints() -> [CGPoint] {
        return [CGPoint(x:1,y:1),CGPoint(x:0,y:1),CGPoint.zero,CGPoint(x:1,y:0)]
    }
    
    func midColorWithFromColor(fromColor:UIColor, toColor:UIColor, progress:CGFloat) -> UIColor {
        var fromR:CGFloat = 0.0,fromG:CGFloat = 0.0,fromB:CGFloat = 0.0,fromAlpha:CGFloat = 0.0
        fromColor.getRed(&fromR,green: &fromG,blue: &fromB,alpha: &fromAlpha)
        
        var toR:CGFloat = 0.0,toG:CGFloat = 0.0,toB:CGFloat = 0.0,toAlpha:CGFloat = 0.0
        toColor.getRed(&toR,green: &toG,blue: &toB,alpha: &toAlpha)
        
        let oneR = fromR + (toR - fromR) * progress
        let oneG = fromG + (toG - fromG) * progress
        let oneB = fromB + (toB - fromB) * progress
        let oneAlpha = fromAlpha + (toAlpha - fromAlpha) * progress
        let oneColor = UIColor.init(red: oneR, green: oneG, blue: oneB, alpha: oneAlpha)
        return oneColor
    }

}
