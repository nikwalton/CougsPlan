//
//  HomeViewController.swift
//  CougsPlan
//
//  Created by Nikolaus Walton on 4/15/21.
//

import UIKit
import SafariServices
import Firebase

class HomeViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var AvatarImage: UIImageView!
    let picker = UIImagePickerController()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        picker.delegate = self
        let tapGesutre = UITapGestureRecognizer(target: self, action: #selector(AvatarTapped(tapGesture:)))
        AvatarImage.addGestureRecognizer(tapGesutre)
    }
    
    @objc func AvatarTapped(tapGesture: UITapGestureRecognizer)
    {
        profilePicker()
    }
    
    func profilePicker() {
        picker.sourceType = .photoLibrary
        self.present(picker, animated: true, completion: nil)
     
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        //if the image is there
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            AvatarImage.contentMode = .scaleAspectFill
            AvatarImage.image = image
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }

    
    @IBAction func backHomeUnwind(unwindSegue: UIStoryboardSegue) {
        print("back to home")
    }

    /*
      When the user taps the WSU Events button, present to
     them the events webpaged managed by WSU
     */
    @IBAction func eventsTapped(_ sender: Any) {
        let urlString = "https://events.wsu.edu/event/"
        let url = URL(string: urlString)
        let safariVC = SFSafariViewController(url: url!)
        present(safariVC, animated: true, completion: nil)
    }

    @IBAction func logoutTapped(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            self.performSegue(withIdentifier: "LogoutUnwind", sender: self)
        } catch let error as NSError {
            print("Error with sign out: %@", error)
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
