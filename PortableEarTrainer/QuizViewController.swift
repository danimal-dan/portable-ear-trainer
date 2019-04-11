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
        
        print("scale degree selected: ", button.tag)
    }
}
