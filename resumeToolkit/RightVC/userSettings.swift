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
import Device

/*
Uppercases a string. Helpful for saving a user's name/updating the name textfields properly
*/
extension String {
    var firstUppercased: String {
        guard let first = first else { return "" }
        return String(first).uppercased() + dropFirst()
    }
}

/*
This class controlls the user settings of the app.
It also connects the app to google drive.
 This is done because the google drive service needs to be in the same viewcontroller as the GIDSignInButton, since the sign in button authorizes it.
*/
class userSettings: UIViewController,UITextFieldDelegate,GIDSignInDelegate, GIDSignInUIDelegate{
    var userData: [NSManagedObject] = []
    var dataController = dataManager()
    var pdfGenerate = testPDFGenerator()
    
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var containerView: UIView!
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
    
    @IBOutlet weak var firstNameView: UIView!
    @IBOutlet weak var lastNameView: UIView!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var phoneView: UIView!
    @IBOutlet weak var schoolView: UIView!
    
    
    var driveFileManager: userSetUp!
    let pdfGenerator = testPDFGenerator()
    var userFirstName:String?
    var userLastName:String?
    
    
    private let scopes = ["https://www.googleapis.com/auth/drive.file"]
    var signedIn = false
    override func viewDidLoad() {
        super.viewDidLoad()
        self.updateViewConstraints()
        self.view.reloadInputViews()
        self.view.layoutIfNeeded()
        self.view.clipsToBounds = true
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
        
        containerView.addGestureRecognizer(tap)
        
        let notificationCenter = NotificationCenter.default
        
        notificationCenter.addObserver(self, selector: #selector(userDefaultsDidChange), name: UserDefaults.didChangeNotification, object: nil)
        
        
        // Configure Google Sign-in.
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().scopes = scopes
        
        GIDSignIn.sharedInstance().clientID = "699945398009-sms6e0cpoam9cp6631nbi38v910s73rv.apps.googleusercontent.com"
        GIDSignIn.sharedInstance().signInSilently()
        
        
        // Add the sign-in button.
        tapToFinish.addSubview(signInButton)
        
        if(signedIn){
            driveFileManager = userSetUp(driveService: service, withFilePath: String(describing: pdfGenerator.createPDFFileAndReturnPath(indexAt:userInfoController.getResumeIndex()).output))
        }
        userDefaultsDidChange()
        
        if( userData.last?.value(forKeyPath: "firstName") != nil){
            let nameString: String = (userData.last?.value(forKeyPath: "firstName") as? String)!
            welcomeLabel.text = "Welcome " +  nameString.firstUppercased + ","
        } else {
            welcomeLabel.text = "Welcome,"
        }
        
        signInButton.clipsToBounds = true
        
        
        if(userInfoController.fetchData() == "main2"){
            
            let aUser = userData.last
            firstNameEntry.text = aUser?.value(forKeyPath: "firstName") as? String
            lastNameEntry.text = aUser?.value(forKeyPath: "lastName") as? String
            emailEntry.text = aUser?.value(forKeyPath: "emailAdress") as? String
            phoneEntry.text = aUser?.value(forKeyPath: "phoneNumber") as? String
            currentSchoolEntry.text = aUser?.value(forKeyPath: "schoolName") as? String
        }
        
        
        if (Device.isPad()){
            print("It's an iPad")
            self.backgroundImage.frame = CGRect(x: 0, y: 0, width: 768, height: 1024)
            self.containerView.frame = CGRect(x: 213, y: 273, width: 343, height: 242)
            self.firstNameEntry.frame = CGRect(x: 272, y: 654, width: 224, height: 30)
            self.tapToFinish.frame = CGRect(x: 323, y: 701, width: 122, height: 48)
        }
        
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated) // No need for semicolon
        
    }
    
    /*
    Detects if the settings in userInfo.swift has changed.
    */
     @objc func userDefaultsDidChange() {
        
        loadData()
        print("USER DEFAULTS CHANGED")
        let aUser = userData.last
        if(userInfoController.fetchData() == "main" || userInfoController.fetchData() == "main2"){
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
            print("FOLDER ID OF" + String(describing: pdfGenerate.createPDFFileAndReturnPath(indexAt: userInfoController.getResumeIndex()).output))
            
            print("EL es tu" + userInfoController.getFolderID())
            let meFile =  pdfGenerate.createPDFFileAndReturnPath(indexAt: userInfoController.getResumeIndex()).output
            
            let fileManager = FileManager.default
            if fileManager.fileExists(atPath: String(describing: meFile)) {
                print("FILE AVAILABLE")
            } else {
                print("FILE NOT AVAILABLE")
            }
            driveFileManager = userSetUp.init(driveService: service, withFilePath: "String!")
            driveFileManager.upload(toFolder: userInfoController.getFolderID(), atFilePath: String(describing: pdfGenerate.createPDFFileAndReturnPath(indexAt: userInfoController.getResumeIndex()).output), withFileName: generateResumeName())
        }
        
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        
        self.uploadFolder()
        
        
        
        
        
        
    }
    
    func uploadFolder(){
        print("yuo are" + String(signedIn) + "signed in " )
        dataController.savefirstName(firstName: firstNameEntry.text!)
        dataController.saveLastName(lastName: lastNameEntry.text!)
        dataController.saveEmail(email: emailEntry.text!)
        dataController.savePhoneNumber(phoneNumber: phoneEntry.text!)
        dataController.saveSchool(schoolName: currentSchoolEntry.text!)
        
        
        fetchFolder()
        
        
        if(signedIn){
            driveFileManager.upload(toFolder: userInfoController.getFolderID(), atFilePath: String(describing: pdfGenerate.createPDFFileAndReturnPath(indexAt: userInfoController.getResumeIndex()).output), withFileName: generateResumeName())
        }
        
        
        
        view.endEditing(true)
        print("else it is located at" + userInfoController.getFolderID())
    }
    
    /*
    Sets the name for the file to be uploaded to google drive.
    */
    
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
    
    /*
    Returns the folder ID if it isnt already saved by calling returnFoldername.
    */
    func fetchFolder() {
        loadData()
        let query = GTLRDriveQuery_FilesList.query()
        query.pageSize = 10
        
        service.executeQuery(query,
                             delegate: self,
                             didFinish: #selector(returnFolderName(ticket:finishedWithObject:error:))
        )
    }
    
    /*
    Gathers a list of file names on the user's drive, and if it finds a folder matching the user's name it saves the google drive fileID.
    */
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
        
        if(text != "No files found." && userInfoController.getFolderID() == "noFolder" &&  text != "" && !text.isEmpty){
            userInfoController.saveFolderID(folderID: text)
            driveFileManager.upload(toFolder: userInfoController.getFolderID(), atFilePath: String(describing: pdfGenerate.createPDFFileAndReturnPath(indexAt: userInfoController.getResumeIndex()).output), withFileName: generateResumeName())
        }
        
    }
    
    /*
    Shows any error messages as an alert.
    */
    
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
    
    /*
    Signs the user in, using the googleSignIDButton.
    */
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
               
                print(userInfoController.getFolderID())
                driveFileManager.createFolder(userLastName! + "_" + userFirstName!)
                
            }
            
 
            fetchFolder()
            userDefaultsDidChange()
            self.uploadFolder()
            
            
            //driveFileManager.upload(toFolder: userInfoController.getFolderID(), atFilePath: String(describing: pdfGenerate.createPDFFileAndReturnPath(indexAt: userInfoController.getResumeIndex()).output), withFileName: generateResumeName())
        }
    }
    
    
    
    /*
    Loads the data to be used by the uitextfields/labels of the settings viewcontroller
    */
    func loadData(){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        var managedContext:NSManagedObjectContext
        if #available(iOS 10.0, *) {
            managedContext = appDelegate.persistentContainer.viewContext
        } else {
            // Fallback on earlier versions
            managedContext = appDelegate.managedObjectContext
        }
        
        let userRequest = NSFetchRequest<NSManagedObject>(entityName: "User")
        //let timeRequest = NSFetchRequest<NSManagedObject>(entityName: "Time")
        do {
            userData = try managedContext.fetch(userRequest)
            
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
}
