//
//  ForgotPasswordViewController.swift
//  Corse Enroll Hub
//
//  Created by Varshitha Nalluri on 3/29/24.
//

import UIKit

class ForgotPasswordViewController: UIViewController {

   
    var passwordResetService: PasswordResetService?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        feedbackLabel.text = ""
    }
    
    @IBAction func cancel(_ sender: Any) {
        self.dismiss(animated: true)
    }
   
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Z0-9a-z.-]+\\.[A-Za-z]{2,}"
        let predicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return predicate.evaluate(with: email)
    }
    
    func performPasswordReset(for email: String) {
        passwordResetService?.resetPassword(for: email) { [weak self] success, error in
            DispatchQueue.main.async {
                if success {
                    self?.feedbackLabel.text = "Password reset link has been sent to \(email)."
                } else if let error = error {
                    self?.feedbackLabel.text = "Failed to send password reset link: \(error.localizedDescription)."
                } else {
                    self?.feedbackLabel.text = "An unexpected error occurred. Please try again."
                }
            }
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


