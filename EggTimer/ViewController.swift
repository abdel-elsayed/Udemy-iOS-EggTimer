//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var player: AVAudioPlayer!
    @IBOutlet weak var progressBarView: UIProgressView!
    @IBOutlet weak var timerLabel: UILabel!
    
    let hardness = ["Soft": 3, "Medium": 5*60 , "Hard": 7*60]
    var totalTime = 0
    var secondsPassed = 0
    var timer : Timer? = nil

    
    @IBAction func hardnessSelected(_ sender: UIButton) {
      
        guard let hardnessWord = sender.currentTitle else {return}
        timer?.invalidate()
        
        // resetting all the variables to start over the timer for a different hardeness
        progressBarView.progress = 0
        secondsPassed = 0
        totalTime = hardness[hardnessWord]!
        
        timerLabel.text = hardnessWord
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
    }
    
    @objc func updateCounter() {
        if secondsPassed < totalTime {
            secondsPassed += 1
            progressBarView.progress = Float(secondsPassed) / Float(totalTime)
        } else{
            // if the timer is up
            timer?.invalidate()
            progressBarView.progress = 0
            timerLabel.text = "DONE"
         
            //playing the alarm sound once done
            let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
            player = try! AVAudioPlayer(contentsOf: url!)
            player.play()
        
        }
    }
}
