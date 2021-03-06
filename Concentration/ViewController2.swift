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

var feedbackmessage = " "
var elapsedTime = 0.0
var score = 0.0
var chordBeingPlayed = "Nothing yet"
var correctStrings: [Bool] = []
let Cplay = ["x", " ", " ", "o", " ", "o"]
let Gplay = [" ", " ", "o", "o", " ", " "]
let Aplay = ["x", "o", " ", " ", " ", "o"]
let Dplay = ["x", "x", "o", " ", " ", " "]
let Eplay = ["o", " ", " ", " ", "o", "o"]
let Fplay = [" ", " ", " ", " ", " ", " "]
let Amplay = ["x", "o", " ", " ", " ", "o"]
let Dmplay = ["x", "x", "o", " ", " ", " "]
let Emplay = ["o", " ", " ", "o", "o", "o"]
let x_0_strings = [Emplay, Eplay, Amplay, Aplay, Cplay, Gplay, Dplay, Dmplay, Fplay,]
var displayScore = 0.0
var nextToRecord = 0
var originalChord: [Double] = []

class ViewController2: UIViewController, TunerDelegate{
    func compareChord(recordedChord: [Double]) {
        difference = 0
        score = 0
        displayScore = 0
        correctStrings = []
        end = DispatchTime.now()
        let scaleTime = 1000000000.0
        elapsedTime = Double(Double(end.uptimeNanoseconds)/scaleTime - Double(start.uptimeNanoseconds)/scaleTime)
        
        if elapsedTime > 20{
            score += 30*(elapsedTime-20)
        }
        print(recordedChord)
        print(userInterface.chordToCompare)
        for i in 0...recordedChord.count-1 {
            let new_difference = abs(recordedChord[i] - userInterface.chordToCompare[i])
            difference += new_difference
            if new_difference > 3{
                score += 10*difference
                correctStrings.append(false)
            }else{
                correctStrings.append(true)
            }
        }

        let numStringsPlayed = correctStrings.count
        
        for item in correctStrings{
            if item == true {
                displayScore += 1.0/Double(numStringsPlayed)
            }
        }
                
        if displayScore > 0.99  && elapsedTime < 20.0{
            feedbackmessage = "Perfect! Well Done!"
        }else if displayScore > 0.99  && elapsedTime >= 20.0{
            feedbackmessage = "Well Done! Now faster."
        } else if displayScore <= 0.5{
            feedbackmessage = "WRONG, Try Again"
        }else{
            feedbackmessage = "Almost there"
        }
        
        score = 1 - (score/1700)
        if score < 0{
            score = 0.01
        }
        nextToRecord = 0
        testing().updateModel(accuracyScore: score)
        continueButton.isHidden = false
        tuner.stopMonitoring()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let nextViewController = storyboard.instantiateViewController(withIdentifier: "ViewController3") as! ViewController3
        self.present(nextViewController, animated: true, completion: nil)
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
    
    
    @IBOutlet weak var Eplay: UITextField!
    @IBOutlet weak var Aplay: UITextField!
    @IBOutlet weak var Dplay: UITextField!
    @IBOutlet weak var Gplay: UITextField!
    @IBOutlet weak var Bplay: UITextField!
    @IBOutlet weak var Esplay: UITextField!
    
    var start = DispatchTime.now()
    var end = DispatchTime.now()
    @IBOutlet weak var chordName: UITextField!
    
    @IBAction func skipButton(_ sender: UIButton) {
        score = 0.01
        feedbackmessage = "You skipped it"
        testing().updateModel(accuracyScore: score)
        correctStrings = [false, false, false, false, false, false]
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let nextViewController = storyboard.instantiateViewController(withIdentifier: "ViewController3") as! ViewController3
        self.present(nextViewController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        start = DispatchTime.now()
        continueButton.isHidden = false
        userInterface = UserInterface(frame: CGRect(x: 53, y: 190, width: 269, height: 400))
        userInterface.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.6)
        view.addSubview(userInterface)
        originalChord = userInterface.chordToCompare
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self,
                                     selector: #selector(startRoutine),
                                     userInfo: nil,
                                     repeats: false)
    }
    
    
    func singleOX(digit: String) -> String{
        let textLayer = CATextLayer()
        textLayer.string = digit
        textLayer.foregroundColor = UIColor.white.cgColor
        textLayer.font = UIFont(name: "Avenir", size: 20.0)
        textLayer.fontSize = 20.0
        textLayer.contentsScale = UIScreen.main.scale
        return digit
    }
    
    func OX(E: String, A: String, D: String, G: String, B: String, es: String) {
        Eplay.text = singleOX(digit: E)
        Aplay.text = singleOX(digit: A)
        Dplay.text = singleOX(digit: D)
        Gplay.text = singleOX(digit: G)
        Bplay.text = singleOX(digit: B)
        Esplay.text = singleOX(digit: es)
    }
    
    @objc func startRoutine() {
        tuner.delegate = self
        chordName.text = StartCogMod()
        chordBeingPlayed = chordName.text!
        userInterface.setNeedsDisplay()
        tuner.startRecordingChord()
        let chordNamesDataset = ["Em","E","Am","A","C","G","D","Dm","F"]
        var index = 0
        for chord in chordNamesDataset{
            if chord == chordBeingPlayed{
                index = chordNamesDataset.firstIndex(of: chord)!
            }
        }
        
        let string = x_0_strings[index]
        OX(E: string[0], A: string[1], D: string[2], G: string[3], B: string[4], es: string[5])
    }
    
    func StartCogMod() -> String {
        showchunk = testing().nextORnew()!
        userInterface.chordToPresent = showchunk.name
        return showchunk.name
    }

}
