//
//  HomeViewController.swift
//  CougsPlan
//
//  Created by Nikolaus Walton on 4/15/21.
//

import UIKit
import SafariServices
import Firebase
import Photos


class HomeViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var AvatarImage: UIImageView!
    @IBOutlet weak var NameText: UILabel!
    @IBOutlet weak var MajorText: UILabel!
    
    let picker = UIImagePickerController()
    var userHandle: AuthStateDidChangeListenerHandle?
    var permission = false
    
    let db = Firestore.firestore()
    
    //will need this for the upcoming table
    let date = Date()

    //need to calculate the day of the week too
    let dayOfWeek: Int = 0
   
    override func viewWillAppear(_ animated: Bool) {
        userHandle = Auth.auth().addStateDidChangeListener{ (auth, user) in
            self.setUserProfile(user)
        }
     
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        Auth.auth().removeStateDidChangeListener(userHandle!)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        picker.delegate = self
        let tapGesutre = UITapGestureRecognizer(target: self, action: #selector(AvatarTapped(tapGesture:)))
        AvatarImage.addGestureRecognizer(tapGesutre)
    }
    
    //this function wraps all of our needed queries and etc into one function.
    //might need to do two seperate queries in this function due to changes on how i store the user document
    func setUserProfile(_ user: Firebase.User?){
        let docRef = Firestore.firestore().collection("users").whereField("uid", isEqualTo: user?.uid ?? "")
        
        docRef.getDocuments { (querySnap, err) in
            if let err = err {
                print(err.localizedDescription)
                return
            } else if querySnap!.documents.count != 1 {
                //this will still trigger on logout but its fine
                print("more than one document found")
            } else {
                let doc = querySnap!.documents.first
                let dataDescript = doc?.data()
                self.completeUserQuery(result: dataDescript ?? ["":""])
            }
        }
        guard let uid = Auth.auth().currentUser?.uid else {return}
        let imageRef = Storage.storage().reference().child("user/\(uid)")
        imageRef.downloadURL { url, err in
            if let err = err {
                print(err.localizedDescription)
                return
            } else {
                
                if let data = try? Data(contentsOf: url!) {
                    self.AvatarImage.image = UIImage(data: data)
                    self.AvatarImage.contentMode = .scaleAspectFill
                }
            }
            
        }
        
    }
    
    //tried to use ths to save results into local variables, but since firestore is async
    //it didnt really work out
    private func completeUserQuery(result: [String:Any]) {
        guard let name = result["name"] as? String else {return}
        guard let major = result["major"] as? String else {return}
        
        self.NameText.text = name
        self.MajorText.text = major
        
    }
    
    //check permissions before deciding if the user can access changing their avatar
    @objc func AvatarTapped(tapGesture: UITapGestureRecognizer)
    {
        checkPermission()
    }
    
    func checkPermission()
    {
        if PHPhotoLibrary.authorizationStatus() != PHAuthorizationStatus.authorized {
            PHPhotoLibrary.requestAuthorization({(status: PHAuthorizationStatus) -> Void in
                ()
            })
        }
        if PHPhotoLibrary.authorizationStatus() == PHAuthorizationStatus.authorized {
            self.profilePicker()
        } else {
            PHPhotoLibrary.requestAuthorization(requestAuthorizationHandler)
        }
    }
    func requestAuthorizationHandler(status: PHAuthorizationStatus){
        if PHPhotoLibrary.authorizationStatus() == PHAuthorizationStatus.authorized {
            print("access granted")
            self.permission = true
        } else {
            print("acess denied")
            self.permission = false
        }
    }
    
    func profilePicker() {
        picker.sourceType = .photoLibrary
        self.present(picker, animated: true, completion: nil)
     
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        //if the image is there
      
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            uploadProfile(image) { url in
                let imageurl = URL(string: url)!
                if let data = try? Data(contentsOf: imageurl) {
                    self.AvatarImage.image = UIImage(data: data)
                    self.AvatarImage.contentMode = .scaleAspectFill
                }
            }
        
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }

    func uploadProfile(_ image:UIImage, completion: @escaping (( _ url: String)->()))
    {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        let storageRef = Storage.storage().reference().child("user/\(uid)")
        //lots of compression to not fill up Firebase/storage. Image is small on the screen anyays, nobody should notice
        guard let imageData = image.jpegData(compressionQuality: 0.2) else {return}

        let metadata = StorageMetadata()
        metadata.contentType = "image/jpg"
        storageRef.putData(imageData, metadata: metadata ) { (meta, err) in
            if err == nil, meta != nil {
                storageRef.downloadURL { (url, err) in
                    if err == nil {
                    guard let download = url?.absoluteString else {return}
                    completion(download)
                    } else {return}
                }
            } else {
               return
            }
        }
    
        
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
