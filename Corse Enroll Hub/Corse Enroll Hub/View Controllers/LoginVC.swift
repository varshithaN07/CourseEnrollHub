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
//    {
//        didSet{
//            if((loginEmailTF) != nil){
//                loginpasswordTF.isEnabled = true
//            }
//        }
//    }
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = UIImage(named: "logo")
        // Do any additional setup after loading the view.
        loginEmailTF.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginpasswordTF.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginpasswordTF.isEnabled = true
        loginpasswordTF.isHidden = false
        // Align text fields vertically centered in the view
        NSLayoutConstraint.activate([
            loginEmailTF.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -40),
            loginpasswordTF.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 20)
            
        ])
    }
    
    @IBAction func loginletsgoBTN(_ sender: UIButton) {
        guard let email = loginEmailTF.text, !email.isEmpty else {
            presentAlert(withTitle: "Error", message: "Please enter an email.")
            return
        }
        
        guard let password = loginpasswordTF.text, !password.isEmpty else {
            presentAlert(withTitle: "Error", message: "Please enter a password.")
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { firebaseResult, error in
            if let e = error {
                self.presentAlert(withTitle: "Login Error", message: e.localizedDescription)
            } else {
                self.performSegue(withIdentifier: "goToNext", sender: self)
            }
        }
    }

    private func presentAlert(withTitle title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
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
