//
//  SignUpViewController.swift
//  CougsPlan
//
//  Created by Nikolaus Walton on 4/16/21.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController, UITextFieldDelegate {



    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var nameTextBox: UITextField!
    @IBOutlet weak var majorTextBox: UITextField!
    @IBOutlet weak var emailTextBox: UITextField!
    @IBOutlet weak var passwordTextBox: UITextField!
    @IBOutlet weak var passwordConfirmation: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        emailTextBox.delegate = self
        passwordTextBox.delegate = self
        passwordConfirmation.delegate = self
    }
    

    @IBAction func CreateAccount(_ sender: Any) {
        if let email = emailTextBox.text,
           let password = passwordTextBox.text,
           let passwordConf = passwordConfirmation.text,
           let name = nameTextBox.text,
           let major = majorTextBox.text{
            
            // only try to create a user if the password and password
            // confirmation match
            if password == passwordConf {
                print("The passwords are the same")
                // attempt account creation
                Auth.auth().createUser(withEmail: email, password: password, completion: {
                    (authResult, err) in
                    if(err != nil) {
                        self.errorLabel.text = "Error: \(String(describing: err))"
                        self.errorLabel.isHidden = false
                        return
                    }
                 
                    //set user's name and major
                    let db = Firestore.firestore()
                    db.collection("users").addDocument(data: ["name": name, "major": major, "uid": authResult!.user.uid]) { (err) in
                        self.errorLabel.text = "error: problem creating user"
                    }
                    
                    let changeRequest = authResult!.user.createProfileChangeRequest()
                    changeRequest.displayName = name
                    changeRequest.commitChanges(completion: {err in
                        if(err != nil){
                            self.errorLabel.text = "error: \(String(describing: err))"
                            return
                        }
                    })
                    //return to login
                    let alert = UIAlertController(title: "Coug's Plan", message: "Account Created", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                        self.performSegue(withIdentifier: "LoginUnwind", sender: self)
                    }))
                    self.present(alert, animated: true, completion: nil)
           
                })
            } else {
                errorLabel.text = "error: The passwords don't match!"
                errorLabel.isHidden = false
                return
                //show an error
            }
        }
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
