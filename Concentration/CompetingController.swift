//
//  CompetingController.swift
//  Concentration
//
//  Created by D. Marcos Mazon on 3/29/19.
//  Copyright © 2019 Daniel Marcos. All rights reserved.
//

import Foundation
import UIKit
import AudioKit

class CompetingController: UIViewController, TunerDelegate{
    func compareChord(recordedChord: [Double]) {
        difference = 0
        score = 0
        correctStrings = []
        end = DispatchTime.now()
        let scaleTime = 1000000000.0
        elapsedTime = Double(Double(end.uptimeNanoseconds)/scaleTime - Double(start.uptimeNanoseconds)/scaleTime) - 2.5

        if elapsedTime > 20{
            score += 30*(elapsedTime-20)
        }
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
        
        if displayScore == 1.0  && elapsedTime < 12{
            feedbackmessage = "Perfect! Well Done!"
        }else if displayScore == 1.0  && elapsedTime >= 12{
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
        
        if playerIndex == 1{
            player1.overallScore += displayScore
        }else{
            player2.overallScore += displayScore
        }
        
        gameIndex += 1
        if playerIndex == 1{
            playerIndex = 2
        }else{
            playerIndex = 1
        }
        if(gameIndex == 10){
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let nextViewController = storyboard.instantiateViewController(withIdentifier: "WinnerController") as! WinnerController
            self.present(nextViewController, animated: true, completion: nil)
            tuner.stopMonitoring()
        }else{
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let nextViewController = storyboard.instantiateViewController(withIdentifier: "CompetingController") as! CompetingController
            self.present(nextViewController, animated: true, completion: nil)
            tuner.stopMonitoring()
        }
        
    }
    
    func changeStringColor(stringIndex: Int) {
        userInterface.indexToDraw = stringIndex
        userInterface.setNeedsDisplay()
    }
    
    
    var userInterface: UserInterface!
    let index    = 2
    
    fileprivate var timer:      Timer?
    fileprivate var infoPlayerTimer:      Timer?
    let tuner = Tuner()
    var difference = 0.0
    
    @IBOutlet weak var infoPlayer: UITextField!
    @IBOutlet weak var continueButton: UIButton!
    
    @IBAction func continueButton(_ sender: UIButton) {
        gameIndex += 1
        if playerIndex == 1{
            playerIndex = 2
        }else{
            playerIndex = 1
        }
        if(gameIndex == 10){
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let nextViewController = storyboard.instantiateViewController(withIdentifier: "WinnerController") as! WinnerController
            self.present(nextViewController, animated: true, completion: nil)
            tuner.stopMonitoring()
        }else{
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let nextViewController = storyboard.instantiateViewController(withIdentifier: "CompetingController") as! CompetingController
            self.present(nextViewController, animated: true, completion: nil)
            tuner.stopMonitoring()
        }
    }
    
    @IBOutlet weak var Eplay: UITextField!
    @IBOutlet weak var Aplay: UITextField!
    @IBOutlet weak var Dplay: UITextField!
    @IBOutlet weak var Gplay: UITextField!
    @IBOutlet weak var Bplay: UITextField!
    @IBOutlet weak var Esplay: UITextField!
    
    var start = DispatchTime.now()
    var end = DispatchTime.now()
    @IBOutlet weak var chordName: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if playerIndex == 1{
            infoPlayer.text = "\(player1.name)'s turn"
        }else{
            infoPlayer.text = "\(player2.name)'s turn"
        }
        start = DispatchTime.now()
        userInterface = UserInterface(frame: CGRect(x: 53, y: 190, width: 269, height: 400))
        userInterface.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.6)
        view.addSubview(userInterface)
        chordName.isHidden = true
        
        infoPlayerTimer = Timer.scheduledTimer(timeInterval: 2.5, target: self,
                                     selector: #selector(hidePlayer),
                                     userInfo: nil,
                                     repeats: false)
        timer = Timer.scheduledTimer(timeInterval: 2.5, target: self,
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
    
    @objc func hidePlayer() {
        infoPlayer.isHidden = true
        chordName.isHidden = false
    }
    
    @objc func startRoutine() {
        tuner.delegate = self
        if gameIndex < 10{
            chordBeingPlayed = setOfChords[gameIndex]
        }
        chordName.text = chordBeingPlayed
        userInterface.chordToPresent = chordBeingPlayed
        userInterface.setNeedsDisplay()
        tuner.startRecordingChord()
        var index = 0
        for chord in chordNamesDataset{
            if chord == chordBeingPlayed{
                index = chordNamesDataset.firstIndex(of: chord)!
            }
        }
        let string = x_0_strings[index]
        OX(E: string[0], A: string[1], D: string[2], G: string[3], B: string[4], es: string[5])
    }
}
