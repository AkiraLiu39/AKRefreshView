//
//  CircleIndicator.swift
//  AKRefresh
//
//  Created by liuchang on 2016/11/30.
//  Copyright © 2016年 com.unknown. All rights reserved.
//

import UIKit

open class CircleIndicator: AKRefreshIndicator {

    open override func startAnimation() {
        super.startAnimation()
        let rotationAnim = CABasicAnimation(keyPath: "transform.rotation.z")
        rotationAnim.toValue = 2 * CGFloat.pi
        
        rotationAnim.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        rotationAnim.repeatCount = Float.infinity
        rotationAnim.duration = 1.0
        self.layer.add(rotationAnim, forKey: "rotation")
    }
    open override func animationWithProgress(_ progress: CGFloat) {
        self.setNeedsDisplay()
    }
    open override func draw(_ rect: CGRect) {
        super.draw(rect)
        let beginProgress : CGFloat = 0.2
        if (self.progress < beginProgress ) {return}

        let offsetProgress = ProgressInterval.max.rawValue - beginProgress
        let displayProgress = (self.progress - beginProgress) / offsetProgress

        let context = UIGraphicsGetCurrentContext()
        UIColor.lightGray.set()

        let bigCircleLineWidth:CGFloat = 2.0
        context?.setLineWidth(bigCircleLineWidth)
        let bigCircleRadius = self.frame.size.width * 0.5 - 2 * bigCircleLineWidth

        let centerX = rect.midX
        let centerY = rect.midY
        let centerPoint = CGPoint(x: centerX, y: centerY)
        let bigCircleStartAngle = CGFloat(-CGFloat.pi / 180 * 90)
        let bigCircleEndAngle =  CGFloat(-CGFloat.pi / 180 * (360  * displayProgress + 90))
        context?.addArc(center:centerPoint, radius: bigCircleRadius, startAngle:bigCircleStartAngle, endAngle:bigCircleEndAngle, clockwise: true)
        context?.setLineWidth(bigCircleLineWidth)
        context?.strokePath()

        let smallCircleRadius = bigCircleRadius - 6.0
        let circleRadius = self.progress * smallCircleRadius

        context?.addArc(center: centerPoint, radius: circleRadius, startAngle: 0, endAngle: CGFloat(2 * CGFloat.pi), clockwise: true)
        context?.fillPath()

        let willShowMidCircleProgress:CGFloat = 0.5
        if (self.progress >=  willShowMidCircleProgress) {
            let midProgress = (self.progress - willShowMidCircleProgress) / (ProgressInterval.max.rawValue - willShowMidCircleProgress);
            let midCircleRadius = smallCircleRadius + 2.5
            let startAngle = CGFloat(-CGFloat.pi / 180 * 90)
            let endAngle = CGFloat(CGFloat.pi / 180 * (270 * midProgress - 90))
            UIColor.red.set()
            context?.setLineCap(.round)
            context?.setLineJoin(.round)
            context?.setLineWidth(3)
            context?.addArc(center: centerPoint, radius: midCircleRadius, startAngle:startAngle , endAngle: endAngle, clockwise: false)
            context?.strokePath()
        }


    }


}
