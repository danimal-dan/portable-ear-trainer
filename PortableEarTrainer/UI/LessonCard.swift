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
    
    @IBInspectable
    var cardPadding: CGFloat = 10.0

    var titleLabel: UILabel!
    
    @IBInspectable
    var title : String = ""
    
    @IBInspectable
    var titleColor: UIColor = UIColor.white
    
    var keyboardView : SingleOctaveKeyboard!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        initBackgroundLayer()
        initTitle()
        initKeyboardView()
        setupLayout()
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
        if titleLabel != nil {
            return;
        }
        
        titleLabel = UILabel()
        
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        titleLabel.textAlignment = .left
        titleLabel.textColor = titleColor
        titleLabel.text = title
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(titleLabel)
    }
    
    func initKeyboardView() {
        if (keyboardView != nil) {
            return;
        }
        
        keyboardView = SingleOctaveKeyboard();
        
        keyboardView.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(keyboardView);
    }
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: cardPadding),
            titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: cardPadding),
            titleLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: cardPadding),
            
            keyboardView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: cardPadding / 2),
            keyboardView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: cardPadding),
            keyboardView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: cardPadding * -1),
            keyboardView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: cardPadding * -1)
        ])
    }
    
    override class var requiresConstraintBasedLayout: Bool {
        return true
    }
}
