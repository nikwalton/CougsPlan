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
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
