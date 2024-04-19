//
//  AddCourseViewController.swift
//  Corse Enroll Hub
//
//  Created by AGRAJA GOTTIPATI on 4/15/24.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth
import SVProgressHUD
import AudioToolbox
import AVKit
import AVFoundation
import Lottie
struct CourseModel: Codable {
    
    var name: String?
    var id: String?
    
    init() {}
}

struct ProfessorModel: Codable {
    
    var name: String?
    var id: String?
    
    init() {}
}

struct SectionModel: Codable {
    
    var timings: String?
    var id: String?
    
    init() {}
}


class AddCourseViewController: UIViewController {
    
    var audioPlayer: AVAudioPlayer?
    var timer: Timer?
   // @IBOutlet weak var LaunchLAV: LottieAnimationView!
    @IBOutlet weak var courseBTN: UIButton!
    @IBOutlet weak var professorBtn: UIButton!
    @IBOutlet weak var sectionBtn: UIButton!
   
    
    @IBOutlet weak var saveBtn: UIButton!
    
    var coursesList: [CourseModel] = []
    var selectedCourse: CourseModel?
    
    var professorsList: [ProfessorModel] = []
    var selectedProfessor: ProfessorModel?
    
    var sectionsList: [SectionModel] = []
    var selectedSection: SectionModel?
    
    override func viewDidLoad() {
        let session = AVAudioSession.sharedInstance()
                do {
                    try session.setCategory(.playback, mode: .default)
                } catch {
                    print("Error setting up audio session: \(error.localizedDescription)")
                }
                
                // Load audio file
                if let path = Bundle.main.path(forResource: "Ring (1)", ofType: "mp3") {
                    let url = URL(fileURLWithPath: path)
                    do {
                        audioPlayer = try AVAudioPlayer(contentsOf: url)
                        audioPlayer?.prepareToPlay()
                    } catch {
                        print("Error loading audio file: \(error.localizedDescription)")
                    }
                }
       super.viewDidLoad()
        super.viewDidLoad()
        
        professorBtn.isHidden = true
        sectionBtn.isHidden = true
//        timeTF.isHidden = true
        saveBtn.isHidden = true
        
        // Do any additional setup after loading the view.
        self.getCoursesList()
        self.tabBarController?.tabBar.isHidden = true
        
    }
    
    func getCoursesList() -> Void {
        
        let database = Firestore.firestore()
        
        
        SVProgressHUD.show()
        let docRef = database.collection("courses")
        docRef.addSnapshotListener { (querySnapshot, err) in
            if let err = err {
                
                SVProgressHUD.dismiss()
                print("Error getting documents: \(err)")
                
            } else {
                
                self.coursesList.removeAll()
                
                SVProgressHUD.dismiss()
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                    
                    let data = document.data()
                    
                    var course = CourseModel()
                    course.id = document.documentID
                    course.name = data["name"] as? String ?? ""
                    
                    self.coursesList.append(course)
                }
                
                self.setupCoursesPopUpButton()
            }
        }
    }
    
    
    func setupCoursesPopUpButton() {
        
        var optionsArray = [UIAction]()
        for course in coursesList {
            
            let action = UIAction(title: course.name ?? "", state: .off, handler: { (action: UIAction) in
                
                print("Pop-up action")
                print(action.title)
                
                if let index = self.coursesList.firstIndex(where: { $0.name == action.title }) {
                    
                    self.selectedCourse = self.coursesList[index]
                    self.getCoursesProfessorsList()
                }
            })
            optionsArray.append(action)
        }
        
        let optionsMenu = UIMenu(title: "", options: .displayInline, children: optionsArray)
        courseBTN.menu = optionsMenu
        
        let option0 = optionsArray[0]
        if let index = self.coursesList.firstIndex(where: { $0.name == option0.title }) {
            
            self.selectedCourse = self.coursesList[index]
            self.getCoursesProfessorsList()
        }
    }
    
    
    func setupProfessorsPopUpButton() {
        
        if professorsList.count > 0 {
            
            var optionsArray = [UIAction]()
            for professor in professorsList {
                
                let action = UIAction(title: professor.name ?? "", state: .off, handler: { (action: UIAction) in
                    
                    print("Pop-up action")
                    print(action.title)
                    
                    if let index = self.professorsList.firstIndex(where: { $0.name == action.title }) {
                        
                        self.selectedProfessor = self.professorsList[index]
                        self.getSectionsForCoursesProfessorsList()
                    }
                })
                optionsArray.append(action)
            }
            
            let optionsMenu = UIMenu(title: "", options: .displayInline, children: optionsArray)
            professorBtn.menu = optionsMenu
            
            professorBtn.isHidden = false
            
            
            let option0 = optionsArray[0]
            if let index = self.professorsList.firstIndex(where: { $0.name == option0.title }) {
                
                self.selectedProfessor = self.professorsList[index]
                self.getSectionsForCoursesProfessorsList()
            }
        }
    }
    
    
    func getCoursesProfessorsList() -> Void {
        
        let database = Firestore.firestore()
        let id = selectedCourse?.id ?? ""
        
        let docRef = database.collection("professors")
            .whereField("coursesTeaching", arrayContains: id)
        
        SVProgressHUD.show()
        docRef.addSnapshotListener { (querySnapshot, err) in
            if let err = err {
                
                SVProgressHUD.dismiss()
                print("Error getting documents: \(err)")
                
            } else {
                
                SVProgressHUD.dismiss()
                self.professorsList.removeAll()
                
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                    
                    let data = document.data()
                    
                    var professor = ProfessorModel()
                    professor.id = document.documentID
                    professor.name = data["name"] as? String ?? ""
                    
                    self.professorsList.append(professor)
                }
                
                self.setupProfessorsPopUpButton()
            }
        }
    }
    
    
    func setupSectionPopUpButton() {
        
        if sectionsList.count > 0 {
            
            var optionsArray = [UIAction]()
            for section in sectionsList {
                
                let action = UIAction(title: section.timings ?? "", state: .off, handler: { (action: UIAction) in
                    
                    print("Pop-up action")
                    print(action.title)
                    
                    if let index = self.sectionsList.firstIndex(where: { $0.timings == action.title }) {
                        
                        self.selectedSection = self.sectionsList[index]
                        
                    }
                })
                optionsArray.append(action)
            }
            
            let optionsMenu = UIMenu(title: "", options: .displayInline, children: optionsArray)
            sectionBtn.menu = optionsMenu
            
            sectionBtn.isHidden = false
            saveBtn.isHidden = false
            
            let option0 = optionsArray[0]
            if let index = self.sectionsList.firstIndex(where: { $0.timings == option0.title }) {
                
                self.selectedSection = self.sectionsList[index]
            }
            
        }
    }
    
    func getSectionsForCoursesProfessorsList() -> Void {
        
        let database = Firestore.firestore()
        let courseId = selectedCourse?.id ?? ""
        let profId = selectedProfessor?.id ?? ""
        
        let docRef = database.collection("sections")
            .whereField("courseId", isEqualTo: courseId)
            .whereField("professorId", isEqualTo: profId)
        
        SVProgressHUD.show()
        docRef.addSnapshotListener { (querySnapshot, err) in
            if let err = err {
                
                SVProgressHUD.dismiss()
                print("Error getting documents: \(err)")
                
            } else {
                
                SVProgressHUD.dismiss()
                self.sectionsList.removeAll()
                
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                    
                    let data = document.data()
                    
                    var section = SectionModel()
                    section.id = document.documentID
                    section.timings = data["timings"] as? String ?? ""
                    
                    self.sectionsList.append(section)
                }
                
                self.setupSectionPopUpButton()
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
    
    @IBAction func save(_ sender: Any) {
//        LaunchLAV.animation = .named("LottieProject")
//        LaunchLAV.loopMode = .playOnce
//        LaunchLAV.play()
        audioPlayer?.play()
                 // Schedule a timer to stop audio playback after 10 seconds
         timer = Timer.scheduledTimer(withTimeInterval: TimeInterval.random(in: 3.0...5.0), repeats: false) { [weak self] _ in
             self?.audioPlayer?.stop()
         }
        
        self.saveCourse()
    }
    
    
    func saveCourse() {
        
        let id = Auth.auth().currentUser?.uid ?? ""
        let params = ["studentId": id,
                      "course": selectedCourse?.name ?? "",
                      "courseId": selectedCourse?.id ?? "",
                      "professor": selectedProfessor?.name ?? "",
                      "professorId": selectedProfessor?.id ?? "",
                      "timings": selectedSection?.timings ?? "",
                      "sectionId": selectedSection!.id ?? "",
        ] as [String : Any]
        
        
        let path = String(format: "%@", "RegisteredCourses")
        let db = Firestore.firestore()
        
        SVProgressHUD.show()
        db.collection(path).document().setData(params) { err in
            if let err = err {
                
                SVProgressHUD.dismiss()
                self.showAlert(str: err.localizedDescription)
                
            } else {
                
                SVProgressHUD.dismiss()
                let alert = UIAlertController(title: "", message: "Course added successfully", preferredStyle: UIAlertController.Style.alert)
                
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { action in
                    AudioServicesPlaySystemSound(SystemSoundID(1004))
                    self.navigationController?.popViewController(animated: true)
                    
                }))
                self.present(alert, animated: true, completion: nil)
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
