//
//  ForgotPasswordViewController.swift
//  Corse Enroll Hub
//
//  Created by Varshitha Nalluri on 3/29/24.
//

import UIKit
import SVProgressHUD
import AudioToolbox
class ForgotPasswordViewController: UIViewController {
    
    @IBOutlet weak var emailTF: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func send(_ sender: Any) {
        AudioServicesPlaySystemSound(1105)
        if emailTF.text == "" {
            
            self.showAlert(str: "enter email")
        }else {
            
            SVProgressHUD.show()
            AuthenticationManager.shared.resetPassword(email: emailTF.text!) { error, success in
                
                if !success {
                    
                    SVProgressHUD.dismiss()
                    self.showAlert(str: error?.localizedDescription ?? "")
                }else {
                    
                    SVProgressHUD.dismiss()
                    let alert = UIAlertController(title: "", message: "Reset password link send to given email", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { _ in
                        
                        self.dismiss(animated: true)
                    }))
                    
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
    
    
    @IBAction func cancel(_ sender: Any) {
        AudioServicesPlaySystemSound(1104)
        self.dismiss(animated: true)
    }
    
}


