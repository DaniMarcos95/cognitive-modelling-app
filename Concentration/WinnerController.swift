//
//  winnerController.swift
//  Concentration
//
//  Created by D. Marcos Mazon on 3/29/19.
//  Copyright © 2019 Daniel Marcos. All rights reserved.
//

import Foundation
import UIKit

class WinnerController: UIViewController{
    
    
    @IBOutlet weak var winnerText: UITextField!
    
    @IBOutlet weak var player1Score: UITextField!
    @IBOutlet weak var player2Score: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if player1.overallScore > player2.overallScore{
            winnerText.text = "\(player1.name) wins"
        }else if player1.overallScore < player2.overallScore{
            winnerText.text = "\(player2.name) wins"
        }else{
            winnerText.text = "It's a draw"
        }
        player1Score.text = "\(player1.name):\(round(100*player1.overallScore)/100)"
        player2Score.text = "\(player2.name):\(round(100*player2.overallScore)/100))"
    }
}
