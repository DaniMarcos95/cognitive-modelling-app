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

var elapsedTime = 0.0
var score = 0.0
var chordBeingPlayed = "Nothing yet"
var correctStrings = [false, false, false, false, false, false]

class ViewController2: UIViewController, TunerDelegate{
    func compareChord(recordedChord: [Double]) {
        difference = 0
        score = 0
        correctStrings = [false, false, false, false, false, false]
        //let originalChord = [82.4, 130.8, 155.56, 196.00, 261.94, 329.63]
        end = DispatchTime.now()
        let scaleTime = 1000000000.0
        elapsedTime = Double(Double(end.uptimeNanoseconds)/scaleTime - Double(start.uptimeNanoseconds)/scaleTime)
        
        print("Total time: \(elapsedTime)")
        print("Recorded chord: \(recordedChord)")
        if elapsedTime > 10{
            score += 30*(elapsedTime-10)
        }
        for i in 0...recordedChord.count-1 {
            let new_difference = abs(recordedChord[i] - userInterface.chordToCompare[i])
            difference += new_difference
            if new_difference > 5{
                score += 10*difference
                correctStrings[i] = false
                print("false: \(correctStrings)")
            }else{
                correctStrings[i] = true
                print("correct: \(correctStrings)")
            }
        }
        score = 1 - (score/1700)
        if score < 0{
            score = 0.01
        }
        print("Score: \(score)")
        testing().updateModel(accuracyScore: score)
        continueButton.isHidden = false
        //feedbackButton.isHidden = false
        tuner.stopMonitoring()
    }
    
    func changeStringColor(stringIndex: Int) {
        userInterface.indexToDraw = stringIndex
        userInterface.setNeedsDisplay()
    }
    
  
    
    @IBAction func continuePressed(_ sender: Any) {
    }
    
    var userInterface: UserInterface!
    let index    = 2
    
    fileprivate var timer:      Timer?
    let tuner = Tuner()
    var difference = 0.0
    var showchunk = Chunk(s: "please", m: cogmod)
    
    @IBOutlet weak var continueButton: UIButton!
    
    var start = DispatchTime.now()
    var end = DispatchTime.now()
    @IBOutlet weak var chordName: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //feedbackButton.isHidden = true
        start = DispatchTime.now()
        continueButton.isHidden = true
        userInterface = UserInterface(frame: CGRect(x: 53, y: 190, width: 269, height: 400))
        userInterface.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.6)
        view.addSubview(userInterface)
        
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self,
                                     selector: #selector(startRoutine),
                                     userInfo: nil,
                                     repeats: false)
    }
    
    @objc func startRoutine() {
        tuner.delegate = self
        chordName.text = StartCogMod()
        chordBeingPlayed = chordName.text!
        userInterface.setNeedsDisplay()
        tuner.startRecordingChord()
    }
    
    func StartCogMod() -> String {
        showchunk = testing().nextORnew()!
        userInterface.chordToPresent = showchunk.name
        return showchunk.name
    }

}
