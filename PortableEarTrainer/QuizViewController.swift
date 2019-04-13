//
//  QuizViewController.swift
//  PortableEarTrainer
//
//  Created by Daniel Collins on 4/10/19.
//  Copyright © 2019 Daniel Collins. All rights reserved.
//

import UIKit

class QuizViewController: UIViewController, QuizDelegate {
    @IBOutlet weak var PlayButton: UIButton!
    @IBOutlet weak var CurrentPositionLabel: UILabel!
    @IBOutlet weak var CurrentScoreLabel: UILabel!
    
    var majorScaleQuiz : MajorScaleQuiz = MajorScaleQuiz()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.majorScaleQuiz.delegate = self;
        PlayButton.isEnabled = true;
    }
    
    @IBAction func onPlayButtonTap(_ sender: Any) {
        self.majorScaleQuiz.playQuestionSample();
    }

    @IBAction func onAnswerSelect(_ sender: Any) {
        guard let button = sender as? UIButton else {
            return
        }
        
        let selectedScaleDegree = Int(button.tag);
        print("scale degree selected: ", selectedScaleDegree);
        
        let isCorrect = self.majorScaleQuiz.answerQuestion(selectedScaleDegree);
        
        print(isCorrect ? "CORRECT" : "WRONG");
        playAnswerResponseAnimation(isCorrect);
    }
    
    func playAnswerResponseAnimation(_ isCorrect : Bool) {
        let originalColor = self.view.backgroundColor ?? nil;
        let responseColor : UIColor = isCorrect ? UIColor.green : UIColor.red;
        UIView.animate(withDuration: 0.4, animations: {
            self.view.backgroundColor = responseColor;
        }) {
            (_: Bool) in
            UIView.animate(withDuration: 0.1, animations: {
                self.view.backgroundColor = originalColor;
            })
        }
    }
    
    func currentQuestionDidChange(currentQuestion: MajorScaleQuestion, index: Int) {
        self.CurrentPositionLabel.text = "Question \(index + 1) of \(self.majorScaleQuiz.getTotalQuestions())";
    }
    
    func answerCollectionDidChange(answerCollection: [Bool]) {
        let numberCorrect = answerCollection.filter({
            (isCorrect) -> Bool in
            return isCorrect == true;
        }).count;
        let totalAnswers = answerCollection.count;
        
        let percentage = round((Double(numberCorrect) / Double(totalAnswers)) * 100);
        
        self.CurrentScoreLabel.text = "Score: \(percentage)% (\(numberCorrect) of \(totalAnswers))";
    }
}
