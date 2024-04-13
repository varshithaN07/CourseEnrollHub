//
//  SplashViewController.swift
//  Corse Enroll Hub
//
//  Created by AGRAJA GOTTIPATI on 3/28/24.
//

import UIKit

class SplashViewController: UIViewController {
    private let delayDuration: TimeInterval = 3.0
    private var activityIndicator: UIActivityIndicatorView?

    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator?.center = view.center
        view.addSubview(activityIndicator!)
        activityIndicator?.startAnimating()
        view.isUserInteractionEnabled = false
        navigateToLoginAfterDelay()
    }

    private func navigateToLoginAfterDelay() {
        DispatchQueue.main.asyncAfter(deadline: .now() + delayDuration) {
            self.performSegue(withIdentifier: "splashToLogin", sender: self)
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "splashToLogin" {
            activityIndicator?.stopAnimating()
            view.isUserInteractionEnabled = true
        } else {
            print("Unexpected segue: \(String(describing: segue.identifier))")
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
