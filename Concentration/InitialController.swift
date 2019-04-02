//
//  InitialController.swift
//  Concentration
//
//  Created by D. Marcos Mazon on 01/04/2019.
//  Copyright © 2019 Daniel Marcos. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

class InitialController: UIViewController {
    
    fileprivate var timer:      Timer?
    var audioPlayer = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let initSound = Bundle.main.path(forResource: "intro_sound", ofType: "mp3")
        
        do{
            audioPlayer  = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: initSound!))
        }catch{
            print("Error playing sound")
        }
        
        audioPlayer.play()
        
        timer = Timer.scheduledTimer(timeInterval: 4.2, target: self,
                                     selector: #selector(startApplication),
                                     userInfo: nil,
                                     repeats: false)
    }
    
    @objc func startApplication(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let nextViewController = storyboard.instantiateViewController(withIdentifier: "ViewControllerUser") as! ViewControllerUser
        self.present(nextViewController, animated: true, completion: nil)
    }
}

