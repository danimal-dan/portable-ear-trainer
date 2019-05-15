//
//  SingleOctaveKeyboard.swift
//  PortableEarTrainer
//
//  Created by Daniel Collins on 5/13/19.
//  Copyright © 2019 Daniel Collins. All rights reserved.
//

import UIKit

@IBDesignable
class SingleOctaveKeyboard: UIView {
    var stackView: UIStackView!
    var initialized = false

    override func layoutSubviews() {
        super.layoutSubviews()
        if initialized == false {
            initKeys()
        }

        initialized = true
    }

    func initKeys() {
        let layerWidth = layer.bounds.width
        let layerHeight = layer.bounds.height
        let whiteKeyWidth = layerWidth / 8.0
        let whiteKeySize = CGSize(width: whiteKeyWidth, height: layerHeight)
        let blackKeySize = CGSize(width: whiteKeyWidth / 2.0, height: layerHeight / 1.6)

        for index in 0...7 {
            let xOffset = whiteKeyWidth * CGFloat(index)

            let whiteKeyView = initWhiteKey(whiteKeySize)
            whiteKeyView.frame = whiteKeyView.frame.offsetBy(dx: xOffset, dy: 0)
            layer.addSublayer(whiteKeyView)

            if index != 0 && index != 3 && index != 7 {
                let blackKeyView = initBlackKey(blackKeySize)
                blackKeyView.frame = blackKeyView.frame.offsetBy(dx: xOffset - (blackKeySize.width / 2.0), dy: 0)
                layer.addSublayer(blackKeyView)
            }
        }
    }

    func initWhiteKey(_ size: CGSize) -> CAShapeLayer {
        let key = CAShapeLayer()
        key.fillColor = UIColor.white.cgColor
        key.borderColor = UIColor.darkGray.cgColor
        key.borderWidth = 2.0
        key.frame = CGRect(size: size)
        key.bounds = CGRect(size: size)
        key.path = UIBezierPath(rect: key.bounds).cgPath

        return key
    }

    func initBlackKey(_ size: CGSize) -> CAShapeLayer {
        let key = CAShapeLayer()
        key.fillColor = UIColor.black.cgColor
        key.borderColor = UIColor.black.cgColor
        key.borderWidth = 2.0
        key.frame = CGRect(size: size)
        key.bounds = CGRect(size: size)
        key.path = UIBezierPath(rect: key.bounds).cgPath

        return key
    }
}
