//
//  DashboardVC.swift
//  Corse Enroll Hub
//
//  Created by AGRAJA GOTTIPATI on 3/7/24.
//

import UIKit

class DashboardVC: UIViewController,UITableViewDataSource {

    @IBOutlet weak var table: UITableView!
    struct Modules {
        let title: String
        let imageName: String
    }
    let data : [Modules] = [
        Modules(title: "Stream", imageName: "stream"),
        Modules(title: "Course", imageName: "course"),
        Modules(title: "Calendar", imageName: "calendar"),
        Modules(title: "Cart", imageName: "cart")
        
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.dataSource = self
        // Do any additional setup after loading the view.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let module =  data[indexPath.row]
        let cell = table.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell
        cell.label.text = module.title
        cell.iconImageView.image = UIImage(named: module.imageName)
        return cell
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
