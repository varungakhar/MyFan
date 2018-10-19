//
//  SignUpViewModel.swift
//  MyFan
//
//  Created by user on 03/09/18.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit

class SignUpViewModel: NSObject {
    
    
func signUp(parameter: [String:Any],vc:UIViewController ,completion:@escaping (Bool?)->()){

    print(parameter)
    let header = ["Accept":"application/json"]
            print(KMainUrl+KSignup)
            postData(url: KMainUrl+KSignup, parameter: parameter, header: header, vc: vc, showHud: "yes") { (DictResponce) in
                if let sccses = DictResponce?.value(forKey: "success")as? Bool{
                    if sccses == true{
                        if let dict = DictResponce as?[String:Any]{
                            
                            if let dictUser = dict["user"]as? [String:Any]{
                                
                          if let str = dictUser["token"] as? String{
                            
                            objLoginData.setUserDefaults(token: str, login: false)
                            completion(true)
                          }else{
                            completion(false)
                                }
                            }else{
                                completion(false)
                            }
                            
                        }else{
                            completion(false)
                        }
                        
                    }else{
                        completion(false)
                    }
                }
            }
    }
    

    
}
