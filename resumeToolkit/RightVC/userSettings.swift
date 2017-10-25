//
//  userSettings.swift
//  resumeToolkit
//
//  Created by arya mirshafii on 9/6/17.
//  Copyright © 2017 EngineeringforSocialInnovation. All rights reserved.
//

import Foundation
import UIKit
import CoreData
import GoogleAPIClientForREST
import GoogleSignIn
import Device_swift

extension String {
    var firstUppercased: String {
        guard let first = first else { return "" }
        return String(first).uppercased() + dropFirst()
    }
}


class userSettings: UIViewController,UITextFieldDelegate,GIDSignInDelegate, GIDSignInUIDelegate{
    var userData: [NSManagedObject] = []
    var dataController = dataManager()
    var pdfGenerate = testPDFGenerator()
    
    @IBOutlet weak var firstNameEntry: UITextField!
    @IBOutlet weak var lastNameEntry: UITextField!
    @IBOutlet weak var emailEntry: UITextField!
    @IBOutlet weak var phoneEntry: UITextField!
    @IBOutlet weak var currentSchoolEntry: UITextField!
    
    
    @IBOutlet weak var tapToFinish: UIView!
    
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var tapFinishZone: UIView!
    
    var userInfoController = userInfo()
    
    let service = GTLRDriveService()
    let signInButton = GIDSignInButton()
    let output = UITextView()
    
    
    var driveFileManager: userSetUp!
    let pdfGenerator = testPDFGenerator()
    var userFirstName:String?
    var userLastName:String?
    
    //private let scopes = ["https://www.googleapis.com/auth/drive.file"]
    private let scopes = ["https://www.googleapis.com/auth/drive.file"]
    var signedIn = false
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.firstNameEntry.delegate = self
        self.lastNameEntry.delegate = self
        self.emailEntry.delegate = self
        self.phoneEntry.delegate = self
        self.currentSchoolEntry.delegate = self
        
        
 
        self.firstNameEntry.delegate = self
        self.firstNameEntry.clearButtonMode = .whileEditing
        
        
        
        
        
        
        
        self.lastNameEntry.delegate = self
        self.lastNameEntry.clearButtonMode = .whileEditing
       
        
        
        
        self.emailEntry.delegate = self
        self.emailEntry.clearButtonMode = .whileEditing
        
        
        
        
        self.phoneEntry.delegate = self
        self.phoneEntry.clearButtonMode = .whileEditing
        
        
        
        
        
        
        
        self.currentSchoolEntry.delegate = self
        self.currentSchoolEntry.clearButtonMode = .whileEditing
        
        
        
        
        
        
        
        loadData()
        
       
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        tapFinishZone.addGestureRecognizer(tap)
        
        let notificationCenter = NotificationCenter.default
        
        notificationCenter.addObserver(self, selector: #selector(userDefaultsDidChange), name: UserDefaults.didChangeNotification, object: nil)
        
        
        
        firstNameEntry.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        lastNameEntry.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        emailEntry.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        phoneEntry.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        currentSchoolEntry.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        
        
        
        
        // Configure Google Sign-in.
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().scopes = scopes
        
        GIDSignIn.sharedInstance().clientID = "699945398009-sms6e0cpoam9cp6631nbi38v910s73rv.apps.googleusercontent.com"
        GIDSignIn.sharedInstance().signInSilently()
        //signInButton.frame = CGRect(x: (view.frame.width - signInButton.frame.width)/2, y:  0, width: signInButton.frame.width, height: signInButton.frame.height)
        
        // Add the sign-in button.
        tapToFinish.addSubview(signInButton)
         //uncomment THIS IS A TEMP FIX FOR A TEMP ERROR ASSERTIon
        if(signedIn){
            driveFileManager = userSetUp(driveService: service, withFilePath: String(describing: pdfGenerator.createPDFFileAndReturnPath().output))
        }
        userDefaultsDidChange()
        print("the current id is" + userInfoController.getFolderID())
        
        
            
        
        if( userData.last?.value(forKeyPath: "firstName") != nil){
            let nameString: String = (userData.last?.value(forKeyPath: "firstName") as? String)!
            welcomeLabel.text = "Welcome " +  nameString.firstUppercased + ","
        } else {
             welcomeLabel.text = "Welcome,"
        }
        
        
        
    }
    
     @objc func userDefaultsDidChange() {
        
        loadData()
        print("USER DEFAULTS CHANGED")
        let aUser = userData.last
        if(userInfoController.fetchData() == "main"){
            firstNameEntry.text = aUser?.value(forKeyPath: "firstName") as? String
            lastNameEntry.text = aUser?.value(forKeyPath: "lastName") as? String
            emailEntry.text = aUser?.value(forKeyPath: "emailAdress") as? String
            phoneEntry.text = aUser?.value(forKeyPath: "phoneNumber") as? String
            currentSchoolEntry.text = aUser?.value(forKeyPath: "schoolName") as? String
            
            
            
            if( userData.last?.value(forKeyPath: "firstName") != nil){
                let nameString: String = (userData.last?.value(forKeyPath: "firstName") as? String)!
                welcomeLabel.text = "Welcome " +  nameString.firstUppercased + ","
            } else {
                welcomeLabel.text = "Welcome,"
            }
            
        }
        driveFileManager = userSetUp.init(driveService: service, withFilePath: "String!")
        if(userInfoController.getFolderID() != "noFolder" && userInfoController.getFolderID() != nil){
            print("FOLDER ID OF" + String(describing: pdfGenerate.createPDFFileAndReturnPath().output))
            
            
            print("EL es tu" + userInfoController.getFolderID())
            let meFile =  pdfGenerate.createPDFFileAndReturnPath().output
            
            let fileManager = FileManager.default
            if fileManager.fileExists(atPath: String(describing: meFile)) {
                print("FILE AVAILABLE")
            } else {
                print("FILE NOT AVAILABLE")
            }
            driveFileManager = userSetUp.init(driveService: service, withFilePath: "String!")
            driveFileManager.upload(toFolder: userInfoController.getFolderID(), atFilePath: String(describing: pdfGenerate.createPDFFileAndReturnPath().output), withFileName: generateResumeName())
        }
        
    }
    var counter = 0
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        
        dataController.savefirstName(firstName: firstNameEntry.text!)
        dataController.saveLastName(lastName: lastNameEntry.text!)
        dataController.saveEmail(email: emailEntry.text!)
        dataController.savePhoneNumber(phoneNumber: phoneEntry.text!)
        dataController.saveSchool(schoolName: currentSchoolEntry.text!)
        
        
        
        let aRandomNumber = String(arc4random_uniform(100) + 1)
        print("!!!" + aRandomNumber)
        
        
        
        
        
            
        fetchFolder()
        
        print("ARYA ID IS" + userInfoController.getFolderID())
        if(signedIn){
             driveFileManager.upload(toFolder: userInfoController.getFolderID(), atFilePath: String(describing: pdfGenerate.createPDFFileAndReturnPath().output), withFileName: generateResumeName())
        }
       
        
        
        view.endEditing(true)
        print("else it is located at" + userInfoController.getFolderID() )
        //print("THE DATE IS" + generateResumeName())
 
        //dataController.printData()
        
        let deviceType = UIDevice.current.deviceType
        
        switch deviceType {
            case .iPhone6: print("Do stuff for iPhone6 Plus")
            case .iPadMini: print("Do stuff for iPad mini")
            default: print("Check other available cases of DeviceType")
        }
        
        
        
    }
    
    
    
    
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        /**
        dataController.savefirstName(firstName: firstNameEntry.text!)
        dataController.saveLastName(lastName: lastNameEntry.text!)
        dataController.saveEmail(email: emailEntry.text!)
        dataController.savePhoneNumber(phoneNumber: phoneEntry.text!)
        dataController.saveSchool(schoolName: currentSchoolEntry.text!)
        dataController.saveGradeLevel(gradeLevel: gradeLevelEntry.text!)
        
        
        let aRandomNumber = String(arc4random_uniform(100) + 1)
        print("!!!" + aRandomNumber)
        userInfoController.saveChangeText(text: aRandomNumber)
 */
    }
    
    func generateResumeName() -> String{
        var dateString = ""
        if(userLastName != nil){
            dateString += userLastName! + "_" + userFirstName!
        }
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        
            
            
        dateString += dateFormatter.string(from:Date())
        dateString += "_" + String(hour) + ":" + String(minutes)
        dateString += ".pdf"
        
        
        print(dateString)
        
        return dateString
    }
    
    
    func fetchFolder() {
        loadData()
        let query = GTLRDriveQuery_FilesList.query()
        query.pageSize = 10
        
        service.executeQuery(query,
                             delegate: self,
                             didFinish: #selector(returnFolderName(ticket:finishedWithObject:error:))
        )
    }
    
    // Process the response and display output
    @objc func returnFolderName(ticket: GTLRServiceTicket,
                          finishedWithObject result : GTLRDrive_FileList,
                          error : NSError?){
        
        if let error = error {
            showAlert(title: "Error", message: error.localizedDescription)
            return
        }
        
        var text = ""
        if let files = result.files, !files.isEmpty {
            //text += "Files:\n"
            for file in files {
                if(file.name == userLastName! + "_" + userFirstName!){
                    text = file.identifier!
                    print("the identifier is" + text)
                }
                //text += "\(file.name!) (\(file.identifier!))\n"
            }
        } else {
            text = "No files found."
        }
        //|| text != nil ||  text != "" || !text.isEmpty
        if(text != "No files found." && userInfoController.getFolderID() == "noFolder" || text != nil ||  text != "" || !text.isEmpty){
            userInfoController.saveFolderID(folderID: text)
            driveFileManager.upload(toFolder: userInfoController.getFolderID(), atFilePath: String(describing: pdfGenerate.createPDFFileAndReturnPath().output), withFileName: generateResumeName())
        }
        
        
    }
    
    
    
    func showAlert(title : String, message: String) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: UIAlertControllerStyle.alert
        )
        let ok = UIAlertAction(
            title: "OK",
            style: UIAlertActionStyle.default,
            handler: nil
        )
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
    
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!,
              withError error: Error!) {
        loadData()
        if let error = error {
            //showAlert(title: "Authentication Error", message: error.localizedDescription)
            self.service.authorizer = nil
            signedIn = false
        } else {
            signedIn = true
            
            
            self.signInButton.isHidden = true
            
            self.output.isHidden = false
            self.service.authorizer = user.authentication.fetcherAuthorizer()
            
            userLastName = userData.last?.value(forKeyPath: "lastName") as? String
            userFirstName = userData.last?.value(forKeyPath: "firstName") as? String
            driveFileManager = userSetUp.init(driveService: service, withFilePath: "String!")
           
            if(userFirstName != nil && userFirstName != nil &&  userInfoController.getFolderID() == "noFolder" ){
               // print(userLastName!)
                print(userInfoController.getFolderID())
                //print(userData)
                driveFileManager.createFolder(userLastName! + "_" + userFirstName!)
                //driveFileManager.createFolder("Mirshafii_Arya")
            }
 
            fetchFolder()
        }
    }
    
    
    
    
    func loadData(){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let userRequest = NSFetchRequest<NSManagedObject>(entityName: "User")
        //let timeRequest = NSFetchRequest<NSManagedObject>(entityName: "Time")
        do {
            userData = try managedContext.fetch(userRequest)
            
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
}
