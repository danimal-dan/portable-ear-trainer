//
//  QuizViewController.swift
//  PortableEarTrainer
//
//  Created by Daniel Collins on 4/10/19.
//  Copyright © 2019 Daniel Collins. All rights reserved.
//

import UIKit

class QuizViewController: UIViewController {
    @IBOutlet weak var PlayButton: UIButton!
    var majorScaleQuiz : MajorScaleQuiz = MajorScaleQuiz()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        PlayButton.isEnabled = true;
    }
    
    @IBAction func onPlayButtonTap(_ sender: Any) {
        do {
            print("play button tapped");
            try self.majorScaleQuiz.playSample();
        } catch {
            print("play error");
        }
    }

    @IBAction func onAnswerSelect(_ sender: Any) {
        guard let button = sender as? UIButton else {
            return
        }
        
        let selectedScaleDegree = Int(button.tag);
        print("scale degree selected: ", selectedScaleDegree);
        
        let isCorrect = majorScaleQuiz.verifyAnswer(selectedScaleDegree);
        
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
}
