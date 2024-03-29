//
//  SplashViewController.swift
//  Corse Enroll Hub
//
//  Created by AGRAJA GOTTIPATI on 3/28/24.
//

import UIKit

class SplashViewController: UIViewController {

    override func viewDidLoad() {
            super.viewDidLoad()
            
        navigateToLoginAfterDelay()
         }

         func navigateToLoginAfterDelay() {
             // Add a delay before navigating to the login screen
             DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                 // Perform segue to the login view controller
                 self.performSegue(withIdentifier: "splashToLogin", sender: self)
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
