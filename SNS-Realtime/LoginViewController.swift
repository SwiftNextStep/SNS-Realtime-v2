//
//  LoginViewController.swift
//  SNS-Realtime
//
//  Created by Icaro Barreira Lavrador on 11/10/15.
//  Copyright © 2015 Icaro Barreira Lavrador. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    var firebase = Firebase(url: "https://sns-realtimeapp.firebaseio.com/")
    
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    
    @IBAction func LoginButton(sender: UIButton) {
        logUser()
    }
    
    @IBAction func Signup(sender: UIButton) {
        if checkFields(){
            firebase.createUser(emailTextfield.text, password: passwordTextfield.text) { (error:NSError!) -> Void in
                if (error != nil){
                    print(error.localizedDescription)
                    self.displayMessage(error)
                } else{
                    print("New user created")
                    self.logUser()
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func logUser(){
        if checkFields(){
            print("Start loggin user")
            firebase.authUser(emailTextfield.text, password: passwordTextfield.text) { (error:NSError!, authData:FAuthData!) -> Void in
                if (error != nil){
                    print(error.localizedDescription)
                    self.displayMessage(error)
                } else{
                    print("user logged \(authData.description)")
                    self.performSegueWithIdentifier("mainSegue", sender: self)
                }
            }
        }
    }
    
    func checkFields()->Bool{
        if ((!emailTextfield.text!.isEmpty) && (!passwordTextfield.text!.isEmpty)){
            return true
        } else{
            print("Empty field was found")
            return false
        }
    }
    
    func displayMessage(error:NSError){
        let titleMessage = "Error"
        let alert = UIAlertController(title: titleMessage, message: error.localizedDescription, preferredStyle: .Alert)
        let actionOk = UIAlertAction(title: "Ok", style: .Default, handler: nil)
        alert.addAction(actionOk)
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
