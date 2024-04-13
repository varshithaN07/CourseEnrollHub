//
//  corseselectionTVC.swift
//  Corse Enroll Hub
//
//  Created by Teja Kumar Muppala on 4/12/24.
//

import UIKit

class corseselectionTVC: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

class CategoriesTracksTVC: UITableViewController {

    var category = ""
    var id = 0
    var name = ""
    var preview = ""
    var track = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if category == "artist" {
            
            Task {
                await Constants.loadArtistsTrackDetails(for: id)
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }else if category == "album" {
            
            Task {
                await Constants.loadAlbumTrackDetails(for: id)
            
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }else if category == "radio" {
            
            Task {
                await Constants.loadRadioTrackDetails(for: id)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
        
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showCategoryPlayerSegue" {
            
            let vc = segue.destination as! PlayerVC
            vc.category = self.category
            vc.name = self.name
            vc.track = self.track
            vc.preview = self.preview
        }
    }
    

//    override func viewDidAppear(_ animated: Bool) {
//
//        let animations = AnimationType.from(direction: .right, offset: 1000)
//        UIView.animate(views: self.tableView.visibleCells,
//                       animations: [animations])
//
//    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {

        let delay = Double(indexPath.row) * 0.1

            let animations = [AnimationType.from(direction: .right, offset: 1000.0)]
            UIView.animate(views: [cell], animations: animations, delay: delay)
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {

        return 1
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 80
    }
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if category == "artist" {
            
            self.preview = Constants.artistTrackPreviewFromAPI[indexPath.row]
            self.track = Constants.artistTrackTitleFromAPI[indexPath.row]
        }else if category == "album" {
            
            self.preview = Constants.albumTrackPreviewFromAPI[indexPath.row]
            self.track = Constants.albumTrackTitleFromAPI[indexPath.row]
        }else if category == "radio" {
            
            self.preview = Constants.radioTrackPreviewFromAPI[indexPath.row]
            self.track = Constants.radioTrackTitleFromAPI[indexPath.row]
        }
        
        self.performSegue(withIdentifier: "showCategoryPlayerSegue", sender: self)
    }
    

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "artisttrackcell", for: indexPath) as! CategoryTrackCell

        if category == "artist" {
            
            cell.imgView.image = UIImage(systemName: "music.mic")
            cell.trackLBL.text = Constants.artistTrackTitleFromAPI[indexPath.row]
        }else if category == "album" {
            
            cell.imgView.image = UIImage(systemName: "music.note.list")
            cell.trackLBL.text = Constants.albumTrackTitleFromAPI[indexPath.row]
        }else if category == "radio" {
            
            cell.imgView.image = UIImage(systemName: "antenna.radiowaves.left.and.right.circle")
            cell.trackLBL.text = Constants.radioTrackTitleFromAPI[indexPath.row]
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if category == "artist" {
            
            return Constants.artistTrackTitleFromAPI.count
        }else if category == "album" {
            
            return Constants.albumTrackTitleFromAPI.count
        }else if category == "radio" {
            
            return Constants.radioTrackTitleFromAPI.count
        }
        
        return 0
        
    }

}
