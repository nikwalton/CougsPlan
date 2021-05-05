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
    var courses: [Course] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        CourseTable.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let db = Firestore.firestore()
        courses.removeAll()
        guard let uid = Auth.auth().currentUser?.uid else {return}
        let docRef = db.collection("users").document(uid).collection("courses")
        docRef.getDocuments { (snapshot, err) in
            if let error = err {
                print("\(error)")
            } else {
                guard let snap = snapshot else {return}
                for document in snap.documents {
                    let data = document.data()
                    
                    let name = data["name"] as? String ?? "Class"
                    let time = data["time"] as? String ?? "Time"
                    let days = data["days"] as? String ?? "days"
                    let location = data["location"] as? String ?? "location"
                    
                    let newCourse = Course(id: document.documentID, name: name, time: time, days: days, location: location)
                    self.courses.append(newCourse)
                }
                self.CourseTable.reloadData()
            }
        }
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
        //path is users/(current user uid)/courses/(Auto Gen ID)
        //could store this in users/courses/(current user id) but it makes more sense to me to have the
        //courses stored under the users own document instead of a general collection
        db.collection("users").document(uid!).collection("courses").addDocument(data: CourseData)
        
        self.viewWillAppear(true)
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
        return courses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = CourseTable.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let course = courses[indexPath.row]
        cell.textLabel?.text = course.name
        cell.detailTextLabel?.text = course.location
        return cell
    }
    
}
