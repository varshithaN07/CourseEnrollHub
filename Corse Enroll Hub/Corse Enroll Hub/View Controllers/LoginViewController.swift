//
//  LoginVC.swift
//  Corse Enroll Hub
//
//  Created by Varshitha Nalluri on 2/23/24.
//

import UIKit
import SVProgressHUD
import Lottie
import AnimatedGradientView
import AVFoundation

class LoginViewController: UIViewController {

   
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    var audioPlayer: AVAudioPlayer?
    var timer: Timer?
    override func viewDidLoad() {
        super.viewDidLoad()
        let session = AVAudioSession.sharedInstance()
                do {
                    try session.setCategory(.playback, mode: .default)
                } catch {
                    print("Error setting up audio session: \(error.localizedDescription)")
                }
                
                // Load audio file
                if let path = Bundle.main.path(forResource: "ring", ofType: "mp3") {
                    let url = URL(fileURLWithPath: path)
                    do {
                        audioPlayer = try AVAudioPlayer(contentsOf: url)
                        audioPlayer?.prepareToPlay()
                    } catch {
                        print("Error loading audio file: \(error.localizedDescription)")
                    }
                }
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = true
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
                self.applyGradientBdfground()
            
        
    }
    override func viewDidLayoutSubviews() {
            super.viewDidLayoutSubviews()
            self.view.subviews.first?.frame = self.view.bounds
        }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func login(_ sender: Any) {
        
        AudioServicesPlaySystemSound(SystemSoundID(1104))

        if emailTF.text == "" {
            
            self.showAlert(str: "enter email")
        }else if passwordTF.text == "" {
            
            self.showAlert(str: "enter password")
        }else {
            
            SVProgressHUD.show()
            AuthenticationManager.shared.signIn(email: emailTF.text!,
                                                password: passwordTF.text!) { error, Success in
                
                if !Success {
                    
                    SVProgressHUD.dismiss()
                    self.showAlert(str: error?.localizedDescription ?? "")
                }else {
                    
                    SVProgressHUD.dismiss()
                    self.performSegue(withIdentifier: "loginToTabbar", sender: self)
                }
            }
        }
        
        
    }
    
    func applyGradientBdfground(){
            let _: CAGradientLayerType = .axial
            let _: AnimatedGradientViewDirection = .down
            let animatedGradient = AnimatedGradientView(frame: self.view.bounds)
            animatedGradient.animationValues = [
                (colors: ["#FFA07A", "#FF6347"], direction: .up, type: .conic),
                (colors: ["#20B2AA", "#87CEFA"], direction: .right, type: .axial),
                (colors: ["#9370DB", "#6A5ACD"], direction: .down, type: .conic),
                (colors: ["#8B4513", "#FF8C00"], direction: .left, type: .axial)
            ]
            self.view.insertSubview(animatedGradient, at: 0)
            
        }
}
