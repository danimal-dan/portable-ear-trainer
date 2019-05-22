//
//  LessonSectionDelegate.swift
//  PortableEarTrainer
//
//  Created by Daniel Collins on 5/21/19.
//  Copyright © 2019 Daniel Collins. All rights reserved.
//

import Foundation

protocol LessonSectionDelegate: class {
    func lessonSection(lessonSection: LessonSection, didSelectLessonAt: Int)
}
