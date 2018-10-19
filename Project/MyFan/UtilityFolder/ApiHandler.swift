//
//  ApiHandler.swift
//  MyFan
//
//  Created by user on 31/08/18.
//  Copyright © 2018 user. All rights reserved.
//

import Foundation
import Alamofire
//import PKHUD

//MARK:-- Make get requset

func getData(url:String,parameter:[String:String]?,header:[String:String]?,vc:UIViewController,showHud:String,title:String,message:String, completion:@escaping (NSDictionary?)->()){
 
   
    if Utility().currentReachabilityStatus == .notReachable{
        
        Utility().displayAlert(title: "No internet connection", message: "", control: ["ok"])
        return
    }
    if showHud == "yes"{
        
        Indicator.shared().start()
    }
    Alamofire.request(url, method: .get, parameters: parameter, encoding: JSONEncoding.default, headers: header).responseJSON
        {
            response in
             Indicator.shared().stop()
            switch(response.result)
            {
            case .success(_):
             
                if let data = response.result.value as? NSDictionary{
                    if let status = data.value(forKey: "message") as? String{
                        
                        if(status == "This Request Needs a token to be present in header."){
                            
                            let appDelegate = UIApplication.shared.delegate as! AppDelegate
                            
                            completion(nil)
                            print("done")
                            Utility().displayAlertWithCompletion( title: "Session", message: "Your session has been expired. Please login again!", control: ["Ok"], completion: { (str) in
                                appDelegate.createLoginRoot()
                                
                            })
                        }else{
                            
                            completion(data)
                        }
                    }else{
                    completion(data)
                    }
                }
                
                break
            case .failure(let error):
              
                print(error.localizedDescription)
                //Fetch Server Error
                
                print(error.localizedDescription)
                print(error)
                if let data = response.data, let str = String(data: data, encoding: String.Encoding.utf8){
                    print("Server Error: " + str)
                }
                debugPrint(error as Any)
                print("===========================\n\n")
                completion(nil)
                break
                print(error.localizedDescription)
                completion(nil)
                break
            }
    }
    
}


//MARK:-- Make post requset


func postData(url:String,parameter:[String:Any]?,header:[String:String]?,vc:UIViewController?,showHud:String, completion:@escaping (NSDictionary?)->()){
    if Utility().currentReachabilityStatus == .notReachable{
        
        Utility().displayAlert(title: "No internet connection", message: "", control: ["ok"])
        return
    }
    if showHud == "yes"{
        
        Indicator.shared().start()
    }
    Alamofire.request(url, method: .post, parameters: parameter, encoding: JSONEncoding.default, headers: header).responseJSON
        {
            response in
          Indicator.shared().stop()
            switch(response.result)
            {
            case .success(_):
                print(response)
     
                if let data = response.result.value as? NSDictionary{
                    if let status = data.value(forKey: "message") as? String{
                        
                        if(status == "This Request Needs a token to be present in header."){
                            
                            let appDelegate = UIApplication.shared.delegate as! AppDelegate
                            
                            completion(nil)
                            print("done")
                            Utility().displayAlertWithCompletion( title: "Session", message: "Your session has been expired. Please login again!", control: ["Ok"], completion: { (str) in
                                appDelegate.createLoginRoot()
                                
                            })
                        }
                        else{
                            
                            completion(data)
                        }
                    }
                    else{
                        
                        if let success = data.value(forKey: "success") as? Int{
                            if success == 1{
                                completion(data)
                            }else{
                                completion(data)
                            }
                        }else{
                             completion(data)
                            
                        }
                    }
                    
                }
                break
            case .failure(let error):
              Indicator.shared().stop()
                print(error.localizedDescription)
                //Fetch Server Error
                
                print(error.localizedDescription)
                print(error)
                if let data = response.data, let str = String(data: data, encoding: String.Encoding.utf8){
                    print("Server Error: " + str)
                }
                debugPrint(error as Any)
                print("===========================\n\n")
                completion(nil)
                break
            }
    }
    
}



//MARK:-- Post Image with Data
func postDataWithImage(url:String,parameter:NSDictionary,header:[String:String]?,dictUploadData: [String:Data?]?,vc:UIViewController,showHud:String,title:String,message:String, completion:@escaping (NSDictionary?)->()) {
    

    if Utility().currentReachabilityStatus == .notReachable{
        
        Utility().displayAlert(title: "No internet connection", message: "", control: ["ok"])
        return
    }
    if showHud == "yes"{
        
        Indicator.shared().start()
    }
    Alamofire.upload(multipartFormData: { multipartFormData in
        
        for (key, value) in parameter {
            print(key as! String)
            multipartFormData.append((value as! String).data(using: String.Encoding.utf8)!, withName: key as! String)
        }
        if dictUploadData != nil {
        for (key, value) in dictUploadData! {
            print(key)
            if key .contains("image"){
                if let data = value {
                    multipartFormData.append(data , withName: key , fileName: "\(key).jpeg", mimeType: "image/jpeg")
                }
//                if (dictUploadData.value(forKey: key as! String)as! Data).count != 0{
//                }
            }
            else{
                if let data = value{
                
                    multipartFormData.append(data , withName: key , fileName: "\(key).mp4", mimeType: "video/mp4")
                }
            }
        }
        }
        
    }, usingThreshold: UInt64.init(), to:url, method: .post, headers: header, encodingCompletion: { encodingResult in
        
        switch encodingResult{
            
        case .success(let upload,_,_):
            upload.responseJSON { response in
                debugPrint(response)
                Indicator.shared().stop()
                if let data = response.result.value
                {
                    let dict = data as! NSDictionary
                    completion(dict)
            
                }
            }
        case .failure(let error):
            // Fetch Server Error
            Indicator.shared().stop()
            print(error.localizedDescription)
            print(error)
            //                            if let data = response.data, let str = String(data: data, encoding: String.Encoding.utf8){
            //                                print("Server Error: " + str)
            //                            }
            debugPrint(error as Any)
            print("===========================\n\n")
            completion(nil)
        
            break
            // completion(nil)
        }
    })
}



// one image
func postDataWithImage2(url:String,parameter:NSDictionary,header:[String:String]?,dictUploadData: [String:Data?]?,vc:UIViewController,showHud:String,title:String,message:String, completion:@escaping (NSDictionary?)->()) {
    
    
    if Utility().currentReachabilityStatus == .notReachable{
        
        Utility().displayAlert(title: "No internet connection", message: "", control: ["ok"])
        return
    }
    if showHud == "yes"{
        
        Indicator.shared().start()
    }
    Alamofire.upload(multipartFormData: { multipartFormData in
        
        for (key, value) in parameter {
            print(key as! String)
            multipartFormData.append((value as! String).data(using: String.Encoding.utf8)!, withName: key as! String)
        }
        if dictUploadData != nil {
            for (var key, value) in dictUploadData! {
                print(key)
                print(value!)
                
              //  if key .contains("image"){
                    if let data = value {
                      //  key = key.replacingOccurrences(of: "image", with: "")
                        multipartFormData.append(data , withName: "file" , fileName: key, mimeType: "")
                    }
                    
//                }
//                else if key .contains("video"){
//                    if let data = value{
//                     //   key = key.replacingOccurrences(of: "video", with: "")
//                        multipartFormData.append(data , withName: key , fileName: key, mimeType: "")
//                    }
//                }else{
//                    if let data = value{
//                     //   key = key.replacingOccurrences(of: "audio", with: "")
//                        multipartFormData.append(data , withName: key , fileName: key, mimeType: "")
//                    }
//
//                }
                
                
                
//                if key .contains("image"){
//                    if let data = value {
//                        key = key.replacingOccurrences(of: "image", with: "")
//                        multipartFormData.append(data , withName: key , fileName: "\(key).gif", mimeType: "")
//                    }
//
//                }
//                else if key .contains("video"){
//                    if let data = value{
//                        key = key.replacingOccurrences(of: "video", with: "")
//                        multipartFormData.append(data , withName: key , fileName: "\(key).mp4", mimeType: "video/mp4")
//                    }
//                }else{
//                    if let data = value{
//                          key = key.replacingOccurrences(of: "audio", with: "")
//                        multipartFormData.append(data , withName: key , fileName: "\(key).mp3", mimeType: "video/mp4")
//                    }
//
//                }
            }
        }
        
    }, usingThreshold: UInt64.init(), to:url, method: .post, headers: header, encodingCompletion: { encodingResult in
       
        switch encodingResult{
            
        case .success(let upload,_,_):
            upload.responseJSON { response in
                debugPrint(response)
                Indicator.shared().stop()
                if let data = response.result.value
                {
                    let dict = data as! NSDictionary
                    completion(dict)
                    
                }
            }
        case .failure(let error):
            Indicator.shared().stop()
            // Fetch Server Error
            print(error.localizedDescription)
            print(error)
            //                            if let data = response.data, let str = String(data: data, encoding: String.Encoding.utf8){
            //                                print("Server Error: " + str)
            //                            }
            debugPrint(error as Any)
            print("===========================\n\n")
            completion(nil)
            
            break
            // completion(nil)
        }
    })
}


