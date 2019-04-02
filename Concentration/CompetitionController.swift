//
//  CompetitionController.swift
//  Concentration
//
//  Created by D. Marcos Mazon on 3/29/19.
//  Copyright © 2019 Daniel Marcos. All rights reserved.
//

import UIKit

var player1 = Competitor()
var player2 = Competitor()
var setOfChords: [String] = []
var gameIndex = 0
var playerIndex = 1

class CompetitionController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBOutlet weak var player1Name: UITextField!
    @IBOutlet weak var player2Name: UITextField!
    
    @IBAction func startCompetition(_ sender: UIButton) {
        player1.name = player1Name.text!
        player2.name = player2Name.text!
        gameIndex = 0
        let sequence = 0 ..< 9
        let shuffledSequence = sequence.shuffled()
        for index in shuffledSequence{
            setOfChords.append(chordNamesDataset[index])
            setOfChords.append(chordNamesDataset[index])
            if(setOfChords.count == 10){
                break
            }
        }
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let nextViewController = storyboard.instantiateViewController(withIdentifier: "CompetingController") as! CompetingController
        self.present(nextViewController, animated: true, completion: nil)
    }
    
}
