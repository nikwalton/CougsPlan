//
//  ViewController.swift
//  CougsPlan
//
//  Created by Nikolaus Walton on 4/12/21.
//

import UIKit
import Firebase



class LogInViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var emailTextBox: UITextField!
    @IBOutlet weak var passwordTextBox: UITextField!
  
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        emailTextBox.delegate = self
        passwordTextBox.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.emailTextBox.text = ""
        self.passwordTextBox.text = ""
    }
    
    @IBAction func signInTapped(_ sender: Any) {
        if let email = emailTextBox.text,
           let password = passwordTextBox.text {
            Auth.auth().signIn(withEmail: email, password: password, completion: { [weak self] user, error in
                guard let strongSelf = self else { return }
                if (error != nil) {
                    let alert = UIAlertController(title: "Error", message: "Check Username and Password", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    strongSelf.present(alert, animated: true, completion: nil)
                }
               
                strongSelf.performSegue(withIdentifier: "GoToHome", sender: strongSelf)
            })
        }
    }
    
    @IBAction func backLoginUnwind(unwindSegue: UIStoryboardSegue) {
        print("back to login")
    }

}

