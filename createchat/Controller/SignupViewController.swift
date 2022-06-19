//
//  SignupViewController.swift
//  createchat
//
//  Created by Ishfaq Ahmad on 17/03/2022.
//

import UIKit
import FirebaseAuth
import Firebase

class SignupViewController: UIViewController {

    @IBOutlet weak var firstnameTxtfield: UITextField!
    @IBOutlet weak var lastnameTxtfield: UITextField!
    
    @IBOutlet weak var emailTxtfield: UITextField!
    
    @IBOutlet weak var passwordTxtfield: UITextField!
    
    @IBOutlet weak var signupBtn: UIButton!
    
    @IBOutlet weak var errorLbl: UILabel!
    
    @IBOutlet weak var signinBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpElements()
        passwordTxtfield.enablePasswordToggle()
    }
    
    func setUpElements() {
        
            errorLbl.alpha = 0
            
            Utilities.styleTextField(firstnameTxtfield)
            
            Utilities.styleTextField(lastnameTxtfield)
            
            Utilities.styleTextField(emailTxtfield)
            
            Utilities.styleTextField(passwordTxtfield)
            
         
            
    }
    
    // Check the fields and validate that the data is correct. If everything is correct, this method returns nil. Otherwise, it returns the error message
    func validateFields() -> String? {
        
        // Check that all fields are filled in
        if firstnameTxtfield.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            lastnameTxtfield.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            emailTxtfield.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordTxtfield.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            
            return "Please fill in all fields."
        }
        
        // Check if the password is secure
        let cleanedPassword = passwordTxtfield.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if Utilities.isPasswordValid(cleanedPassword) == false {
            // Password isn't secure enough
            return "Please make sure your password is at least 8 characters, contains a special character and a number."
        }
        
        return nil
    }
    
    @IBAction func signin(_ sender: Any) {
    }
    
    @IBAction func signUpTapped(_ sender: Any) {
        
        // Validate the fields
        let error = validateFields()
        
        if error != nil {
            showalert(error!)
            // There's something wrong with the fields, show error message
            //showError(error!)
        }
        else {
            
            // Create cleaned versions of the data
            let firstName = firstnameTxtfield.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastName = lastnameTxtfield.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailTxtfield.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTxtfield.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            // Create the user
            Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
                
                // Check for errors
                if err != nil {
                    
                    // There was an error creating the user
                    //self.showError("Error creating user")
                    self.showalert("error creating new user")
                }
                else {
                    
                    // User was created successfully, now store the first name and last name
                    let db = Firestore.firestore()
                    
                    db.collection("users").addDocument(data: ["firstname":firstName, "lastname":lastName, "uid": result!.user.uid ]) { (error) in
                        
                        if error != nil {
                            // Show error message
                            //self.showError("Error saving user data")
                            self.showalert("user data not found")
                        }
                    }
                    
                    // Transition to the home screen
                    self.transitionToHome()
                }
                
            }
            
            
            
        }
    }
    
    func showError(_ message:String) {
        
        errorLbl.text = message
        errorLbl.alpha = 1
    }
    
    func transitionToHome() {
        
        let homeViewController = storyboard?.instantiateViewController(identifier: "userViewController") as? userViewController
        
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
        
    }
  open func showalert(_ message:String){
        let alert = UIAlertController(title: "please make sure your passwod or Email is correct", message: "please Enter Correct Detail", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(defaultAction)
                      self.present(alert, animated: true, completion: nil)

    }
}
extension UITextField {
fileprivate func setPasswordToggleImage(_ button: UIButton) {
    if(isSecureTextEntry){
        button.setImage(UIImage(named: "eye on"), for: .normal)
    }else{
        button.setImage(UIImage(named: "no eye"), for: .normal)

    }
}
    
func enablePasswordToggle(){
    let button = UIButton(type: .custom)
    setPasswordToggleImage(button)
    button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -16, bottom: 0, right: 0)
    button.frame = CGRect(x: CGFloat(self.frame.size.width - 25), y: CGFloat(5), width: CGFloat(15), height: CGFloat(15))
    button.addTarget(self, action: #selector(self.togglePasswordView), for: .touchUpInside)
    self.rightView = button
    self.rightViewMode = .whileEditing
}
@IBAction func togglePasswordView(_ sender: Any) {
    self.isSecureTextEntry = !self.isSecureTextEntry
    setPasswordToggleImage(sender as! UIButton)
}
}


   


