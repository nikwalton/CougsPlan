//
//  AddCourseViewController.swift
//  CougsPlan
//
//  Created by Nikolaus Walton on 5/4/21.
//

import UIKit
import Firebase

class AddCourseViewController: UIViewController {

    @IBOutlet weak var CourseTitleText: UITextField!
    @IBOutlet weak var CourseTimeText: UITextField!
    @IBOutlet weak var CourseLocationText: UITextField!
    
    //sliders for days
    @IBOutlet weak var MondaySlider: UISwitch!
    @IBOutlet weak var TuesdaySlider: UISwitch!
    @IBOutlet weak var WednesdaySlider: UISwitch!
    @IBOutlet weak var ThursdaySlider: UISwitch!
    @IBOutlet weak var FridaySlider: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func AddCourse(_ sender: Any) {
        let db = Firestore.firestore()
        //figure out the days of the week
        var CourseDays: String = ""
        
        //just use if statements for simplicity
        if MondaySlider.isOn {
            CourseDays.append("M")
        }
        if TuesdaySlider.isOn {
            CourseDays.append("T")
        }
        if WednesdaySlider.isOn {
            CourseDays.append("W")
        }
        if ThursdaySlider.isOn {
            CourseDays.append("Th")
        }
        if FridaySlider.isOn  {
            CourseDays.append("F")
        }
        
        //set up our dictionary
        let CourseData: [String: Any] = [
            "name": CourseTitleText.text!,
            "time": CourseTimeText.text!,
            "location": CourseLocationText.text!,
            "days": CourseDays
            ]
        
        let ref = db.collection("users").whereField("uid", isEqualTo: Auth.auth().currentUser?.uid)
    
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
