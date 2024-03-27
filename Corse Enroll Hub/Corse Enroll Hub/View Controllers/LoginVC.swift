//
//  LoginVC.swift
//  Corse Enroll Hub
//
//  Created by Varshitha Nalluri on 2/23/24.
//

import UIKit
import Firebase

class LoginVC: UIViewController {

    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var loginEmailTF: UITextField!
    @IBOutlet weak var loginpasswordTF: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = UIImage(named: "logo")
        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginletsgoBTN(_ sender: UIButton) {
        guard let email = loginEmailTF.text else { return }
        guard let password = loginpasswordTF.text else { return }
        
        Auth.auth().signIn(withEmail: email, password: password) { firebaseResult, error in
            if let e = error {
                print("Error")
            }
            else{
                self.performSegue(withIdentifier: "goToNext", sender: self)
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
