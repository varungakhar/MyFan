//
//  LoginModel.swift
//  MyFan
//
//  Created by user on 05/09/18.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit

class LoginModel: NSObject {

    var  id:String? = nil
    
     var  role:String? = nil
       var  full_name:String? = ""
       var  user_name:String? = ""
       var  email:String? = nil
       var  phone:String? = nil
       var  slug:String? = nil
       var  professional_category_id:String? = nil
       var  professional_sub_category_name:String? = nil
       var  allow_login:String? = nil
       var  musician:String? = nil
       var online :String? = nil
       var  can_ad:String? = nil
       var  time_zone:String? = nil
       var  website:String? = nil
       var  featured:String? = nil
       var  progress_status:String? = nil
       var  phone_visibility:String? = nil
    var  website_visibility:String? = nil
    var  email_visibility:String? = nil
    var  dob_visibility :String? = nil
    var  created_at:String? = nil
    var  updated_at:String? = nil
    var  token:String? = nil
    
    var arrIntrst = [IntrestModel]()
      var arrLocation = [LocationModel]()
     var  banner_image_url:String? = ""
     var  profile_image_url:String? = ""
    
    func setUserDefaults(token:String,login:Bool){
        UserDefaults.standard.set(token, forKey: "Ktoken")
        if login{
        UserDefaults.standard.set("tru", forKey: "KisLogin")
        }
    }
    
    func setData(dict:[String:Any]){
        
        if let str = dict["banner_image_url"] as? String{
            banner_image_url = String(str)
        }
        
        if let str = dict["profile_image_url"] as? String{
            profile_image_url  = str
        }
        
        
        
    if let dictUser = dict["user"]as? [String:Any]{
        
        if let str = dictUser["id"] as? Int{
            id = String(str)
        }else{
            if let str = dictUser["id"] as? String{
                id = str
            }
        }
        
        if let str = dictUser["role"] as? String{
           role  = str
        }
        
        if let str = dictUser["full_name"] as? String{
           full_name = str
        }
        if let str = dictUser["user_name"] as? String{
          user_name  = str
        }
        if let str = dictUser["email"] as? String{
          email  = str
        }
        if let str = dictUser["phone"] as? String{
           phone = str
        }
        if let str = dictUser["slug"] as? String{
          slug  = str
        }
        if let str = dictUser["professional_category_id"] as? String{
          professional_category_id  = str
        }
        if let str = dictUser["professional_sub_category_name"] as? String{
          professional_sub_category_name  = str
        }
        
        if let str = dictUser["allow_login"] as? String{
           allow_login = str
        }
        if let str = dictUser["musician"] as? String{
           musician = str
        }
        if let str = dictUser["online"] as? Bool{
           online = String(str)
        }
        if let str = dictUser["can_ad"] as? String{
          can_ad  = str
        }
        if let str = dictUser["time_zone"] as? String{
           time_zone = str
        }
        if let str = dictUser["website"] as? String{
          website  = str
        }
        if let str = dictUser["featured"] as? String{
           featured = str
        }
        if let str = dictUser["progress_status"] as? String{
          progress_status  = str
        }
        if let str = dictUser["phone_visibility"] as? String{
           phone_visibility = str
        }
        if let str = dictUser["website_visibility"] as? String{
          website_visibility  = str
        }
        if let str = dictUser["email_visibility"] as? String{
          email_visibility  = str
        }
        if let str = dictUser["dob_visibility"] as? String{
           dob_visibility = str
        }
        if let str = dictUser["created_at"] as? String{
           created_at = str
        }
        if let str = dictUser["updated_at"] as? String{
           updated_at = str
        }
        if let str = dictUser["token"] as? String{
            token = str
            setUserDefaults(token: str, login: true)
        }else{
            // error
        }
    
    }
        if let arr = dict["interests"]as? [[String:Any]]{
            for dict in arr{
                let obj = IntrestModel()
                obj.setData(dict: dict)
                arrIntrst.append(obj)
            }
        }
    
        if let dictLoc = dict["location"]as? [String:Any]{
           let obj = LocationModel()
                obj.setData(dict: dictLoc)
                arrLocation.append(obj)
            }

    }
}
class IntrestModel:NSObject{
    var intrstID:String? = nil
    var intrstcreated_at:String? = nil
    var intrstdescription:String? = nil
    var intrstname:String? = nil
    var intrstupdated_at:String? = nil
    
    func setData(dict:[String:Any]){
        if let str = dict["id"] as? Int{
            intrstID  = String(str)
        }
        if let str = dict["created_at"] as? String{
            intrstcreated_at = str
        }
        if let str = dict["description"] as? String{
            intrstdescription = str
        }
        if let str = dict["name"] as? String{
            intrstname = str
        }
        if let str = dict["updated_at"] as? String{
            intrstupdated_at = str
        }
    }

}

class LocationModel:NSObject{
    var city:String? = ""
    var lat:String? = ""
    var long:String? = ""
    var name:String? = ""
   
    
    func setData(dict:[String:Any]){
        if let str = dict["city"] as? String{
            city  = str
        }
        if let str = dict["lat"] as? Double{
            lat = String(str)
        }
        if let str = dict["long"] as? Double{
            long = String(str)
        }
        if let str = dict["name"] as? String{
            name = str
        }
      
    }
    
}
