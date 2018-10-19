//
//  LoginViewController.swift
//  MyFan
//
//  Created by user on 31/08/18.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit
let objLoginData = LoginModel()
class LoginViewController: UIViewController {

    @IBOutlet weak var imgInsta: UIImageView!
    @IBOutlet weak var imgLinkedIn: UIImageView!
    @IBOutlet weak var imgPintrest: UIImageView!
    @IBOutlet weak var imgTwitter: UIImageView!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    
    @IBOutlet weak var viewMainForget: UIView!
    @IBOutlet weak var txtForgetEmail: UIView!
    let objLogin = LoginViewModel()
    
    var showForgetView:Bool? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
    if showForgetView != nil{
     viewMainForget.isHidden = false
       }else{
       viewMainForget.isHidden = true
    }
        self.navigationController?.isNavigationBarHidden = true
    }

    @IBAction func btnForgetPassword(_ sender: Any) {
        viewMainForget.isHidden = false
    }
    
    @IBAction func btnSignInAction(_ sender: Any) {
        
        if txtEmail.text == ""{
              Utility().displayAlert(title: "", message: "Please enter your email", control: ["ok"])
        }else if !Utility().isValidEmail(testStr: txtEmail.text!){
            
            Utility().displayAlert(title: "", message: "Please enter valid email", control: ["ok"])
        }
        else if txtPassword.text == ""{
            Utility().displayAlert(title: "", message: "Please enter password", control: ["ok"])
        }else{
            let param = ["user":["email":txtEmail.text!,"password":txtPassword.text!]]
            
            objLogin.login(parameter: param, vc: self) { (responce) in
                if responce!{
                    Utility().pushViewControl(ViewControl: "DashboardViewController")

                }else{
                   Utility().displayAlert(title: "", message: "Invalid credentials", control: ["ok"])
                }
            }
        }
       
    }
    
    @IBAction func btnSignUPAction(_ sender: Any) {
        Utility().pushViewControl(ViewControl: "SignUpViewController")
       //  Utility().pushViewControl(ViewControl: "SignUpScreen2ViewController")
    }
    
    
    @IBAction func btnBackToLoginAction(_ sender: Any) {
        viewMainForget.isHidden = true
    }
    
    @IBAction func btnSubmitAction(_ sender: Any) {
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

 
}
