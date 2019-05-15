//
//  SpeechTestViewController.swift
//  PortableEarTrainer
//
//  Created by Daniel Collins on 4/19/19.
//  Copyright © 2019 Daniel Collins. All rights reserved.
//

import UIKit
import AVFoundation

class SpeechTestViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    var voice = AVSpeechSynthesisVoice(language: "en-US")
    let availableVoices = AVSpeechSynthesisVoice.speechVoices()
    let synthesizer = AVSpeechSynthesizer()
    @IBOutlet weak var voicePicker: UIPickerView!

    override func viewDidLoad() {
        self.voicePicker.delegate = self
    }

    @IBAction func saySomethingTapped(_ sender: Any) {
        let utterance = AVSpeechUtterance(string: "B flat Major")
        utterance.voice = self.voice
        synthesizer.speak(utterance)
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return availableVoices.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return availableVoices[row].name
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.voice = availableVoices[row]
    }
}
