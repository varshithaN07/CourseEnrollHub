//
//  CourseTVC.swift
//  Corse Enroll Hub
//
//  Created by AGRAJA GOTTIPATI on 4/15/24.
//

import UIKit

class CourseTVC: UITableViewCell {
    @IBOutlet weak var nameLBL: UILabel!
    
    @IBOutlet weak var professorLBL: UILabel!
    
    @IBOutlet weak var timingLBL: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
