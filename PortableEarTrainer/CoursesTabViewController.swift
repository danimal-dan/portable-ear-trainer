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
    var lessonPlanTemplates: [LessonPlanTemplate] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        do {
            let dataAsset = try LessonPlanDataAssetLoader.load()
            lessonPlanTemplates = dataAsset.data
        } catch {
            fatalError("Could not load lesson plan templates.")
        }

        addMajorScaleLessons()
        majorScaleLessonSection.delegate = self
        majorScaleLessonSection.dataSource = self
    }

    private func addMajorScaleLessons() {
        for lessonTemplate in lessonPlanTemplates[0].lessons {
            let lesson = LessonCard()
            lesson.frame = CGRect.init(width: 250, height: 200)
            lesson.bounds = CGRect.init(width: 250, height: 200)
            lesson.cardPadding = 20
            lesson.activeKeys = getActiveKeys(from: lessonTemplate)
            lesson.title = lessonTemplate.name
            lesson.translatesAutoresizingMaskIntoConstraints = false

            majorScaleLessons.append(lesson)
        }
    }

    private func getActiveKeys(from lessonTemplate: LessonTemplate) -> String {
        let scale = ScaleFactory.scaleOf(type: lessonTemplate.key.scaleType)

        let intervals = lessonTemplate.scaleDegreesToTest.map { scaleDegree in
            return scale.getIntervalFor(scaleDegree: scaleDegree)
        }

        return intervals.map({ String($0) }).joined(separator: ",")
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
