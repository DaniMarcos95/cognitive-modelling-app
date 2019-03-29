//
//  ViewControllerUser.swift
//  
//
//  Created by D. Marcos Mazon on 29/03/2019.
//

import UIKit

class ViewControllerUser: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBOutlet weak var UsernameRegister: UITextField!
    @IBOutlet weak var itsAButton: UIButton!
    
    
    @IBAction func signInButton(_ sender: UIButton) {
        print(UsernameRegister.text)
        let AString: String = UsernameRegister.text!
        ModelComm().takeInput(TheInput: AString)
    }
    
    
    @IBAction func resetUserbutton(_ sender: Any) {
        testing().resetUsers()
    }
    
    /*
     print(UsernameRegister.text)
     itsAButton.isHidden = true
     
     
     */
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

