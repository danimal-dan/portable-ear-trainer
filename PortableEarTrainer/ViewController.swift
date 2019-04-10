//
//  ViewController.swift
//  PortableEarTrainer
//
//  Created by Daniel Collins on 1/21/19.
//  Copyright © 2019 Daniel Collins. All rights reserved.
//

import UIKit
import AudioKit

class ViewController: UIViewController {
    @IBOutlet weak var PlayButton: UIButton!
    var majorScaleQuiz : MajorScaleQuiz = MajorScaleQuiz()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        PlayButton.isEnabled = true;
    }
    
    @IBAction func playButtonClicked(_ sender: Any) {
        do {
            print("play button tapped");
            try self.majorScaleQuiz.playSample();
        } catch {
            print("play error");
        }
    }
}

