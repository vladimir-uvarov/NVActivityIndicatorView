//
//  NVActivityIndicatorAnimationMuzisBallClipRotate.swift
//  NVActivityIndicatorView
//
//  Created by  NearlyDeadHipo on 28.03.17.
//  Copyright © 2017 Vinh Nguyen. All rights reserved.
//

import UIKit

class NVActivityIndicatorAnimationMuzisBallClipRotate: NVActivityIndicatorAnimationDelegate {
    
    func setUpAnimation(in layer: CALayer, size: CGSize, color: UIColor) {
        let duration: CFTimeInterval = 0.75
        
        //    Scale animation
        //let scaleAnimation = CAKeyframeAnimation(keyPath: "transform.scale")
        
        //scaleAnimation.keyTimes = [0, 0.5, 1]
        //scaleAnimation.values = [1, 0.6, 1]
        
        // Rotate animation
        let rotateAnimation = CAKeyframeAnimation(keyPath: "transform.rotation.z")
        
        rotateAnimation.keyTimes = [0, 0.5, 1]//scaleAnimation.keyTimes
        rotateAnimation.values = [0, M_PI, 2 * M_PI]
        
        // Animation
        let animation = CAAnimationGroup()
        
        animation.animations = [/*scaleAnimation, */rotateAnimation]
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        animation.duration = duration
        animation.repeatCount = HUGE
        animation.isRemovedOnCompletion = false
        
        // Draw circle
        let size = CGSize(width: size.width, height: size.height)
        let muzisCircle = NVActivityIndicatorShape.muzisCircle.layerWith(size: size, color: UIColor.white)

        let frame = CGRect(x: (layer.bounds.size.width - size.width) / 2,
                           y: (layer.bounds.size.height - size.height) / 2,
                           width: size.width,
                           height: size.height)
        
        muzisCircle.frame = frame
        muzisCircle.add(animation, forKey: "animation")
        layer.addSublayer(muzisCircle)
    }
}
