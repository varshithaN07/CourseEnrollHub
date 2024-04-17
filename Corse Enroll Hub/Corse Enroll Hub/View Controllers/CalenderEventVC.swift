//
//  CalenderEventVC.swift
//  Corse Enroll Hub
//
//  Created by Teja Kumar Muppala on 4/16/24.
//

import UIKit
import EventKitUI
import EventKit


class CalenderEventVC: ViewController {
    
    let vc = EKEventViewController()
    vc.delegate = self()
    

}
