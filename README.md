# CougsPlan
CougsPlan is a companion app for WSU students to schedule and plan their daily tasks.


This project was created as my final project for CPT_S 479 taken during spring 2021 at Washington State University

# Dependencies
To run this project, you need to have: <br>
* CocoaPods
  * FSCalendar
  * Firebase
    * Firebase/Auth
    * Firebase/Firestore
    * Firebase/Core
    * Firebase/Storage
    * FirebaseFirestoreSwift

## Installing Dependencies
To install CocoaPods if you havent already, in your terminal run
``` terminal
    sudo gem install cocoapods
```
With CocoaPods installed, run
```terminal
    pod install
```
in this directory of the repository.

After the dependencies are installed through ```pod install``` open the xcworkspace file in xcode.

# Firebase
The firebase server and database for this application will only be available until the end of May at the latest, after that I will be deleting the firebase project and it will no longer function for new clones. However, it will likely work if you set up your own firebase project assuming you set it up to include everything I listed 
