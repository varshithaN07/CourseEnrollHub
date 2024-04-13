//
//  CourseRegisterViewController.swift
//  Corse Enroll Hub
//
//  Created by AGRAJA GOTTIPATI on 4/12/24.
//

import UIKit

class CourseRegisterViewController: UIViewController {
    @IBOutlet weak var SectionLBL: UILabel!
    @IBOutlet weak var SectionTimingsLBL: UILabel!
    
    // Sample data
    let sectionName = "Introduction to Programming"
    let sectionTimings = "Mondays and Wednesdays, 10:00 AM - 12:00 PM"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Call a function to update labels with sample data
        updateLabels()
    }
    
    func updateLabels() {
        SectionLBL.text = sectionName
        SectionTimingsLBL.text = sectionTimings
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
