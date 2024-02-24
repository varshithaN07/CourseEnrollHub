//
//  CreateAccountVC.swift
//  Corse Enroll Hub
//
//  Created by Varshitha Nalluri on 2/23/24.
//

import UIKit
import Firebase

class CreateAccountVC: UIViewController {

    
    @IBOutlet weak var CreateemailTF: UITextField!
    
    @IBOutlet weak var CreatepasswordTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func CreateAccountBTN(_ sender: UIButton) {
        guard let email = CreateemailTF.text else { return }
        guard let password = CreatepasswordTF.text else { return }
        
        Auth.auth().createUser(withEmail: email, password: password) { firebaseResult, error in
            if let e = error {
                print("Error")
            }
            else{
                self.performSegue(withIdentifier: "jumpTo", sender: self)
            }
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
