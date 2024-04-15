//
//  SplashViewController.swift
//  Corse Enroll Hub
//
//  Created by AGRAJA GOTTIPATI on 3/28/24.
//

import UIKit
import FirebaseAuth

class SplashViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        perform(#selector(moveToView), with: nil, afterDelay: 3)
    }
    
    
    @objc func moveToView() -> Void {
        
        if Auth.auth().currentUser == nil {
            
            self.performSegue(withIdentifier: "splashToLogin", sender: self)
        }else {
            
            self.performSegue(withIdentifier: "splashToTabbar", sender: self)
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
