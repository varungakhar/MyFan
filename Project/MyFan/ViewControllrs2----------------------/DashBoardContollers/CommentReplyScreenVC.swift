//
//  CommentReplyScreenVC.swift
//  MyFan
//
//  Created by user on 15/10/18.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit

class CommentReplyScreenVC: UIViewController {
    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var txtCommnt: UITextView!
    var selectedIndex = Int()
    var objComment3 = CommentViewModel()
 
    override func viewDidLoad() {
        super.viewDidLoad()

        txtCommnt.delegate = self
        txtCommnt.text = "Share with my fans"
        txtCommnt.textColor = UIColor.lightGray
    }

    
    @IBAction func btnShareAction(_ sender: Any) {
        if txtCommnt.text == "Share with my fans"{
            
            Utility().displayAlert(title: "Please add some reply", message: "", control: ["ok"])
        }else{
            objComment3.reply_To_Comment(txt:txtCommnt.text!,Index: selectedIndex, vc: self) { (responce, msg) in
                if responce!{
                    self.presentingViewController?
                        .presentingViewController?.dismiss(animated: true, completion: nil)
                }else{
                  Utility().displayAlert(title: "Unable to reply!", message: "", control: ["ok"])
                }
            }
        }
    }
    
    @IBAction func btnBackAction(_ sender: Any) {
        self.presentingViewController?
            .presentingViewController?.dismiss(animated: true, completion: nil)
      // self.dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

 

}

extension CommentReplyScreenVC:UITextViewDelegate{
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        if txtCommnt.textColor == UIColor.lightGray {
            txtCommnt.text = ""
            txtCommnt.textColor = UIColor.black
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        
        if txtCommnt.text == "" {
            
            txtCommnt.text = "Share with my fans"
            txtCommnt.textColor = UIColor.lightGray
        }
    }
    
}
