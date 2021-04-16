//
//  ViewController.swift
//  CougsPlan
//
//  Created by Nikolaus Walton on 4/12/21.
//

import UIKit

class LogInViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    
    @IBAction func backLoginUnwind(unwindSegue: UIStoryboardSegue) {
        print("back to login")
    }
    
    @IBAction func signUpUnwind(unwindSegue: UIStoryboardSegue) {
        print("sign up")
    }

}

