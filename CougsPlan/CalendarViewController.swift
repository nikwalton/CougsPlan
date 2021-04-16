//
//  CalendarViewController.swift
//  CougsPlan
//
//  Created by Nikolaus Walton on 4/15/21.
//

import UIKit
import FSCalendar

class CalendarViewController: UIViewController, FSCalendarDelegate {

    @IBOutlet var calendar: FSCalendar!
    var currentDate: Date?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        calendar.delegate = self
        currentDate = calendar.today
        print(currentDate!)
    }
    
    @IBAction func backCalUnwind(unwindSegue: UIStoryboardSegue) {
        print("back to calendar")
    }
    
    @IBAction func addEventlUnwind(unwindSegue: UIStoryboardSegue) {
        print("Add Event")
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        let format = DateFormatter()
        format.dateFormat = "MM-dd-YYYY"
        let string = format.string(from: date)
        print(string)
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
