//
//  AddEventViewController.swift
//  Corse Enroll Hub
//
//  Created by Varshitha Nalluri on 4/17/24.
//

import UIKit
import EventKit
import EventKitUI

class AddEventViewController: UIViewController {
    let eventStore = EKEventStore()
    @IBOutlet weak var endDateBtn: UIButton!
    
    @IBOutlet weak var dtPicker: UIDatePicker!
    @IBOutlet weak var pickerView: UIView!
    @IBOutlet weak var startDateBtn: UIButton!
    @IBOutlet weak var titleTF: UITextField!
    var field = ""
    var dtFomatter = DateFormatter()
    
    var startDate: Date?
    var endDate: Date?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dtFomatter.dateFormat = "MMM dd, yyyy"
        
        pickerView.isHidden = true
    }
    

    @IBAction func add(_ sender: Any) {
    }
    @IBAction func cancel(_ sender: Any) {
    }
    @IBAction func done(_ sender: Any) {
    }
    @IBAction func end(_ sender: Any) {
    }
    @IBAction func start(_ sender: Any) {
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
