//
//  LessonCard.swift
//  PortableEarTrainer
//
//  Created by Daniel Collins on 5/13/19.
//  Copyright © 2019 Daniel Collins. All rights reserved.
//

import UIKit

@IBDesignable
class LessonCard: UIView {
    var backgroundLayer: CAShapeLayer!
    
    @IBInspectable
    var backgroundLayerColor: UIColor = UIColor.gray
    
    @IBInspectable
    var cornerRadius: CGFloat = 10.0

    var titleLayer: CATextLayer!
    
    @IBInspectable
    var title : String = ""
    
    @IBInspectable
    var titleColor: UIColor = UIColor.white
    
    override func layoutSubviews() {
        super.layoutSubviews()
        initBackgroundLayer()
        initTitle()
    }
    
    func initBackgroundLayer() {
        if backgroundLayer != nil {
            return;
        }
        
        backgroundLayer = CAShapeLayer()
        layer.addSublayer(backgroundLayer)
        
        let path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        backgroundLayer.path = path.cgPath
        backgroundLayer.cornerRadius = cornerRadius;
        backgroundLayer.fillColor = backgroundLayerColor.cgColor
        
        backgroundLayer.frame = layer.bounds
    }
    
    func initTitle() {
        if titleLayer != nil {
            return;
        }
        
        titleLayer = CATextLayer()
        layer.addSublayer(titleLayer)
        
        titleLayer.font = UIFont.boldSystemFont(ofSize: 24)
        titleLayer.alignmentMode = .left
        titleLayer.foregroundColor = titleColor.cgColor
        titleLayer.string = title
        titleLayer.fontSize = 24
        
        titleLayer.frame = layer.bounds.insetBy(dx: 10, dy: 10);
    }
}
