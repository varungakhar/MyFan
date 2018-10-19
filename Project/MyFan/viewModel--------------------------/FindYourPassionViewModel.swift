//
//  FindYourPassionViewModel.swift
//  MyFan
//
//  Created by user on 08/10/18.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit

class FindYourPassionViewModel: NSObject {
//    let KBasePassion = "interests/"
//
//    let KPassionFollowing = "following"
//    let KPassionFollow = "follow-list"
//    let KPassionUnclassified = "unclassified"
//    let KPassionViewTopics = "/view-topics"
//    let KPassionSearchTopics = "search-topics"
    
    var arrFollowingList = [[String:Any]]()
    var arrFollowList = [[String:Any]]()
    var arrTagList = [[String:Any]]()
    var arrTagEmpty = [[String:Any]]()
    
     // MARK:- FOLLOWING List
    func GetFollowingData(Refresh:Bool ,vc:UIViewController, completion:@escaping (Bool?,String)->()){
        
        
        let header = ["Accept":"application/json",
                      "Authorization":UserDefaults.standard.value(forKey: "Ktoken")as! String]
   
        print(KMainUrl+KBasePassion+KPassionFollowing)
        getData(url: KMainUrl+KBasePassion+KPassionFollowing, parameter: nil, header: header, vc: vc, showHud: "yes", title: "", message: "") { (DictResponce) in
            
            if let arrData = DictResponce?.value(forKey: "categories")as? [[String:Any]]{
                
                for dict in arrData{
                    
                    self.arrFollowingList.append(dict)
                    
                }
                
                completion(true, "")
            }else{
               completion(false, "Error!")
            }
            
      
            }
            
            
        }
//    "categories": [
//    {
//    "id": 5,
//    "name": "Music ",
//    "enable": true,
//    "created_at": "2017-08-17T14:09:59.036Z",
//    "updated_at": "2018-07-25T11:01:18.179Z",
//    "image_url": "http://192.168.1.150:3000/assets/img_not_available-91418a30acd0e23d3df89e671bf6ee0036e802e0a51e64692b7ef8a76d551eab.png",
//    "slug": "music-5",
//    "total_followers": 32,
//    "following_by_current_user": true
//    },
    
    func is_FollowingData_Empty()->Bool{
        if arrFollowingList.count == 0{
           return true
        }else{
            return false
        }
    }

    func followingListCount()->Int{
        return arrFollowingList.count
    }
    
    func followingID(Index:Int)->String{
        guard Index < arrFollowingList.count else {
            return ""
        }
        
        if let str = arrFollowingList[Index]["id"]as? String{
            return str
        }
        if let str = arrFollowingList[Index]["id"]as? Int{
            return String(str)
        }
        return ""
    }
    
    func followingName(Index:Int)->String{
        guard Index < arrFollowingList.count else {
            return ""
        }
        
        if let str = arrFollowingList[Index]["name"]as? String{
            return str
        }
       
        return ""
    }
    func followingImageUrl(Index:Int)->String{
        guard Index < arrFollowingList.count else {
            return ""
        }
        
        if let str = arrFollowingList[Index]["image_url"]as? String{
            return str
        }
        
        return ""
    }
    func followingSlug(Index:Int)->String{
        guard Index < arrFollowingList.count else {
            return ""
        }
        
        if let str = arrFollowingList[Index]["slug"]as? String{
            return str
        }
        
        return ""
    }
    func followingTotalFollowers(Index:Int)->String{
        guard Index < arrFollowingList.count else {
            return "0 Fans Following This"
        }
        
        if let str = arrFollowingList[Index]["total_followers"]as? String{
            return str+" Fans Following This"
        }
        if let str = arrFollowingList[Index]["total_followers"]as? Int{
            return String(str)+" Fans Following This"
        }
        return "0 Fans Following This"
    }
    func followingEnable(Index:Int)->String{
        guard Index < arrFollowingList.count else {
            return ""
        }
        
        if let str = arrFollowingList[Index]["enable"]as? String{
            return str
        }
        if let str = arrFollowingList[Index]["enable"]as? Bool{
            return String(str)
        }
        return ""
    }
    
    func following_by_current_user(Index:Int)->String{
        guard Index < arrFollowingList.count else {
            return ""
        }
        
        if let str = arrFollowingList[Index]["following_by_current_user"]as? String{
            return str
        }
        if let str = arrFollowingList[Index]["following_by_current_user"]as? Bool{
            return String(str)
        }
        return ""
    }
    
    
    
    
    // MARK:- FOLLOW List
    

    
    func GetFollowListData(Refresh:Bool ,vc:UIViewController, completion:@escaping (Bool?,String)->()){
        
        
        let header = ["Accept":"application/json",
                      "Authorization":UserDefaults.standard.value(forKey: "Ktoken")as! String]
        
        
        getData(url: KMainUrl+KBasePassion+KPassionFollow, parameter: nil, header: header, vc: vc, showHud: "yes", title: "", message: "") { (DictResponce) in
            
            if let arrData = DictResponce?.value(forKey: "categories")as? [[String:Any]]{
                
                for dict in arrData{
                    
                    self.arrFollowList.append(dict)
                    
                }
               
                completion(true, "")
            }else{
                completion(false, "Error!")
            }
            
            
        }
        
        
    }
    //    "categories": [
    //    {
    //    "id": 3,
    //    "name": "Photography",
    //    "enable": true,
    //    "created_at": "2017-08-07T14:29:14.617Z",
    //    "updated_at": "2018-07-25T11:01:18.185Z",
    //    "image_url": "http://192.168.1.150:3000/assets/img_not_available-91418a30acd0e23d3df89e671bf6ee0036e802e0a51e64692b7ef8a76d551eab.png",
    //    "slug": "photography-3",
    //    "total_followers": 15,
    //    "following_by_current_user": false
    //    },
    
    func is_FollowListData_Empty()->Bool{
        if arrFollowList.count == 0{
            return true
        }else{
            return false
        }
    }

    
    func followListCount()->Int{
        return arrFollowList.count
    }
    
    func followID(Index:Int)->String{
        guard Index < arrFollowList.count else {
            return ""
        }
        
        if let str = arrFollowList[Index]["id"]as? String{
            return str
        }
        if let str = arrFollowList[Index]["id"]as? Int{
            return String(str)
        }
        return ""
    }
    
    func followName(Index:Int)->String{
        guard Index < arrFollowList.count else {
            return ""
        }
        
        if let str = arrFollowList[Index]["name"]as? String{
            return str
        }
        
        return ""
    }
    func followImageUrl(Index:Int)->String{
        guard Index < arrFollowList.count else {
            return ""
        }
        
        if let str = arrFollowList[Index]["image_url"]as? String{
            return str
        }
        
        return ""
    }
    func followSlug(Index:Int)->String{
        guard Index < arrFollowList.count else {
            return ""
        }
        
        if let str = arrFollowList[Index]["slug"]as? String{
            return str
        }
        
        return ""
    }
    func followTotalFollowers(Index:Int)->String{
        guard Index < arrFollowList.count else {
            return "0 Fans Following This"
        }
        
        if let str = arrFollowList[Index]["total_followers"]as? String{
            return str+" Fans Following This"
        }
        if let str = arrFollowList[Index]["total_followers"]as? Int{
            return String(str)+" Fans Following This"
        }
        return "0 Fans Following This"
    }
    func followEnable(Index:Int)->String{
        guard Index < arrFollowList.count else {
            return ""
        }
        
        if let str = arrFollowList[Index]["enable"]as? String{
            return str
        }
        if let str = arrFollowList[Index]["enable"]as? Bool{
            return String(str)
        }
        return ""
    }
    
    func follow_by_current_user(Index:Int)->String{
        guard Index < arrFollowList.count else {
            return ""
        }
        
        if let str = arrFollowList[Index]["following_by_current_user"]as? String{
            return str
        }
        if let str = arrFollowList[Index]["following_by_current_user"]as? Bool{
            return String(str)
        }
        return ""
    }
    
    
    
    
    
    

    
    // MARK:- Tag List
    func GetTopicsData(Index:Int ,vc:UIViewController, completion:@escaping (Bool?,String)->()){
        
        
        let header = ["Accept":"application/json",
                      "Authorization":UserDefaults.standard.value(forKey: "Ktoken")as! String]
        
       let strSlug = followingSlug(Index: Index)
        print(strSlug)
        getData(url: KMainUrl+KBasePassion+strSlug+KPassionViewTopics, parameter: nil, header: header, vc: vc, showHud: "yes", title: "", message: "") { (DictResponce) in
            
            if let arrData = DictResponce?.value(forKey: "topics")as? [[String:Any]]{
                self.arrTagList.removeAll()
                for dict in arrData{
                    
                    self.arrTagList.append(dict)
                    
                }
                 print(Index)
               
                self.arrFollowingList[Index]["tagData"] = self.arrTagList
            
                completion(true, "")
            }else{
                completion(false, "Error!")
            }
            
            
        }
        
        
    }
    

    func topicsCount(Section:Int)->Int{
        print(Section)
        if let arr = arrFollowingList[Section]["tagData"] as? [[String:Any]]{
           return arr.count
        }
        return 0
    }
    
    func topicsID(Section:Int,Index:Int)->String{
     
        if let arr = arrFollowingList[Section]["tagData"] as? [[String:Any]]{
            guard Index < arr.count else {
                return ""
            }
            if let str = arr[Index]["id"]as? String{
                return str
            }
            if let str = arr[Index]["id"]as? Int{
                return String(str)
            }
        }
      
        return ""
    }
    func topicsCategoryID(Section:Int,Index:Int)->String{
   
        if let arr = arrFollowingList[Section]["tagData"] as? [[String:Any]]{
            guard Index < arr.count else {
                return ""
            }
            if let str = arr[Index]["category_id"]as? String{
                return str
            }
            if let str = arr[Index]["category_id"]as? Int{
                return String(str)
            }
        }
        
        return ""
    }
    
    func topicsName(Section:Int,Index:Int)->String{
   
        if let arr = arrFollowingList[Section]["tagData"] as? [[String:Any]]{
            guard Index < arr.count else {
                return ""
            }
            
            if let str = arr[Index]["name"]as? String{
                print(str)
                return str
            }
         }
        return ""
    }
    func topicsSlug(Section:Int,Index:Int)->String{
    
        if let arr = arrFollowingList[Section]["tagData"] as? [[String:Any]]{
            guard Index < arr.count else {
                return ""
            }
            
            if let str = arr[Index]["slug"]as? String{
                print(str)
                return str
            }
        }
        return ""
    }
    func topicsTotalFollowers(Section:Int,Index:Int)->String{
  
        
        if let arr = arrFollowingList[Section]["tagData"] as? [[String:Any]]{
            guard Index < arr.count else {
                return ""
            }
            if let str = arr[Index]["total_followers"]as? String{
                return str+" Fans Following This"
            }
            if let str = arr[Index]["total_followers"]as? Int{
                return String(str)+" Fans Following This"
            }
        }
    
        return "0 Fans Following This"
    }
    func topicsEnable(Section:Int,Index:Int)->String{
  
        if let arr = arrFollowingList[Section]["tagData"] as? [[String:Any]]{
            guard Index < arr.count else {
                return ""
            }
            if let str = arr[Index]["enable"]as? String{
                return str
            }
            if let str = arr[Index]["enable"]as? Bool{
                return String(str)
            }
        }
        
        
        
        return ""
    }
    
    func topics_Follow_by_current_user(Section:Int,Index:Int)->String{
    
        if let arr = arrFollowingList[Section]["tagData"] as? [[String:Any]]{
            guard Index < arr.count else {
                return ""
            }
            
            if let str = arr[Index]["following_by_current_user"]as? String{
                print(str)
                return str
            }
        }
        return ""
    }
    
    
//    "topics": [
//    {
//    "id": 68,
//    "name": "NFL",
//    "enable": true,
//    "category_id": 9,
//    "created_at": "2017-08-20T22:22:16.647Z",
//    "updated_at": "2018-07-25T11:06:45.084Z",
//    "slug": "nfl-68",
//    "total_followers": 26,
//    "following_by_current_user": true
//    },
    
}
