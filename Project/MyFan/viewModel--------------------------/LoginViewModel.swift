//
//  LoginViewModel.swift
//  MyFan
//
//  Created by user on 03/09/18.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit

class LoginViewModel: NSObject {

    func login(parameter: [String:Any],vc:UIViewController ,completion:@escaping (Bool?)->()){
      
        print(parameter)
        let header = [
            "Accept":"application/json"]
        
        postData(url: KMainUrl+KLogin, parameter: parameter, header: header, vc: vc, showHud: "yes") { (DictResponce) in
           // print(DictResponce)
            if let sccses = DictResponce?.value(forKey: "success")as? Bool{
                if sccses == true{
                    if let dict = DictResponce as? [String:Any]{
                    objLoginData.setData(dict: dict)
                    }
                    
                    completion(true)
                }else{
                     completion(false)
                }
            }
        }
    }

}
