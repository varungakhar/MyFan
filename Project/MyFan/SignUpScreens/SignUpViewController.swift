//
//  SignUpViewController.swift
//  MyFan
//
//  Created by user on 31/08/18.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    @IBOutlet weak var txtFullName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtFldName: UITextField!
    @IBOutlet weak var txtFldAddress: UITextField!
    @IBOutlet weak var txtFldPassword: UITextField!
    @IBOutlet weak var txtFldCnfirmPassword: UITextField!
    
    var dictData = [String:Any]()
    let objSignUpViewModel = SignUpViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()

       
        
        txtFullName.delegate = self
        txtEmail.delegate = self
        txtFldName.delegate = self
      //  txtFldAddress.delegate = self
        txtFldPassword.delegate = self
        txtFldCnfirmPassword.delegate = self
    }

    @IBAction func btnSignUpAction(_ sender: Any) {
      //  Utility().pushViewControl(ViewControl: "SignUpScreen2ViewController")
        
        if txtFullName.text! == ""{
            Utility().displayAlert(title: "", message: "Please enter your full name", control: ["ok"])
        }else if txtEmail.text! == ""{
            Utility().displayAlert(title: "", message: "Please enter your email", control: ["ok"])
        }
        else if !Utility().isValidEmail(testStr: txtEmail.text!){
              Utility().displayAlert(title: "", message: "Please enter valid email", control: ["ok"])
        }
        else if txtFldName.text! == ""{
          Utility().displayAlert(title: "", message: "Please enter your user name", control: ["ok"])
        }
        else if txtFldPassword.text! == ""{
             Utility().displayAlert(title: "", message: "Please enter your password", control: ["ok"])
        }
        else if  txtFldCnfirmPassword.text! == ""{
             Utility().displayAlert(title: "", message: "Please confirm password", control: ["ok"])
        }else if txtFldPassword.text! !=  txtFldCnfirmPassword.text! {
            Utility().displayAlert(title: "", message: "Confirm password did not match", control: ["ok"])
        }else{
       
                dictData = ["user":["full_name":txtFullName.text!, "email": txtEmail.text!,"user_name":txtFldName.text!,"password":txtFldPassword.text! , "password_confirmation":txtFldCnfirmPassword.text!,
                    "current_location_attributes":["lat":"2356", "lng":"2569", "city":"Mohali", "name":"phase 5, bypass road"]]
                ]
            
            signUp(param: dictData)
        }
    }
    
    internal func signUp(param:[String:Any]){
    objSignUpViewModel.signUp(parameter: param, vc: self) { (responce) in
        if responce!{
            Utility().pushViewControl(ViewControl: "SignUpScreen2ViewController")
        }else{
            Utility().displayAlert(title: "", message: "problem in sign up", control: ["ok"])
        }
    }
    }
    
    @IBAction func btnLoginAction(_ sender: Any) {
        Utility().pushViewControl(ViewControl: "LoginViewController")
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
extension SignUpViewController:UITextFieldDelegate{
    

    
}
