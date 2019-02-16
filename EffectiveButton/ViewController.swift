//
//  ViewController.swift
//  RoundButton
//
//  Created by me on 2019/02/17.
//  Copyright © 2019 Neosystem. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UIInputViewAudioFeedback {

    @IBOutlet weak var testButton: EffectiveButton!
    @IBAction func clickedTestButton(_ sender: Any) {
        print("Hello!")
    }
    
    public var enableInputClicksWhenVisible: Bool {
        return false
    }
    
    var clickSound: SystemSoundID!
    
    func createClickSound() -> SystemSoundID {
        var soundID: SystemSoundID = 0
        let soundURL = CFBundleCopyResourceURL(CFBundleGetMainBundle(), "click" as CFString, "mp3" as CFString, nil)
        AudioServicesCreateSystemSoundID(soundURL!, &soundID)
        return soundID
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //
        let flash = CABasicAnimation(keyPath: "opacity")
        flash.duration = 0.5
        flash.fromValue = 1
        flash.toValue = 0.1
        flash.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        flash.autoreverses = true
        flash.repeatCount = 3
        self.view.layer.add(flash, forKey: nil)

        clickSound = createClickSound()
        AudioServicesPlaySystemSound(clickSound)
        
        UIDevice.current.playInputClick()

    }


}

