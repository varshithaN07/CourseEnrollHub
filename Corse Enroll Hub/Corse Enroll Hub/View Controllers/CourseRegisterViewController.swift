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
            updateLabels()
        }
        func updateLabels() {
            guard let name = sectionName, !name.isEmpty else {
                SectionLBL.text = "No data available"
                return
            }
            guard let timings = sectionTimings, !timings.isEmpty else {
                SectionTimingsLBL.text = "No timings available"
                return
            }
            
            SectionLBL.text = name
            SectionTimingsLBL.text = timings
            
            SectionLBL.accessibilityLabel = "Section name: \(name)"
            SectionTimingsLBL.accessibilityLabel = "Section timings: \(timings)"
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
