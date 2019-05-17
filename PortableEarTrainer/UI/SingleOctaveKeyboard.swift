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
    @IBInspectable var activeKeys: String = ""

    var activeKeyIndexes: [Int] = []

    var stackView: UIStackView!
    var initialized = false

    enum KeyType {
        case white
        case black
    }

    var keyLayout: [KeyType] = [
        .white,
        .black,
        .white,
        .black,
        .white,
        .white,
        .black,
        .white,
        .black,
        .white,
        .black,
        .white,
        .white
    ]

    convenience init(activeKeys: String) {
        self.init()
        self.activeKeys = activeKeys
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        activeKeyIndexes = activeKeys.split(separator: ",").map({ s in
            Int(s.trimmingCharacters(in: .whitespaces)) ?? -1
        })

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

        var currentWhiteKeyOffset: CGFloat = 0.0
        for (index, keyType) in keyLayout.enumerated() {
            let isActive = activeKeyIndexes.contains(index)
            if .white == keyType {
                let whiteKeyView = initWhiteKey(whiteKeySize, active: isActive)
                whiteKeyView.frame = whiteKeyView.frame.offsetBy(dx: currentWhiteKeyOffset, dy: 0)
                layer.addSublayer(whiteKeyView)

                currentWhiteKeyOffset += whiteKeyWidth
            } else {
                let blackKeyView = initBlackKey(blackKeySize, active: isActive)
                blackKeyView.frame = blackKeyView.frame.offsetBy(dx: currentWhiteKeyOffset - (blackKeySize.width / 2.0), dy: 0)
                layer.addSublayer(blackKeyView)
            }
        }
    }

    func initWhiteKey(_ size: CGSize, active: Bool) -> CAShapeLayer {
        let key = CAShapeLayer()
        key.fillColor = active ? UIColor.blue.cgColor : UIColor.white.cgColor
        key.borderColor = UIColor.darkGray.cgColor
        key.borderWidth = 2.0
        key.frame = CGRect(size: size)
        key.bounds = CGRect(size: size)
        key.path = UIBezierPath(rect: key.bounds).cgPath

        return key
    }

    func initBlackKey(_ size: CGSize, active: Bool) -> CAShapeLayer {
        let key = CAShapeLayer()

        key.fillColor = active ? UIColor.blue.cgColor : UIColor.black.cgColor
        key.borderColor = UIColor.black.cgColor
        key.borderWidth = 2.0
        key.frame = CGRect(size: size)
        key.bounds = CGRect(size: size)
        key.path = UIBezierPath(rect: key.bounds).cgPath
        key.zPosition = 2

        return key
    }
}
