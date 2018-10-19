
//
//  MainViewViewModel.swift
//  MyFan
//
//  Created by user on 04/09/18.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit

class MainViewViewModel: NSObject {

    var arrFeatures = [[String:Any]]()
     let header = ["Accept":"application/json"]
    
    
    func GetTrendigs(vc:UIViewController ){
       
        getData(url: KMainUrl+KtopTrending, parameter: nil, header: header, vc: vc, showHud: "yes", title: "", message: "") { (DictResponce) in
            
            
            if let DictData = (DictResponce?.value(forKey: "post")as? [String:Any]){
                self.arrFeatures.append(DictData)
                
            }else{
              
            }
            self.getRecent(vc: vc)
        }
    }
    
    
    func getRecent(vc:UIViewController){
        getData(url: KMainUrl+KtopRecent, parameter: nil, header: header, vc: vc, showHud: "yes", title: "", message: "") { (DictResponce) in
            
            
            if let DictData = (DictResponce?.value(forKey: "post")as? [String:Any]){
                self.arrFeatures.append(DictData)
                
            }else{
               
            }
           
            self.getSpotlight(vc: vc)
        }
        
    }
    
    func getSpotlight(vc:UIViewController){
        getData(url: KMainUrl+KtopSpotlight, parameter: nil, header: header, vc: vc, showHud: "yes", title: "", message: "") { (DictResponce) in
            
            
            if let DictData = (DictResponce?.value(forKey: "post")as? [String:Any]){
                
                self.arrFeatures.append(DictData)
                
            }else{
                
            }
            self.getPopular(vc: vc)
        }
        
    }
    
    
    func getPopular(vc:UIViewController){
        getData(url: KMainUrl+KtopPopular, parameter: nil, header: header, vc: vc, showHud: "yes", title: "", message: "") { (DictResponce) in
            
            
            if let DictData = (DictResponce?.value(forKey: "post")as? [String:Any]){
                self.arrFeatures.append(DictData)
               
                
            }else{
                
            }
            
             NotificationCenter.default.post(name: Notification.Name("tblReload"), object: nil)
        }
      //  print(self.arrFeatures)
    }
    
    
    func tbleCellCount()->Int{
        print(arrFeatures.count)
        return arrFeatures.count
    }
    
    func FeatureImg(Index:Int)->String{
        
        return ""
    }
    func featureUserImg(Index:Int)->String{
        if let dict = arrFeatures[Index]["user"]as? [String:Any]{
            if let str = dict["profile_image_url"]as? String{
              return str
            }else{
               return ""
            }
            
        }else{
           return ""
        }
      
    }
    func featureFullName(Index:Int)->String{
        if let dict = arrFeatures[Index]["user"]as? [String:Any]{
            if let str = dict["full_name"]as? String{
                return str
            }else{
                return ""
            }
            
        }else{
            return ""
        }
    }
    func featureUserName(Index:Int)->String{
        if let dict = arrFeatures[Index]["user"]as? [String:Any]{
            if let str = dict["user_name"]as? String{
                return str
            }else{
                return ""
            }
            
        }else{
            return ""
        }
    }
}
