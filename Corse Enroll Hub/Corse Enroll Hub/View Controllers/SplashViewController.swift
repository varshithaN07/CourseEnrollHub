//
//  SplashViewController.swift
//  Corse Enroll Hub
//
//  Created by AGRAJA GOTTIPATI on 3/28/24.
//

import UIKit
import FirebaseAuth
import Lottie
class SplashViewController: UIViewController {
    
    
    @IBOutlet weak var launchLAV: LottieAnimationView!{
        didSet {
            launchLAV.animation = .named("looo")
            launchLAV.alpha = 1
            
            launchLAV.play { [weak self] _ in
                UIViewPropertyAnimator.runningPropertyAnimator(
                    withDuration: 1,
                    delay: 0.0,
                    options: [.curveEaseInOut]
                ) {
                    self?.launchLAV.alpha = 0.0
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        perform(#selector(moveToView), with: nil, afterDelay: 10
        )
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
