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
    
    
    @IBOutlet weak var courseBTN: UIButton!
    @IBOutlet weak var professorBtn: UIButton!
    @IBOutlet weak var sectionBtn: UIButton!
    @IBOutlet weak var timeTF: UITextField!
    
    @IBOutlet weak var saveBtn: UIButton!
    override func viewDidLoad() {
    
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

}
