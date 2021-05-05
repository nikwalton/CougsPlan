//
//  CourseViewController.swift
//  CougsPlan
//
//  Created by Nikolaus Walton on 4/16/21.
//

import UIKit
import Firebase

class CourseViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var CourseTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        CourseTable.dataSource = self
    }
    
    @IBAction func backCourseUnwind(unwindSegue: UIStoryboardSegue) {
        print("back to courses")
    }
    
    @IBAction func unwindAddCourse(sender: UIStoryboardSegue){
        let vc = sender.source as! AddCourseViewController
        let db = Firestore.firestore()
        //figure out the days of the week
        var CourseDays: String = ""
        
        //just use if statements for simplicity
        if vc.MondaySlider.isOn {
            CourseDays.append("M")
        }
        if vc.TuesdaySlider.isOn {
            CourseDays.append("T")
        }
        if vc.WednesdaySlider.isOn {
            CourseDays.append("W")
        }
        if vc.ThursdaySlider.isOn {
            CourseDays.append("Th")
        }
        if vc.FridaySlider.isOn  {
            CourseDays.append("F")
        }
        
        //set up our dictionary
        let CourseData: [String: Any] = [
            "name": vc.CourseTitleText.text!,
            "time": vc.CourseTimeText.text!,
            "location": vc.CourseLocationText.text!,
            "days": CourseDays
            ]
        
        let uid = Auth.auth().currentUser?.uid
        //path is users/(current user uid)/courses/(current user uid)/
        //could store this in users/courses/(current user id) but it makes more sense to me to have the
        //courses stored under the users own document instead of a general collection
        db.collection("users").document(uid!).collection("courses").document(uid!).setData(CourseData)
     
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    //MARK: - Table View Functions
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = CourseTable.dequeueReusableCell(withIdentifier: "cell")!
        cell.textLabel?.text = "Testing"
        cell.detailTextLabel?.text = "sub text"
        return cell
    }
    
}
