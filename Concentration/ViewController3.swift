//
//  ViewController3.swift
//  Concentration
//
//  Created by D. Marcos Mazon on 26/03/2019.
//  Copyright © 2019 Daniel Marcos. All rights reserved.
//

import Foundation
import UIKit


var  feedbackColors = [UIColor.red, UIColor.red, UIColor.red, UIColor.red, UIColor.red, UIColor.red]

class ViewController3: UIViewController{
    
    
    @IBOutlet weak var feedbackText: UITextField!
    
    @IBOutlet weak var accuracyText: UITextField!
    
    @IBOutlet weak var timeText: UITextField!
    
    @IBOutlet weak var Eplay: UITextField!
    @IBOutlet weak var Aplay: UITextField!
    @IBOutlet weak var Dplay: UITextField!
    @IBOutlet weak var Gplay: UITextField!
    @IBOutlet weak var Bplay: UITextField!
    @IBOutlet weak var Esplay: UITextField!
    
    var userInterface: UserInterface!

    override func viewDidLoad() {
        super.viewDidLoad()
        userInterface = UserInterface(frame: CGRect(x: 98, y: 297, width: 179, height: 304))
        userInterface.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.6)
        userInterface.chordToPresent = chordBeingPlayed
        //print(chordBeingPlayed)
        userInterface.displayOption = false
        userInterface.showFeedback = true
        view.addSubview(userInterface)
        timeText.text = "Time: \(round(10*elapsedTime)/10) seconds"
        accuracyText.text = "Score: \(score)/1.0"
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
    
    func singleOX(digit: String) -> String{
        let textLayer = CATextLayer()
        textLayer.string = digit
        textLayer.foregroundColor = UIColor.white.cgColor
        textLayer.font = UIFont(name: "Avenir", size: 15.0)
        textLayer.fontSize = 15.0
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
    
}
