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
