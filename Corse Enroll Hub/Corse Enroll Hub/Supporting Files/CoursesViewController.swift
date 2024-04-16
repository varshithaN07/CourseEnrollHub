//
//  CoursesViewController.swift
//  Corse Enroll Hub
//
//  Created by AGRAJA GOTTIPATI on 4/15/24.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import SVProgressHUD
struct MyCourseModel: Codable {
    
    var id: String?
    var course: String?
    var courseId: String?
    var professor: String?
    var professorId: String?
    var timings: String?
    var sectionId: String?
    
    init() {}
}


class CoursesViewController: UIViewController {

    
    
    @IBOutlet weak var noRecordLbl: UILabel!
    @IBOutlet weak var coursesTV: UITableView!
    
    var courses: [MyCourseModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Courses"
        // Do any additional setup after loading the view.
        coursesTV.delegate = self
        coursesTV.dataSource = self
        
        self.getMyCourses()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tabBarController?.tabBar.isHidden = false
    }

    func getMyCourses() -> Void {
        
        let database = Firestore.firestore()
        let id = Auth.auth().currentUser?.uid ?? ""
        
        let docRef = database.collection("RegisteredCourses")
            .whereField("studentId", isEqualTo: id)
        docRef.addSnapshotListener { (querySnapshot, err) in
            if let err = err {
                
                print("Error getting documents: \(err)")
                
            } else {
                
                self.courses.removeAll()
                
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                    
                    let data = document.data()
                    
                    var course = MyCourseModel()
                    course.id = document.documentID
                    course.course = data["course"] as? String ?? ""
                    course.courseId = data["courseId"] as? String ?? ""
                    course.professor = data["professor"] as? String ?? ""
                    course.professorId = data["course"] as? String ?? ""
                    course.timings = data["timings"] as? String ?? ""
                    course.sectionId = data["sectionId"] as? String ?? ""
                    
                    
                    self.courses.append(course)
                }
                
                if self.courses.count == 0 {
                    
                    self.noRecordLbl.isHidden = false
                    self.coursesTV.isHidden = true
                }else {
                    
                    self.noRecordLbl.isHidden = true
                    self.coursesTV.isHidden = false
                }
                
                self.coursesTV.reloadData()
            }
        }
    }
    
    func deleteCourse(id: String) -> Void {
        
        
        SVProgressHUD.show()
        let db = Firestore.firestore()
        
        let docRef = db.collection("RegisteredCourses").document(id)
        docRef.delete() { err in
            if let _ = err {
                
                SVProgressHUD.dismiss()
            } else {
                
                SVProgressHUD.dismiss()
                self.getMyCourses()
            }
        }
    }

}


extension CoursesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.courses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "courseCell", for: indexPath) as! CourseTVC
        
        let course = self.courses[indexPath.row]
        
        cell.nameLBL.text = course.course ?? ""
        cell.professorLBL.text = course.professor ?? ""
        cell.timingLBL.text = course.timings ?? ""
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 120
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        return true
    }
    
    // Override to support editing the table view.
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let course = courses[indexPath.row]
            courses.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            self.deleteCourse(id: course.id ?? "")
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
