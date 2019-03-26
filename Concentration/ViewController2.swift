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
            difference += abs(recordedChord[i] - userInterface.chordToCompare[i])
            if difference > 5{
                score += 10*difference
            }
        }
        score = 1 - (score/1500)
        if score < 0{
            score = 0.01
        }
        print("Score: \(score)")
        testing().updateModel(accuracyScore: score)
        feedbackButton.isHidden = false
        tuner.stopMonitoring()
    }
    
    func changeStringColor(stringIndex: Int) {
        userInterface.indexToDraw = stringIndex
        userInterface.setNeedsDisplay()
    }
    
  
    @IBOutlet var feedbackButton: UIButton!
    
    @IBAction func continuePressed(_ sender: Any) {
    }
    
    var userInterface: UserInterface!
    let index    = 2
    var score = 0.0
    fileprivate var timer:      Timer?
    let tuner = Tuner()
    var difference = 0.0
    var showchunk = Chunk(s: "please", m: cogmod)
    var elapsedTime = 0.0
    var start = DispatchTime.now()
    var end = DispatchTime.now()
    @IBOutlet weak var chordName: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        feedbackButton.isHidden = true
        start = DispatchTime.now()
        userInterface = UserInterface(frame: CGRect(x: 55, y: 210, width: 270, height: 400))
        view.addSubview(userInterface)
        
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self,
                                     selector: #selector(startRoutine),
                                     userInfo: nil,
                                     repeats: false)
    }
    
    @objc func startRoutine() {
        tuner.delegate = self
        chordName.text = StartCogMod()
        userInterface.setNeedsDisplay()
        tuner.startRecordingChord()
    }
    
    func StartCogMod() -> String {
        showchunk = testing().nextORnew()!
        userInterface.chordToPresent = showchunk.name
        return showchunk.name
    }

}
