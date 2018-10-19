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
//             'Content-Type: application/x-www-form-urlencoded' --header 'Accept: application/json'
   // "Content-Type":"application/x-www-form-urlencoded",
    print(parameter)
            let header = [
                          "Accept":"application/json",
                          "Authorization":"Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoiWXpudVdweHk2eVhHMzRfR3luVEUiLCJleHAiOjE1MzA5NTMwNDB9.8kmRca_BbXHsmjgctK6XiHWez--QoOhEGRck7NO_ELU"]
            print(KMainUrl+KSignup)
            postData(url: KMainUrl+KSignup, parameter: parameter, header: header, vc: vc, showHud: "yes") { (DictResponce) in
                print(DictResponce)
            }
    }
    

    
}
