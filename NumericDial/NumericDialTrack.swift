//
//  NumericDialTrack.swift
//  NumericDial
//
//  Created by Simon Gladman on 05/09/2014.
//  Copyright (c) 2014 Simon Gladman. All rights reserved.
//

import UIKit

class NumericDialTrack: CALayer
{
    weak var numericDial: NumericDial?

    override func drawInContext(ctx: CGContext!)
    {
        if let value = numericDial?.currentValue
        {
            let angle : CGFloat = -135 + 270 * CGFloat(value)
        
            let trackPath = UIBezierPath(arcCenter: CGPoint(x: 150, y: 150), radius: 130, startAngle: 135 * CGFloat(M_PI)/180, endAngle: 45 * CGFloat(M_PI)/180, clockwise: true)

            // outer path
            CGContextSetLineCap(ctx, kCGLineCapRound);
            CGContextAddPath(ctx, trackPath.CGPath)
            CGContextSetStrokeColorWithColor(ctx, UIColor.darkGrayColor().CGColor)
            CGContextSetLineWidth(ctx, 10)
            CGContextStrokePath(ctx)
            
            // inner path
            CGContextSetLineCap(ctx, kCGLineCapRound);
            CGContextAddPath(ctx, trackPath.CGPath)
            CGContextSetStrokeColorWithColor(ctx, UIColor.whiteColor().CGColor)
            CGContextSetLineWidth(ctx, 5)
            CGContextStrokePath(ctx)
            
            let valuePath = UIBezierPath(arcCenter: CGPoint(x: 150, y: 150), radius: 130, startAngle: 135 * CGFloat(M_PI)/180, endAngle: (angle - 90) * CGFloat(M_PI)/180, clockwise: true)
            
            // value path
            CGContextSetLineCap(ctx, kCGLineCapRound);
            CGContextAddPath(ctx, valuePath.CGPath)
            CGContextSetStrokeColorWithColor(ctx, UIColor.blueColor().CGColor)
            CGContextSetLineWidth(ctx, 3)
            CGContextStrokePath(ctx)
            
            CGContextSetShadowWithColor(ctx, CGSize(width: 0.0, height: 0.0), 5.0, UIColor.grayColor().CGColor)
            
            let thumbPath = UIBezierPath(ovalInRect: CGRect(x: -25, y: -145, width: 30, height: 30))
            
            CGContextTranslateCTM(ctx, 150, 150)
            CGContextRotateCTM(ctx, angle * CGFloat(M_PI) / 180)
            
            CGContextAddPath(ctx, thumbPath.CGPath)
            CGContextSetFillColorWithColor(ctx, UIColor.blueColor().CGColor)
            CGContextFillPath(ctx)
            CGContextStrokePath(ctx)
        }
    }
}
