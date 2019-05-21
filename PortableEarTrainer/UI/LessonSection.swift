//
//  LessonSection.swift
//  PortableEarTrainer
//
//  Created by Daniel Collins on 5/20/19.
//  Copyright © 2019 Daniel Collins. All rights reserved.
//

import UIKit

@IBDesignable
class LessonSection: UIView {
    var lessons: [LessonCard] = []

    @IBInspectable
    var sectionPadding: CGFloat = 10.0

    var titleLabel: UILabel!

    @IBInspectable
    var title: String = ""

    @IBInspectable
    var titleColor: UIColor = UIColor.darkGray

    var scrollView: UIScrollView!

    override func layoutSubviews() {
        super.layoutSubviews()
        initTitle()
        initScrollView()
        addLessonCards()
        setupLayout()
    }

    private func initTitle() {
        if titleLabel != nil {
            return
        }

        titleLabel = UILabel()

        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        titleLabel.textAlignment = .left
        titleLabel.textColor = titleColor
        titleLabel.text = title

        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        self.addSubview(titleLabel)
    }

    private func initScrollView() {
        if scrollView != nil {
            return
        }

        scrollView = UIScrollView()
        scrollView.bounces = true
        scrollView.isDirectionalLockEnabled = true
        scrollView.alwaysBounceHorizontal = true
        scrollView.backgroundColor = UIColor.green
        scrollView.contentMode = .left
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(scrollView)
    }

    private func addLessonCards() {
        let majorScaleLesson1 = LessonCard()
        majorScaleLesson1.frame = CGRect.init(width: 250, height: 200)
        majorScaleLesson1.bounds = CGRect.init(width: 250, height: 200)
        majorScaleLesson1.cardPadding = 20
        majorScaleLesson1.activeKeys = "0,1,2,3"
        majorScaleLesson1.title = "Major Scale"
        majorScaleLesson1.translatesAutoresizingMaskIntoConstraints = false

        let majorScaleLesson2 = LessonCard()
        majorScaleLesson2.frame = CGRect.init(width: 250, height: 200)
        majorScaleLesson2.bounds = CGRect.init(width: 250, height: 200)
        majorScaleLesson2.cardPadding = 20
        majorScaleLesson2.activeKeys = "4,5,6,7"
        majorScaleLesson2.title = "Major Scale 2"
        majorScaleLesson2.translatesAutoresizingMaskIntoConstraints = false

        lessons.append(majorScaleLesson1)
        lessons.append(majorScaleLesson2)

        for lesson in lessons {
            self.scrollView.addSubview(lesson)
        }
    }

    private func setupLayout() {
        var constraints = [
            titleLabel.heightAnchor.constraint(equalToConstant: 24),
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: sectionPadding),
            titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: sectionPadding),
            titleLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: sectionPadding),

            scrollView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: sectionPadding / 2),
            scrollView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0),
            scrollView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0),
            scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0)
        ]

        var anchorOnLeft: NSLayoutXAxisAnchor = scrollView.leftAnchor
        for lesson in lessons {
            constraints.append(contentsOf: [
                lesson.widthAnchor.constraint(equalToConstant: lesson.frame.width),
                lesson.heightAnchor.constraint(equalToConstant: lesson.frame.height),
                lesson.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: sectionPadding),
                lesson.leftAnchor.constraint(equalTo: anchorOnLeft, constant: sectionPadding)
            ])

            anchorOnLeft = lesson.rightAnchor
        }

        if let lastLesson = lessons.last {
            constraints.append(contentsOf: [
                lastLesson.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: sectionPadding * -1),
                lastLesson.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: sectionPadding)
            ])
        }

        NSLayoutConstraint.activate(constraints)
    }

    override class var requiresConstraintBasedLayout: Bool {
        return true
    }
}
