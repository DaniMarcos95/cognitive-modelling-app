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
        for i in 0...recordedChord.count-1 {
            difference += abs(recordedChord[i] - recordedChord[i])
        }
        print(difference)
    }
    
    func changeStringColor(stringIndex: Int) {
        userInterface.indexToDraw = stringIndex
        userInterface.setNeedsDisplay()
    }
    
    var userInterface: UserInterface!
    let index    = 2
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
