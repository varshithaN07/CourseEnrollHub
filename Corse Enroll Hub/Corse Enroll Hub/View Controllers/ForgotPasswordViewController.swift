//
//  ForgotPasswordViewController.swift
//  Corse Enroll Hub
//
//  Created by Varshitha Nalluri on 3/29/24.
//

import UIKit
import SVProgressHUD
import AudioToolbox
import AVFoundation
class ForgotPasswordViewController: UIViewController {
    var audioPlayer: AVAudioPlayer?
    @IBOutlet weak var emailTF: UITextField!
    override func viewDidLoad() {
        let session = AVAudioSession.sharedInstance()
                do {
                    try session.setCategory(.playback, mode: .default)
                } catch {
                    print("Error setting up audio session: \(error.localizedDescription)")
                }
                
                // Load audio file
                if let path = Bundle.main.path(forResource: "check", ofType: "mp3") {
                    let url = URL(fileURLWithPath: path)
                    do {
                        audioPlayer = try AVAudioPlayer(contentsOf: url)
                        audioPlayer?.prepareToPlay()
                    } catch {
                        print("Error loading audio file: \(error.localizedDescription)")
                    }
                }
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
        audioPlayer?.play()
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
                        AudioServicesPlaySystemSound(SystemSoundID(1105))
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


