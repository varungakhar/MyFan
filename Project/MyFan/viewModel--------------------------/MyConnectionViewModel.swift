//
//  MyConnectionViewModel.swift
//  MyFan
//
//  Created by user on 14/09/18.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit

class MyConnectionViewModel: NSObject {

    
//    let KMyRequests = "my-connections"
//    let KMyFans = "my-fans"
//    let KConnection_Suggestions = "connection-suggestions"
//    let KReceivedRequests = "received-requests"
    
    var arrMyNetwork = [[String:Any]]()
    var arrMyFans = [[String:Any]]()
    var arrConnection_Suggestions = [[String:Any]]()
    var arrReceivedRequests = [[String:Any]]()
    
  
    var GurlMyNetwork = ""
    var GurlMyFan = ""
    var GurlMyConnections = ""
    var GurlMyRequest = ""
    var TotalPages = 1
    
    func GetMyNetworkData(Refresh:Bool ,vc:UIViewController, completion:@escaping (Bool?,String)->()){
        
        
        let header = ["Accept":"application/json",
                      "Authorization":UserDefaults.standard.value(forKey: "Ktoken")as! String]
        var url = String()
        if Refresh == true{
           
            arrMyNetwork.removeAll()
         
        }
        guard GurlMyNetwork != "last" else{
            completion(false, "No more Data")
            return
        }
        
        if GurlMyNetwork != ""{
            let tmpUrl = KMainUrl.replacingOccurrences(of: "/api/v1/", with: "")
            
            url = tmpUrl+GurlMyNetwork
        }else{
            url = KMainUrl+KMyRequests+"?page=1"
        }
        print(url)
        
        getData(url: url, parameter: nil, header: header, vc: vc, showHud: "yes", title: "", message: "") { (DictResponce) in
            
            if let arrData = DictResponce?.value(forKey: "users")as? [[String:Any]]{
                
                for dict in arrData{
            
                        self.arrMyNetwork.append(dict)
                 
                }
            

                completion(true, "")
            }else{
                
            }
            
            if let dictMeta = DictResponce?.value(forKey: "meta")as? [String:Any]{
                if let dictPagination = dictMeta["pagination"]as? [String:Any]{
                    if let pages = dictPagination["total_pages"]as? Int{
                       
                        self.TotalPages = pages
                    }
                    if let dictLinks = dictPagination["links"]as? [String:Any]{
                        if let strUrl = dictLinks["next"]as? String{
                            self.GurlMyNetwork = strUrl
                        }else{
                            
                            self.GurlMyNetwork = "last"
                        }
                        
                        
                    }
                    
                }
            }
            
            
        }
    }
    


    func totalPageCount(tab:Int)->Int{
        return TotalPages
    }
   // arrMyConnections
    func myNetworkCount()->Int{
        return arrMyNetwork.count
    }
    func fullNameMyNetwork(Index:Int)->String{
        guard Index < arrMyNetwork.count else {
            return ""
        }
        
        if let str = arrMyNetwork[Index]["full_name"]as? String{
          return str
        }
        
        return ""
    }
    func userNameMyNetwork(Index:Int)->String{
        guard Index < arrMyNetwork.count else {
            return ""
        }
        
        if let str = arrMyNetwork[Index]["user_name"]as? String{
            return str
        }
        
        return ""
    }
    func profile_image_url_MyNetwork(Index:Int)->String{
        guard Index < arrMyNetwork.count else {
            return ""
        }
        
        if let str = arrMyNetwork[Index]["profile_image_url"]as? String{
            return str
        }
        
        return ""
    }
    
    func professional_text_lineMyNetwork(Index:Int)->String{
        guard Index < arrMyNetwork.count else {
            return ""
        }
        
        if let str = arrMyNetwork[Index]["professional_text_line"]as? String{
            return str
        }
        
        return ""
    }
    
    
    func mutualConnectionsMyNetwork(Index:Int)->String{
        guard Index < arrMyNetwork.count else {
            return "0 Mutual Connection"
        }
        
        if let str = arrMyNetwork[Index]["mutual_connections"]as? String{
            return str+" Mutual Connection"
        }else{
            if let str = arrMyNetwork[Index]["mutual_connections"]as? Int{
                return String(str)+" Mutual Connection"
            }
        }
        
        return "0 Mutual Connection"
    }
    
    func onlineMyNetwork(Index:Int)->String{
        guard Index < arrMyNetwork.count else {
            return "false"
        }
        
        if let str = arrMyNetwork[Index]["mutual_connections"]as? String{
            return str
        }else{
            if let str = arrMyNetwork[Index]["mutual_connections"]as? Bool{
                return String(str)
            }
        }
        
        return "false"
    }
    // MARK:- my fan data
    
    func GetMyFanData(Refresh:Bool ,vc:UIViewController, completion:@escaping (Bool?,String)->()){
        
        
        let header = ["Accept":"application/json",
                      "Authorization":UserDefaults.standard.value(forKey: "Ktoken")as! String]
        var url = String()
        if Refresh == true{
            
            arrMyFans.removeAll()
            
        }
        guard GurlMyFan != "last" else{
            completion(false, "No more Data")
            return
        }
        
        if GurlMyFan != ""{
            let tmpUrl = KMainUrl.replacingOccurrences(of: "/api/v1/", with: "")
            
            url = tmpUrl+GurlMyFan
        }else{
            url = KMainUrl+KMyFans+"?page=1"
        }
        print(url)
        
        getData(url: url, parameter: nil, header: header, vc: vc, showHud: "yes", title: "", message: "") { (DictResponce) in
            
            if let arrData = DictResponce?.value(forKey: "user/fans")as? [[String:Any]]{
                
                for dict in arrData{
                    
                    self.arrMyFans.append(dict)
                    
                }
                
                
                completion(true, "")
            }else{
                
            }
            
            if let dictMeta = DictResponce?.value(forKey: "meta")as? [String:Any]{
                if let dictPagination = dictMeta["pagination"]as? [String:Any]{
                    if let pages = dictPagination["total_pages"]as? Int{
                        
                        self.TotalPages = pages
                    }
                    if let dictLinks = dictPagination["links"]as? [String:Any]{
                        if let strUrl = dictLinks["next"]as? String{
                            self.GurlMyFan = strUrl
                        }else{
                            
                            self.GurlMyFan = "last"
                        }
                        
                        
                    }
                    
                }
            }
            
            
        }
    }
    
    
    
   // arrMyFans
    func MyFansCount()->Int{
        return arrMyFans.count
    }
    func fullNameMyFans(Index:Int)->String{
        guard Index < arrMyFans.count else {
            return ""
        }
     
        if let userDict = arrMyFans[Index]["user"] as? [String:Any]{
            if let str = userDict["full_name"]as? String{
                return str
            }
        }
        return ""
    }
    func userNameMyFans(Index:Int)->String{
        guard Index < arrMyFans.count else {
            return ""
        }
        if let userDict = arrMyFans[Index]["user"] as? [String:Any]{
            if let str = userDict["user_name"]as? String{
                return str
            }
        }
        return ""
    }
    
    func profile_image_url_MyFans(Index:Int)->String{
        guard Index < arrMyFans.count else {
            return ""
        }
        if let userDict = arrMyFans[Index]["user"] as? [String:Any]{
            if let str = userDict["profile_image_url"]as? String{
                return str
            }
        }
       
        return ""
    }
    
    func professional_text_lineMyFans(Index:Int)->String{
        guard Index < arrMyFans.count else {
            return ""
        }
        
        if let userDict = arrMyFans[Index]["user"] as? [String:Any]{
            if let str = userDict["professional_text_line"]as? String{
                return str
            }
        }
        return ""
    }
    
    
    func mutualConnectionsMyFans(Index:Int)->String{
        guard Index < arrMyFans.count else {
            return "0 Mutual Connection"
        }
       if let userDict = arrMyFans[Index]["user"] as? [String:Any]{
        if let str = userDict["mutual_connections"]as? String{
            return str+" Mutual Connection"
        }else{
            if let str = userDict["mutual_connections"]as? Int{
                return String(str)+" Mutual Connection"
            }
        }
    }
        return "0 Mutual Connection"
    }
    func onlineMyFans(Index:Int)->String{
        guard Index < arrMyFans.count else {
            return "false"
        }
         if let userDict = arrMyFans[Index]["user"] as? [String:Any]{
        if let str = userDict["online"]as? String{
            return str
        }else{
            if let str = userDict["online"]as? Bool{
                return String(str)
            }
        }
    }
        return "false"
    }
    
    
   
    

    // MARK:- Connection_ Suggestions data
    
    func GetConnection_SuggestionsData(Refresh:Bool ,vc:UIViewController, completion:@escaping (Bool?,String)->()){
        
        
        let header = ["Accept":"application/json",
                      "Authorization":UserDefaults.standard.value(forKey: "Ktoken")as! String]
        var url = String()
        if Refresh == true{
            
              arrConnection_Suggestions.removeAll()
            
        }
        guard GurlMyConnections != "last" else{
            completion(false, "No more Data")
            return
        }
        
        if GurlMyConnections != ""{
            let tmpUrl = KMainUrl.replacingOccurrences(of: "/api/v1/", with: "")
            
            url = tmpUrl+GurlMyConnections
        }else{
            url = KMainUrl+KConnection_Suggestions+"?page=1"
        }
        print(url)
      

        getData(url: url, parameter: nil, header: header, vc: vc, showHud: "yes", title: "", message: "") { (DictResponce) in
            
            if let arrData = DictResponce?.value(forKey: "users")as? [[String:Any]]{
                
                for dict in arrData{
                    
                    self.arrConnection_Suggestions.append(dict)
                    
                }
                
                
                completion(true, "")
            }else{
                
            }
            
            if let dictMeta = DictResponce?.value(forKey: "meta")as? [String:Any]{
                if let dictPagination = dictMeta["pagination"]as? [String:Any]{
                    if let pages = dictPagination["total_pages"]as? Int{
                        
                        self.TotalPages = pages
                    }
                    if let dictLinks = dictPagination["links"]as? [String:Any]{
                        if let strUrl = dictLinks["next"]as? String{
                            self.GurlMyConnections = strUrl
                        }else{
                            
                            self.GurlMyConnections = "last"
                        }
                        
                        
                    }
                    
                }
            }
            
            
        }
    }
    
    
    
    func Connection_SuggestionsCount()->Int{
        return arrConnection_Suggestions.count
    }
    func fullNameConnection_Suggestions(Index:Int)->String{
        guard Index < arrConnection_Suggestions.count else {
            return ""
        }
        
        if let userDict = arrConnection_Suggestions[Index]["user"] as? [String:Any]{
            if let str = userDict["full_name"]as? String{
                return str
            }
        }
        return ""
    }
    func userNameConnection_Suggestions(Index:Int)->String{
        guard Index < arrConnection_Suggestions.count else {
            return ""
        }
        if let userDict = arrConnection_Suggestions[Index]["user"] as? [String:Any]{
            if let str = userDict["user_name"]as? String{
                return str
            }
        }
        return ""
    }
    
    func profile_image_url_Connection_Suggestions(Index:Int)->String{
        guard Index < arrConnection_Suggestions.count else {
            return ""
        }
        
        if let str = arrConnection_Suggestions[Index]["profile_image_url"]as? String{
            return str
        }
        
        return ""
    }
    
    func professional_text_lineConnection_Suggestions(Index:Int)->String{
        guard Index < arrConnection_Suggestions.count else {
            return ""
        }
        
        if let str = arrConnection_Suggestions[Index]["professional_text_line"]as? String{
            return str
        }
        
        return ""
    }
    
    
    func mutualConnectionsConnection_Suggestions(Index:Int)->String{
        guard Index < arrConnection_Suggestions.count else {
            return "0 Mutual Connection"
        }
        
        if let str = arrConnection_Suggestions[Index]["mutual_connections"]as? String{
            return str+" Mutual Connection"
        }else{
            if let str = arrConnection_Suggestions[Index]["mutual_connections"]as? Int{
                return String(str)+" Mutual Connection"
            }
        }
        
        return "0 Mutual Connection"
    }
    func onlineConnection_Suggestions(Index:Int)->String{
        guard Index < arrConnection_Suggestions.count else {
            return "false"
        }
        
        if let str = arrConnection_Suggestions[Index]["mutual_connections"]as? String{
            return str
        }else{
            if let str = arrConnection_Suggestions[Index]["mutual_connections"]as? Bool{
                return String(str)
            }
        }
        
        return "false"
    }
    
    
    // MARK:- Received Requests data
    
    func GetReceivedRequestsData(Refresh:Bool ,vc:UIViewController, completion:@escaping (Bool?,String)->()){
        
        
        let header = ["Accept":"application/json",
                      "Authorization":UserDefaults.standard.value(forKey: "Ktoken")as! String]
        var url = String()
        if Refresh == true{
            
            arrReceivedRequests.removeAll()
            
        }
        guard GurlMyRequest != "last" else{
            completion(false, "No more Data")
            return
        }
        
        if GurlMyRequest != ""{
            let tmpUrl = KMainUrl.replacingOccurrences(of: "/api/v1/", with: "")
            
            url = tmpUrl+GurlMyRequest
        }else{
            url = KMainUrl+KReceivedRequests+"?page=1"
        }
        print(url)
        
        
        getData(url: url, parameter: nil, header: header, vc: vc, showHud: "yes", title: "", message: "") { (DictResponce) in
            
            if let arrData = DictResponce?.value(forKey: "users")as? [[String:Any]]{
                
                for dict in arrData{
                    
                    self.arrReceivedRequests.append(dict)
                    
                }
                
                
                completion(true, "")
            }else{
                
            }
            
            if let dictMeta = DictResponce?.value(forKey: "meta")as? [String:Any]{
                if let dictPagination = dictMeta["pagination"]as? [String:Any]{
                    if let pages = dictPagination["total_pages"]as? Int{
                        
                        self.TotalPages = pages
                    }
                    if let dictLinks = dictPagination["links"]as? [String:Any]{
                        if let strUrl = dictLinks["next"]as? String{
                            self.GurlMyRequest = strUrl
                        }else{
                            
                            self.GurlMyRequest = "last"
                        }
                        
                        
                    }
                    
                }
            }
            
            
        }
    }
    
    
    
    func ReceivedRequestsCount()->Int{
        return arrReceivedRequests.count
    }
    func fullNameReceivedRequests(Index:Int)->String{
        guard Index < arrReceivedRequests.count else {
            return ""
        }
        
        if let userDict = arrReceivedRequests[Index]["user"] as? [String:Any]{
            if let str = userDict["full_name"]as? String{
                return str
            }
        }
        return ""
    }
    func userNameReceivedRequests(Index:Int)->String{
        guard Index < arrReceivedRequests.count else {
            return ""
        }
        if let userDict = arrReceivedRequests[Index]["user"] as? [String:Any]{
            if let str = userDict["user_name"]as? String{
                return str
            }
        }
        return ""
    }
    
    func profile_image_url_ReceivedRequests(Index:Int)->String{
        guard Index < arrReceivedRequests.count else {
            return ""
        }
        
        if let str = arrReceivedRequests[Index]["profile_image_url"]as? String{
            return str
        }
        
        return ""
    }
    
    func professional_text_lineReceivedRequests(Index:Int)->String{
        guard Index < arrReceivedRequests.count else {
            return ""
        }
        
        if let str = arrReceivedRequests[Index]["professional_text_line"]as? String{
            return str
        }
        
        return ""
    }
    
    
    func mutualConnectionsReceivedRequests(Index:Int)->String{
        guard Index < arrReceivedRequests.count else {
            return "0 Mutual Connection"
        }
        
        if let str = arrReceivedRequests[Index]["mutual_connections"]as? String{
            return str+" Mutual Connection"
        }else{
            if let str = arrReceivedRequests[Index]["mutual_connections"]as? Int{
                return String(str)+" Mutual Connection"
            }
        }
        
        return "0 Mutual Connection"
    }
    func onlineReceivedRequests(Index:Int)->String{
        guard Index < arrReceivedRequests.count else {
            return "false"
        }
        
        if let str = arrReceivedRequests[Index]["mutual_connections"]as? String{
            return str
        }else{
            if let str = arrReceivedRequests[Index]["mutual_connections"]as? Bool{
                return String(str)
            }
        }
        
        return "false"
    }
    
    

    
    
}
