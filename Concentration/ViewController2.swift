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
    
    @IBOutlet weak var chordName: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userInterface = UserInterface(frame: CGRect(x: 55, y: 210, width: 270, height: 400))
        
        view.addSubview(userInterface)
        
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self,
                                     selector: #selector(startRoutine),
                                     userInfo: nil,
                                     repeats: false)
    }
    
    @objc func startRoutine() {
        tuner.delegate = self
        chordName.text = "Cm7"
        tuner.startRecordingChord()
         }

}
