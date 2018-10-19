//
//  SignUpScreen5ViewController.swift
//  MyFan
//
//  Created by user on 31/08/18.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit

class SignUpScreen5ViewController: UIViewController {
    @IBOutlet weak var imgViewUser: ImageCustom!
    
    @IBOutlet weak var txtBusinessName: UITextField!
    
    @IBOutlet weak var txtMobileName: UITextField!
    @IBOutlet weak var switchOutlet: UISwitch!
    
    @IBOutlet weak var viewSendToLogin: UIView!
    
    @IBOutlet weak var viewSendToLoginTopCost: NSLayoutConstraint!
    
     var imgPicker = UIImagePickerController()
     var PhVisibility = String()
    var objSign2 = SignUp2ViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
       imgPicker.delegate = self
        
//      viewSendToLogin.frame = CGRect(x: 0, y: self.view.frame.height+10, width: self.view.frame.width, height: self.view.frame.height)
      viewSendToLoginTopCost.constant = self.view.frame.height+10
        self.view.layoutIfNeeded()
    }

    @IBAction func SwitchAction(_ sender: UISwitch) {
        if switchOutlet.isOn {
           PhVisibility = "1"
        } else {
         PhVisibility = "0"
        }
    }
    
    @IBAction func btnFinish(_ sender: Any) {
         postSignUpStepData()
    }
     @IBAction func btnEditAction(_ sender: Any) {
        Utility().OpenActionSheet { (responce) in
            if responce == "Camera"{
                self.imgPicker.sourceType = .camera
                self.imgPicker.allowsEditing = true
                self.present(self.imgPicker, animated: true, completion: nil)
            }else if responce == "Photo Library"{
                self.imgPicker.sourceType = .photoLibrary
                self.imgPicker.allowsEditing = true
                self.present(self.imgPicker, animated: true, completion: nil)
            }else{
                
            }
        }
    }
    
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

    func postSignUpStepData(){
        
        if txtBusinessName.text == ""{
            Utility().displayAlert(title: "Please enter business name", message: "", control: ["ok"])
        }else if txtMobileName.text == ""{
          Utility().displayAlert(title: "Please enter mobile name", message: "", control: ["ok"])
        }else{
        
     
        guard let ImgData = UIImageJPEGRepresentation(imgViewUser.image!, 0.5) else{
           return
        }
         let dictImg = ["user[profile_image_attributes][attachment]":ImgData]
        
       let param = ["user[phone]":txtMobileName.text!,
        "user[business_name]":txtBusinessName.text!,
        "user[phone_visibility]":PhVisibility,
        "signup_finish":"ok"]
        
        objSign2.postSignUpStepData(param: param, dictImg: dictImg, vc: self) { (responce) in
            if responce!{
              self.presentLoginView()
            }else{
                
            }
        }
        }
    }
    
    func presentLoginView(){
        UIView.animate(withDuration: 0.25, delay: 0.0, options: [], animations: {
//            self.viewSendToLogin.frame = CGRect(x: 0, y:0, width: self.view.frame.width, height: self.view.frame.height)
            self.viewSendToLoginTopCost.constant = 0
            self.view.layoutIfNeeded()
        }, completion: { (finished: Bool) in
            
        })

    }
    
    @IBAction func btnGoToLogin(_ sender: Any) {
        Utility().pushViewControl(ViewControl: "LoginViewController")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    



}
extension SignUpScreen5ViewController:UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        self.imgPicker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        print(info)
        let PickerImg = info["UIImagePickerControllerEditedImage"]as! UIImage
        imgViewUser.image = PickerImg
       // isImageSelected = true
        self.dismiss(animated: true, completion: nil)
    }
    
}
