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
    fileprivate var timer:      Timer?
    var chordTest = [Float](arrayLiteral: 1.0, 2.0, 3.0, 4.0, 5.0, 6.0)
    
    @IBAction func startRecording(_ sender: Any) {
        recordChord(chord: chordTest)
    }
    
    func tunerDidMeasure(frequency: Double){
        recordButton.setTitle("\(frequency)", for: .normal)
        
    }
    
    func recordChord(chord : [Float]){
        
        
        //for note in chord {
            tuner.delegate = self
          //  print(note)
            tuner.startMonitoring()
            //tuner.stopMonitoring()
       // }
    }
    
}


