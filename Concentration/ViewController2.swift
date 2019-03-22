//
//  ViewController2.swift
//  Concentration
//
//  Created by D. Marcos Mazon on 22/03/2019.
//  Copyright © 2019 Daniel Marcos. All rights reserved.
//

import Foundation
import UIKit
import AudioKit

class ViewController2: UIViewController, TunerDelegate{
    func compareChord(recordedChord: [Double]) {
        difference = 0
        score = 0
        let originalChord = [82.4, 130.8, 155.56, 196.00, 261.94, 329.63]
        for i in 0...recordedChord.count-1 {
            difference += abs(recordedChord[i] - originalChord[i])
            print(difference)
            if difference > 3{
                print("hello")
                score += difference
            }
        }
        score = 1 - (score/1500)
        if score < 0{
            score = 0
        }
        print(score)
    }
    
    func changeStringColor(stringIndex: Int) {
        userInterface.indexToDraw = stringIndex
        print(stringIndex)
        userInterface.setNeedsDisplay()
    }
    
    var userInterface: UserInterface!
    let index    = 2
    var score = 0.0
    fileprivate var timer:      Timer?
    let tuner = Tuner()
    var difference = 0.0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userInterface = UserInterface(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
        
        view.addSubview(userInterface)
        
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self,
                                     selector: #selector(startRoutine),
                                     userInfo: nil,
                                     repeats: false)
    }
    
    @objc func startRoutine() {
        tuner.delegate = self
        tuner.startRecordingChord()
    }

}
