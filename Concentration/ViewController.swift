//
//  ViewController.swift
//  Concentration
//
//  Created by Daniel Marcos on 05/02/2019.
//  Copyright © 2019 Daniel Marcos. All rights reserved.
//

import AudioKit
import UIKit

class ViewController: UIViewController, TunerDelegate {

    
    @IBOutlet var recordButton: UIButton!
    let tuner = Tuner()
    let amp_threshold = 0
    var chordTest = [Double](arrayLiteral: 1.0, 2.0, 3.0, 4.0, 5.0, 6.0)
    var recordedChord = [Double]()
    
    @IBAction func startRecording(_ sender: Any) {
        recordChord(chord: chordTest)
    }
    
    func tunerDidMeasure(frequency: Double, amplitude: Double){
        recordButton.setTitle("\(frequency)", for: .normal)
        if(amplitude > amp_threshold){
            recordedChord.append(contentsOf: frequency)
        }
    }
    
    func recordChord(chord : [Float]){
        
            tuner.delegate = self
            tuner.startMonitoring()
            
    }
    
}


