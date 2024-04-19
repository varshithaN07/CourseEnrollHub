//
//  ProfileViewController.swift
//  Corse Enroll Hub
//
//  Created by AGRAJA GOTTIPATI on 4/15/24.
//
import UIKit
import FirebaseAuth
import AudioToolbox
class ProfileViewController: UIViewController {

    @IBOutlet weak var emailLBL: UILabel!
    @IBOutlet weak var nameLBL: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let user = Auth.auth().currentUser
        nameLBL.text = user?.displayName ?? ""
        emailLBL.text = user?.email ?? ""
    }
    @IBAction func logout(_ sender: Any) {
        AudioServicesPlaySystemSound(1103)
        do {
            
            try Auth.auth().signOut()
        } catch {}
        
        
        self.performSegue(withIdentifier: "profileToLogin", sender: self)
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
