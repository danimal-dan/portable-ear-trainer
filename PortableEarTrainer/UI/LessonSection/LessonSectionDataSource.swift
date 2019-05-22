//
//  LessonSectionDataSource.swift
//  PortableEarTrainer
//
//  Created by Daniel Collins on 5/21/19.
//  Copyright © 2019 Daniel Collins. All rights reserved.
//

import Foundation

protocol LessonSectionDataSource: class {
    func numberOfRows(_ in: LessonSection) -> Int

    func lessonSection(_ lessonSection: LessonSection, cardForRowAt index: Int) -> LessonCard
}
