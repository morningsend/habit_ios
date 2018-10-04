//
//  CircleProgress.swift
//  habitapp
//
//  Created by Zaiyang Li on 04/10/2018.
//  Copyright © 2018 smallteam. All rights reserved.
//

import Foundation
import UIKit

public protocol CircleProgressViewDelegate {
    
}

public class CircleProgressView: UIView {
    
    @IBInspectable
    public var progress: CGFloat = 0.5 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable
    public var innerRadius: CGFloat = 0.8 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable
    public var outerRadius: CGFloat = 1.0 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable
    public var color: UIColor! = UIColor.white {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable
    public var trackColor: UIColor! = UIColor(white: 0.21, alpha: 0.9) {
        didSet {
            setNeedsDisplay()
        }
    }
    
    public var delegate : CircleProgressViewDelegate? = nil
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override public func draw(_ rect: CGRect) {
        //super.draw(rect)
        let context = UIGraphicsGetCurrentContext()
        guard context != nil else {
            return
        }
        
        let square = getSquareFromRect(frame: rect.insetBy(dx: 4, dy: 4))
        
        let center: CGPoint = CGPoint(x: square.midX,
                                      y: square.midY)
        
        let innerRadius = self.innerRadius * square.width / 2.0
        let outerRadius = self.outerRadius * square.width / 2.0
        let discWidth = outerRadius - innerRadius;
        let discRadius = (outerRadius + innerRadius) / 2
        
        print("\(self.bounds)")
        print("\(rect)")
        print("\(square)")
        print("\(innerRadius)")
        print("\(outerRadius)")
        /*
        path.move(to: CGPoint(
            x: square.midX,
            y: square.minY
        ))
        */
        let angleOffset = CGFloat.pi * -0.5
        let endAngle = CGFloat.pi * 2 * progress
        
        let path = CGMutablePath()
        let backgroundPath = CGMutablePath()
        
        backgroundPath.addArc(center: center,
                    radius: discRadius,
                    startAngle: 0,
                    endAngle: CGFloat.pi * 2.0,
                    clockwise: false)
        
        //path.move(to: center)
        
        path.addArc(center: center,
                    radius: discRadius,
                    startAngle: angleOffset,
                    endAngle: endAngle + angleOffset,
                    clockwise: false)
        
        let discPath = path.copy(strokingWithWidth: discWidth,
                  lineCap: .round,
                  lineJoin: .miter,
                  miterLimit: 10)
        
        let backgroundDiscPath = backgroundPath.copy(strokingWithWidth: discWidth,
                                       lineCap: .round,
                                       lineJoin: .miter,
                                       miterLimit: 10)
        
        context!.addPath(backgroundDiscPath)
        context!.setFillColor(trackColor.cgColor)
        context?.drawPath(using: .fill)

        context!.addPath(discPath)
        context!.setFillColor(color.cgColor)
        context?.drawPath(using: .fill)
        
        context?.flush()
    }
    
    func getSquareFromRect(frame: CGRect) -> CGRect {
        if(frame.width == frame.height) {
            return frame;
        }
        
        let length = min(frame.width, frame.height)
        var x : CGFloat = frame.origin.x
        var y : CGFloat = frame.origin.y
        
        if(frame.width > frame.height) {
            x = x + (frame.width - frame.height) / 2.0
        } else if(frame.height > frame.width) {
            y = y + (frame.height - frame.width) / 2.0
        }
        
        return CGRect(origin: CGPoint(x: x, y: y), size: CGSize(width: length, height: length))
    }
}
