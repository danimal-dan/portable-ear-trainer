//
//  CoursesTabViewController.swift
//  PortableEarTrainer
//
//  Created by Daniel Collins on 5/21/19.
//  Copyright © 2019 Daniel Collins. All rights reserved.
//

import UIKit

class CoursesTabViewController: UIViewController, LessonSectionDelegate, LessonSectionDataSource {
    @IBOutlet weak var majorScaleLessonSection: LessonSection!
    var majorScaleLessons: [LessonCard] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        addMajorScaleLessons()
        majorScaleLessonSection.delegate = self
        majorScaleLessonSection.dataSource = self
    }

    private func addMajorScaleLessons() {
        let majorScaleLesson1 = LessonCard()
        majorScaleLesson1.frame = CGRect.init(width: 250, height: 200)
        majorScaleLesson1.bounds = CGRect.init(width: 250, height: 200)
        majorScaleLesson1.cardPadding = 20
        majorScaleLesson1.activeKeys = "0,2,4,5"
        majorScaleLesson1.title = "Major Scale"
        majorScaleLesson1.translatesAutoresizingMaskIntoConstraints = false

        let majorScaleLesson2 = LessonCard()
        majorScaleLesson2.frame = CGRect.init(width: 250, height: 200)
        majorScaleLesson2.bounds = CGRect.init(width: 250, height: 200)
        majorScaleLesson2.cardPadding = 20
        majorScaleLesson2.activeKeys = "5,7,9,11"
        majorScaleLesson2.title = "Major Scale 2"
        majorScaleLesson2.translatesAutoresizingMaskIntoConstraints = false

        majorScaleLessons.append(majorScaleLesson1)
        majorScaleLessons.append(majorScaleLesson2)
    }

    func numberOfRows(_ in: LessonSection) -> Int {
        return majorScaleLessons.count
    }

    func lessonSection(_ lessonSection: LessonSection, cardForRowAt index: Int) -> LessonCard {
        return majorScaleLessons[index]
    }

    func lessonSection(lessonSection: LessonSection, didSelectLessonAt: Int) {

    }
}
