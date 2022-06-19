//
//  SigninViewController.swift
//  createchat
//
//  Created by Ishfaq Ahmad on 17/03/2022.
//

import UIKit
import FirebaseAuth

class SigninViewController: UIViewController {

    @IBOutlet weak var emailTxtfield: UITextField!
    
    @IBOutlet weak var passwordTxtfield: UITextField!
    
    @IBOutlet weak var loginBtn: UIButton!
    
    @IBOutlet weak var errorLbl: UILabel!
    
    @IBOutlet weak var signupBtn: UIButton!
    
    
    
    var signupcontroler = SignupViewController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
          if  UserDefaults.standard.bool(forKey: "login") == true {
            
            let navigatetouserscreen = self.storyboard?.instantiateViewController(identifier: "userViewController") as? userViewController
            self.navigationController?.pushViewController (navigatetouserscreen!, animated: true)
            self.view.window?.rootViewController = navigatetouserscreen
            self.view.window?.makeKeyAndVisible()
            
        }
        else {
            let navigatetosiginup = self.storyboard?.instantiateViewController(identifier: "SignupViewController") as? SignupViewController

            self.view.window?.rootViewController = navigatetosiginup
            self.view.window?.makeKeyAndVisible()
        }
        
        setUpElements()
    }
    

    func setUpElements() {

                errorLbl.alpha = 0
                
                Utilities.styleTextField(emailTxtfield)
                
                Utilities.styleTextField(passwordTxtfield)
                
             
    
    }
    
    
    
    @IBAction func signupbTn(_ sender: Any) {
        //popup()
    }
    
    @IBAction func loginTapped(_ sender: Any) {
        
        // TODO: Validate Text Fields
        
        // Create cleaned versions of the text field
        let email = emailTxtfield.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordTxtfield.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        UserDefaults.standard.set(true, forKey: "login")
        // Signing in the user
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            
            if error != nil {
                // Couldn't sign in
//                self.errorLbl.text = error!.localizedDescription
//                self.errorLbl.alpha = 1
                self.signupcontroler.showalert("error creating new user")
                
            }
            else {
                
                let homeViewController = self.storyboard?.instantiateViewController(identifier: "userViewController") as? userViewController
                
                self.view.window?.rootViewController = homeViewController
                self.view.window?.makeKeyAndVisible()
            }
        }
    }
//    func popup(){
//    let viewControllers: [UIViewController] = self.navigationController!.viewControllers ;
//
//            for aViewController in viewControllers {
//                if(aViewController is userViewController){
//                     self.navigationController!.popToViewController(aViewController, animated: true);
//                }
//            }
//}
}



