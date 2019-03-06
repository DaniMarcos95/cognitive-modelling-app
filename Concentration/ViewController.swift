//
//  ViewController.swift
//  Concentration
//
//  Created by Daniel Marcos on 05/02/2019.
//  Copyright © 2019 Daniel Marcos. All rights reserved.
//

import AudioKit
import UIKit

class ViewController: UIViewController {

    
    @IBOutlet var recordButton: UIButton!
    let tuner = Tuner()
    
    @IBAction func startRecording(_ sender: Any) {
        tuner.startRecordingChord()
        //while()

    }
    
    //Call variables from tuner to see if it is done.
    
}


