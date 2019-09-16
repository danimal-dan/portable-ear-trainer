//
//  LessonViewController.swift
//  PortableEarTrainer
//
//  Created by Daniel Collins on 4/10/19.
//  Copyright © 2019 Daniel Collins. All rights reserved.
//

import UIKit

class LessonViewController: UIViewController, LessonDelegate {
    @IBOutlet weak var PlayButton: UIButton!
    @IBOutlet weak var CurrentPositionLabel: UILabel!
    @IBOutlet weak var CurrentScoreLabel: UILabel!

    var majorScaleLesson: MajorScaleLesson = MajorScaleLesson()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.majorScaleLesson.delegate = self
        self.majorScaleLesson.startLesson()
        PlayButton.isEnabled = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        self.majorScaleLesson.cancel()
    }

    @IBAction func onPlayButtonTap(_ sender: Any) {
        self.majorScaleLesson.playQuestionSample()
    }

    @IBAction func quitButtonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func onAnswerSelect(_ sender: Any) {
        guard let button = sender as? UIButton else {
            return
        }

        let selectedScaleDegree = Int(button.tag)
        print("scale degree selected: ", selectedScaleDegree)

        let isCorrect = self.majorScaleLesson.answerQuestion(selectedScaleDegree)

        print(isCorrect ? "CORRECT" : "WRONG")
        playAnswerResponseAnimation(isCorrect) { _ in
            self.majorScaleLesson.loadNextQuestion()
        }
    }

    func playAnswerResponseAnimation(_ isCorrect: Bool, onComplete: ((Bool) -> Void)? = nil) {
        let originalColor = self.view.backgroundColor ?? nil
        let responseColor: UIColor = isCorrect ? UIColor.green : UIColor.red
        UIView.animate(withDuration: 0.4, animations: {
            self.view.backgroundColor = responseColor
        }, completion: { (_: Bool) in
            UIView.animate(withDuration: 0.1, animations: {
                self.view.backgroundColor = originalColor
            }, completion: onComplete)
        })
    }

    func currentQuestionDidChange(currentQuestion: Question, index: Int) {
        self.CurrentPositionLabel.text = "Question \(index + 1) of \(self.majorScaleLesson.getTotalQuestions())"
//        do {
//            try currentQuestion.playSample()
//        } catch {
//            print("should be fine...")
//        }
    }

    func answerCollectionDidChange(answerCollection: [Bool]) {
        let numberCorrect = answerCollection.filter({ (isCorrect) -> Bool in
            return isCorrect == true
        }).count
        let totalAnswers = answerCollection.count

        if totalAnswers == 0 {
            return
        }

        let percentage = ((Double(numberCorrect) / Double(totalAnswers)) * 100).rounded()

        self.CurrentScoreLabel.text = "Score: \(Int(percentage))% (\(numberCorrect) of \(totalAnswers))"
    }

    deinit {
        print("deinit quizview")
    }
}
