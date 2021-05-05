//
//  CalendarViewController.swift
//  CougsPlan
//
//  Created by Nikolaus Walton on 4/15/21.
//

import UIKit
import FSCalendar
import Firebase

class CalendarViewController: UIViewController, FSCalendarDelegate, UITableViewDataSource {

    @IBOutlet var calendar: FSCalendar!
    @IBOutlet weak var TableView: UITableView!
    
    //not todays date, but rather the date that is selected on the calendar. Defaults to todays date though
    var currentDate: Date?
    
    var events: [Event] = []
    var currentDateEvents: [Event] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        calendar.delegate = self
        currentDate = calendar.today
        print(currentDate!)
        TableView.dataSource = self
        
        let format = DateFormatter()
        format.dateFormat = "MM-dd-YYYY"
        let dateString = format.string(from: currentDate!)
        let testEvent = Event(name: "test", time: "5pm", date: dateString, location: "here")
        events.append(testEvent)
        getDatesEvents()
    }
    
    @IBAction func backCalUnwind(unwindSegue: UIStoryboardSegue) {
        print("back to calendar")
    }
    
    @IBAction func addEventUnwind(sender: UIStoryboardSegue) {
        print("Add Event")
        let vc = sender.source as! AddEventViewController
        
        let format = DateFormatter()
        format.dateFormat = "MM-dd-YYYY"
        
        let EventData: [String: Any] = [
            "title": vc.TitleText.text!,
            "time": vc.TimeText.text!,
            "location": vc.PlaceText.text!,
            "date": format.string(from: currentDate!)
        ]
        
        let db = Firestore.firestore()
        let uid = Auth.auth().currentUser?.uid
        //similar to course collection path
        // users/(user uid)/events/(user uid)/
        db.collection("users").document(uid!).collection("events").addDocument(data: EventData)
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        let format = DateFormatter()
        format.dateFormat = "MM-dd-YYYY"
        let string = format.string(from: date)
        print(string)
        currentDate = date
        getDatesEvents()
        TableView.reloadData()
    }
    
    func getDatesEvents() {
        currentDateEvents.removeAll()
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd-YYYY"
        guard let date = currentDate else {return}
        let dateString = formatter.string(from: date)
        
        for event in events {
            if event.date == dateString {
                currentDateEvents.append(event)
            }
        }
    }
    
    // MARK: -Table View Stuff
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentDateEvents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = TableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        if currentDateEvents.count > 0 {
            let event = currentDateEvents[indexPath.row]
            cell.textLabel?.text = event.name
        }
      
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
