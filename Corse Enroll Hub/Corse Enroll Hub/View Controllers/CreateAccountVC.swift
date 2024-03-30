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
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = UIImage(named: "logo")
        // Do any additional setup after loading the view.
        CreateemailTF.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        CreatepasswordTF.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

        // Align text fields vertically centered in the view
        NSLayoutConstraint.activate([
            CreateemailTF.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -40),
            CreatepasswordTF.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 20)
        ])
    }
    @IBAction func CreateAccountBTN(_ sender: UIButton) {
        guard let email = CreateemailTF.text else { return }
        guard let password = CreatepasswordTF.text else { return }
        
        Auth.auth().createUser(withEmail: email, password: password) { firebaseResult, error in
            if let e = error {
                print("Error")
                print("invalid data")
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
