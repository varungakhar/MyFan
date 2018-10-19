//
//  SignUp2ViewModel.swift
//  MyFan
//
//  Created by user on 03/09/18.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit

class SignUp2ViewModel: NSObject {

    var arrCatgory = [[String:Any]]()
    var arrSubCatgory : [[String:Any]]? = nil
    var arrInterest : [[String:Any]]? = nil
    func GetCatgories(vc:UIViewController ,completion:@escaping (Bool?)->()){
        
            let header = ["Accept":"application/json"]
        
   
            getData(url: KMainUrl+KProfessionalCategory, parameter: nil, header: header, vc: vc, showHud: "yes", title: "", message: "") { (DictResponce) in
            
                
                if let arrData = (DictResponce?.value(forKey: "professional_categories")as? [[String:Any]]){
                    if arrData.count != 0{
                        
                        self.arrCatgory = arrData
                        
                        
                        completion(true)
                    }else{
                        completion(false)
                    }
                    
                }else{
                    completion(false)
                }
                
            }
    }
    
    func clcCount()-> Int{
        return arrCatgory.count
    }
    
    func catgryLable(Index:Int)-> String{
        
        print(arrCatgory.count)
        print(Index)
        guard let str = arrCatgory[Index]["name"]as? String else {
            return ""
        }
        return str
    }
    
    func catgryImg(Index:Int)->String{
        guard let str = arrCatgory[Index]["banner_image_url"]as? String else {
            return ""
        }
       // print(str)
        return str
    }
    func catgryId(Index:Int)->String{
        guard let str = arrCatgory[Index]["id"]as? String else {
            return ""
        }
        return str
    }
    
  
    func SelectedCatgory(Index:Int){
        guard let arr = arrCatgory[Index]["enable_professional_sub_categories"]as? [[String:Any]] else {
            return
        }
        arrSubCatgory = arr
       
    }
    func SelectedCatgryId(Index:Int)->String{
        guard let str = arrCatgory[Index]["id"]as? String else {
            return ""
        }
        return str
    }
    
    // SubProfession
    
    func SubclcCount()-> Int{
        guard arrSubCatgory != nil else {
            return 0
        }
        return arrSubCatgory!.count
    }

    func SubcatgryLable(Index:Int)-> String{
        
        guard let str = arrSubCatgory![Index]["name"]as? String else {
            return ""
        }
        return str
    }

    func SubcatgryImg(Index:Int)->String{
        guard let str = arrSubCatgory![Index]["image_url"]as? String else {
            return ""
        }
        return str
    }
    func SubcatgryId(Index:Int)->String{
        guard let str = arrSubCatgory![Index]["id"]as? String else {
            return ""
        }
        return str
    }

    func SubclcDidSelect(Index:Int){

    }
    
    
    // Category api
    
    
    func GetIntrest(vc:UIViewController ,completion:@escaping (Bool?)->()){
        let header = ["Accept":"application/json"]
        getData(url: KMainUrl+KInterest, parameter: nil, header: header, vc: vc, showHud: "yes", title: "", message: "") { (DictResponce) in
            
            
            if let arrData = (DictResponce?.value(forKey: "categories")as? [[String:Any]]){
                if arrData.count != 0{
                    
                    self.arrInterest = arrData
                    
                    
                    completion(true)
                }else{
                    completion(false)
                }
                
            }else{
                completion(false)
            }
            
        }
    }
    
    func IntclcCount()-> Int{
        guard arrInterest != nil else {
            return 0
        }
        return arrInterest!.count
    }
    
    func IntcatgryLable(Index:Int)-> String{
        
        guard let str = arrInterest![Index]["name"]as? String else {
            return ""
        }
        return str
    }
    
    func IntcatgryImg(Index:Int)->String{
        guard let str = arrInterest![Index]["image_url"]as? String else {
            return ""
        }
        return str
    }
    func IntcatgryId(Index:Int)->String{

        guard let str = arrInterest![Index]["id"]as? Int else {
            return ""
        }
       
        return  String(str)
    }
    
    
    //MultiPart
    

    func postSignUpStepData(param:[String:Any],dictImg:[String:Data]?,vc:UIViewController ,completion:@escaping (Bool?)->()){
        let header = ["Accept":"application/json",
                      "Content-Type": "multipart/form-data",
                      "Authorization":UserDefaults.standard.value(forKey: "Ktoken")as! String]
        print(header)
        postDataWithImage(url: KMainUrl+KSignStepUpdate, parameter: param as NSDictionary, header: header, dictUploadData: dictImg, vc: vc, showHud: "yes", title: "", message: "") { (dictResponce) in
            
          //  print(dictResponce)
            if let sucess = dictResponce?.value(forKey: "success")as? Bool{
                if sucess == true{
                    completion(true)
                }else{
                    
                }
            }
            
        }
        
        
    }
    
}
