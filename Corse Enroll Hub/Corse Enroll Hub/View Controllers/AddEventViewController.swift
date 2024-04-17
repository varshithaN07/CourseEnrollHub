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
        
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func start(_ sender: Any) {
        
        field = "start"
        pickerView.isHidden = false
        
        dtPicker.minimumDate = Date()
        
        if endDate == nil {
            
            dtPicker.maximumDate = nil
            
        }else{
            
            dtPicker.maximumDate = endDate
            dtPicker.minimumDate = Date()
        }
    }
    
    
    @IBAction func end(_ sender: Any) {
        
        field = "end"
        pickerView.isHidden = false
        
        if startDate == nil {
            
            self.showAlert(str: "Please select start date")
        }else{
            
            dtPicker.minimumDate = startDate
        }
    }
    
    
    @IBAction func done(_ sender: Any) {
        
        let date = dtPicker.date
        
        if field == "start" {
            
            startDate = date
            let str = dtFomatter.string(from: date)
            startDateBtn.setTitle(str, for: .normal)
            
            endDate = nil
            endDateBtn.setTitle("Select end date", for: .normal)
            
        }else {
            
            endDate = date
            let str = dtFomatter.string(from: date)
            endDateBtn.setTitle(str, for: .normal)
        }
        
        pickerView.isHidden = true
    }
    
    @IBAction func cancel(_ sender: Any) {
        
        pickerView.isHidden = true
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func add(_ sender: Any) {
        
        if titleTF.text == "" {
            
            self.showAlert(str: "Please enter title")
        }else if startDate == nil {
            
            self.showAlert(str: "Please select start dte")
        }else {
            
            
            switch EKEventStore.authorizationStatus(for: .event) {
            case .notDetermined:
                if #available(iOS 17.0, *) {
                    eventStore.requestFullAccessToEvents { granted, error in
                        
                        presentEventVC()
                        print("Authorized")
                    }
                } else {
                    // Fallback on earlier versions
                }
                print("Not determinded")
            case .authorized:
                print("Authorized")
                presentEventVC()
            default:
                print("default")
                break
            }
        }
        
        
        func presentEventVC() -> Void {
            let eventVC = EKEventEditViewController()
            eventVC.editViewDelegate = self
            eventVC.eventStore = EKEventStore()
            
            
            let event = EKEvent(eventStore: eventVC.eventStore)
            event.title = titleTF.text ?? "Demo Event"
            event.startDate = startDate ?? Date()
            if endDate != nil {
                
                event.endDate = endDate!
            }
            eventVC.event = event
            event.alarms = [] 
            self.present(eventVC, animated: true)
            event
            
        }
    }
    
    
    
}

extension AddEventViewController: EKEventEditViewDelegate {
    
    func eventEditViewController(_ controller: EKEventEditViewController, didCompleteWith action: EKEventEditViewAction) {
        
        
        controller.dismiss(animated: true)
    }
    



}
