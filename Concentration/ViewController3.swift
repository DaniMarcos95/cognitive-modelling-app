//
//  ViewController3.swift
//  Concentration
//
//  Created by D. Marcos Mazon on 26/03/2019.
//  Copyright © 2019 Daniel Marcos. All rights reserved.
//

import Foundation
import UIKit

class ViewController3: UIViewController{
    
    
    @IBOutlet weak var feedbackText: UITextField!
    
    @IBOutlet weak var accuracyText: UITextField!
    
    @IBOutlet weak var timeText: UITextField!
    
    
    var userInterface: UserInterface!

    override func viewDidLoad() {
        super.viewDidLoad()
        userInterface = UserInterface(frame: CGRect(x: 98, y: 297, width: 179, height: 304))
        userInterface.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.6)
        userInterface.chordToPresent = chordBeingPlayed
        userInterface.displayOption = false
        view.addSubview(userInterface)
        timeText.text = "Time: \(round(10*elapsedTime)/10) seconds"
        accuracyText.text = "Score: \(score)/1.0"
    }
}
