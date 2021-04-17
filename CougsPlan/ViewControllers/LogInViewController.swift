//
//  ViewController.swift
//  CougsPlan
//
//  Created by Nikolaus Walton on 4/12/21.
//

import UIKit
import Firebase


var handle: AuthStateDidChangeListenerHandle?

class LogInViewController: UIViewController {

    @IBOutlet weak var emailTextBox: UITextField!
    @IBOutlet weak var passwordTextBox: UITextField!
  
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        Auth.auth().removeStateDidChangeListener(handle!)
    }
    
    @IBAction func backLoginUnwind(unwindSegue: UIStoryboardSegue) {
        print("back to login")
    }
    
    @IBAction func signUpUnwind(unwindSegue: UIStoryboardSegue) {
        print("sign up")
    }

}

