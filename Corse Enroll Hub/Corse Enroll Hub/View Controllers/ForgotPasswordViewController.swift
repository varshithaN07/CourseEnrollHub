//
//  ForgotPasswordViewController.swift
//  Corse Enroll Hub
//
//  Created by Varshitha Nalluri on 3/29/24.
//

import UIKit

class ForgotPasswordViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var feedbackLabel: UILabel!
    var passwordResetService: PasswordResetService?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        feedbackLabel.text = ""
    }
    
    @IBAction func cancel(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func resetPassword(_ sender: Any) {
        guard let email = emailTextField.text, !email.isEmpty else {
            feedbackLabel.text = "Please enter your email address."
            return
        }
        
        guard isValidEmail(email) else {
            feedbackLabel.text = "Please enter a valid email address."
            return
        }
        
        performPasswordReset(for: email)
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


