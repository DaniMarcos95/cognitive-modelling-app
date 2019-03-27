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
    
    func compareChord(recordedChord: [Double]) {
        difference = 0
        for i in 0...recordedChord.count-1 {
            difference += abs(recordedChord[i] - originalChord[i])
        }
        print(difference)
    }
    
    func changeStringColor(stringIndex: Int){
        if(stringIndex < 5){
            stringColors[stringIndex] = "Green"
            stringColors[stringIndex+1] = "Blue"
            print(stringColors)
        }else{
            stringColors[stringIndex] = "Green"
            print(stringColors)
        }
    }
    
    //@IBOutlet var recordButton: UIButton!
    
    let tuner = Tuner()
    var originalChord = [Double]()
    var difference = 0.0
    var stringColors = [String]()
    let rect = CGRect()
    let index = 2
    
    /*@IBAction func startRecording(_ sender: Any) {
        stringColors = ["Black", "Black", "Black", "Black", "Black", "Black"]
        getChord()
        
        //userInterface.draw(stringIndex: index)
        //tuner.delegate = self
        //tuner.startRecordingChord()
    }8*/
    
    func getChord(){
        originalChord = [96.0, 123.0, 45.0, 123.0, 97.0, 65.0]
    }
    
    
}



