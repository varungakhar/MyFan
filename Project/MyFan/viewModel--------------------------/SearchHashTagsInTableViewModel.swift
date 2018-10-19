//
//  SearchHashTagsInTableViewModel.swift
//  MyFan
//
//  Created by user on 12/09/18.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit

class SearchHashTagsInTableViewModel: NSObject {

    var arrTags = [[String:Any]]()
      var arrPosts = [[String:Any]]()
      var arrProfiles = [[String:Any]]()
    var TagsPage :Int? = nil
    var PostsPage :Int? = nil
    var ProfilesPage :Int? = nil
    var GtagUrl = ""
    var GPostUrl = ""
    var GProfileUrl = ""
    func SearchTags(text:String,showHud:String ,vc:UIViewController,completion:@escaping (Bool?,String)->()){
        let header = ["Accept":"application/json",
                      "Authorization":UserDefaults.standard.value(forKey: "Ktoken")as! String]
      
        var url = String()
        guard GtagUrl != "last" else{
            completion(false, "No more Data")
            return
        }
        
        if GtagUrl != ""{
        let tmpUrl = KMainUrl.replacingOccurrences(of: "/api/v1/", with: "")
            
        url = tmpUrl+GtagUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        }
        else{
            url = KMainUrl+KSearchTags+"?tag_name="+text.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            
        }
        print(url)
      
        getData(url: url, parameter: nil, header: header, vc: vc, showHud: showHud, title: "", message: "") { (DictResponce) in
            
          
                        
            if let arr = DictResponce?.value(forKey: "topics")as? [[String:Any]]{
              
                for dict in arr{
                    self.arrTags.append(dict)
                }
                completion(true, "")
            
            }else{
                completion(false, "")
                
               
            }
                        
                        
            if let dictMeta = DictResponce?.value(forKey: "meta")as? [String:Any]{
                if let dictPagination = dictMeta["pagination"]as? [String:Any]{
                    if let pages = dictPagination["total_pages"]as? Int{
                        self.TagsPage = pages
                    }
                    
                    if let dictLinks = dictPagination["links"]as? [String:Any]{
                        if let strUrl = dictLinks["next"]as? String{
                            self.GtagUrl = strUrl
                        }else{

                            self.GtagUrl = "last"
                        }
                        
                    }
                }
                
            }
        }
        
    }
    func searchPosts(text:String,showHud:String ,vc:UIViewController ,completion:@escaping (Bool?,String)->()){
        
            let header = ["Accept":"application/json",
                          "Authorization":UserDefaults.standard.value(forKey: "Ktoken")as! String]
        
        var url = String()
        
        guard GPostUrl != "last" else{
            completion(false, "No more Data")
            return
        }
        
        if GPostUrl != ""{
            let tmpUrl = KMainUrl.replacingOccurrences(of: "/api/v1/", with: "")
            
            url = tmpUrl+GPostUrl
        }else{
            url = KMainUrl+KSearchPost+"?tag_name="+text.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            
        }
     
        print(url)
             getData(url: url, parameter: nil, header: header, vc: vc, showHud: showHud, title: "", message: "") { (DictResponce) in
        
                if let arr = DictResponce?.value(forKey: "posts")as? [[String:Any]]{
                    
                    for dict in arr{
                        self.arrPosts.append(dict)
                    }
                    completion(true, "")

                  
                }else{
             
                   
                    completion(false, "")
                    
                }
                            
                if let dictMeta = DictResponce?.value(forKey: "meta")as? [String:Any]{
                    if let dictPagination = dictMeta["pagination"]as? [String:Any]{
                        if let pages = dictPagination["total_pages"]as? Int{
                            self.PostsPage = pages
                        }
                        
                        if let dictLinks = dictPagination["links"]as? [String:Any]{
                            if let strUrl = dictLinks["next"]as? String{
                                self.GPostUrl = strUrl
                            }else{
                                
                                self.GPostUrl = "last"
                            }
                            
                            
                  }
                    }
                    
                }
                
        }
        
    }
    
    func searchProfile(text:String ,showHud:String ,vc:UIViewController,completion:@escaping (Bool?,String)->() ){
            let header = ["Accept":"application/json",
                          "Authorization":UserDefaults.standard.value(forKey: "Ktoken")as! String]
        var url = String()
        guard GProfileUrl != "last" else{
            completion(false, "No more Data")
            return
        }

        if GProfileUrl != ""{
            let tmpUrl = KMainUrl.replacingOccurrences(of: "/api/v1/", with: "")
            
            url = tmpUrl+GProfileUrl
        }else{
             url = KMainUrl+KSearchProfile+"?tag_name="+text.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            
        }
        
        print(url)
            getData(url: url, parameter: nil, header: header, vc: vc, showHud: showHud, title: "", message: "") { (DictResponce) in
           
                if let arr = DictResponce?.value(forKey: "users")as? [[String:Any]]{
                   
                    for dict in arr{
                        self.arrProfiles.append(dict)
                    }
                    completion(true, "")

                }else{
                 
                    completion(false, "")
                }
                            
                if let dictMeta = DictResponce?.value(forKey: "meta")as? [String:Any]{
                    if let dictPagination = dictMeta["pagination"]as? [String:Any]{
                        if let pages = dictPagination["total_pages"]as? Int{
                            self.ProfilesPage = pages
                        }
                        
                        if let dictLinks = dictPagination["links"]as? [String:Any]{
                            if let strUrl = dictLinks["next"]as? String{
                                self.GProfileUrl = strUrl
                            }else{
                                
                                self.GProfileUrl = "last"
                            }
                            
                        }
                    }
                    
                }
                
        }
      
    }
    func clearArrys(){
          self.arrTags.removeAll()
        self.arrPosts.removeAll()
        self.arrProfiles.removeAll()
    }
    
    func totalPageTag()->Int{
        if TagsPage == nil{
            return 1
        }
       return TagsPage!
  
    }
    func totalPagePosts()->Int{
        if PostsPage == nil{
            return 1
        }
      return  PostsPage!
     
    }
    func totalPageProfiles()->Int{
        if ProfilesPage == nil{
            return 1
        }
       return ProfilesPage!
    }
    func tagsCount1()->Int{
        if arrTags.count >= 3{
            return 3
        }else{
        return arrTags.count
        }
    }
    func PostsCount1()->Int{
    if arrPosts.count >= 3{
            return 3
        }else{
            return arrPosts.count
        }
    }
    func profilesCount1()->Int{
        if arrProfiles.count >= 3{
            return 3
        }else{
            return arrProfiles.count
        }
    }
    
    func tagsCount()->Int{
        return arrTags.count
    }
    func PostsCount()->Int{
        return arrPosts.count
    }
    func profilesCount()->Int{
        return arrProfiles.count
    }
    // tags
    
    func tagsName(Index:Int)->String{
        guard arrTags.count > Index else {
            return ""
        }
        if let str = arrTags[Index]["name"]as? String{
            return str
        }
        
        return ""
    }
    
    
    // posts
    
    func postBody(Index:Int)->String{
        guard arrPosts.count > Index else {
            return ""
        }
        if let str = arrPosts[Index]["body"]as? String{
            return str
        }
        
        return ""
    }
    
    
    func HashTagTopicsOnlyForShow(Index:Int)->String{
        guard arrPosts.count > Index else{
            return ""
        }
        var str :String? = ""
        if let arrTopics = arrPosts[Index]["topics"] as? [[String:Any]]{
            
            for indx in 0..<arrTopics.count{
                if let user_name = arrTopics[indx]["name"]as? String{
                    if indx == 0{
                        if !user_name.contains("#"){
                            str = "#"+user_name
                        }else{
                            str = user_name
                        }
                    }else{
                        if !user_name.contains("#"){
                            str!.append(", #" + user_name)
                        }else{
                            str!.append(", " + user_name)
                        }
                    }
                }else{
                    
                }
            }
            
        }else{
            
        }
        print(str!)
        return str!
    }
    func HashTagTopics(Index:Int)->String{
        guard arrPosts.count > Index else{
            return ""
        }
        var str :String? = ""
        if let arrTopics = arrPosts[Index]["topics"] as? [[String:Any]]{
            
            for indx in 0..<arrTopics.count{
                if let user_name = arrTopics[indx]["name"]as? String{
                    if indx == 0{
                        if !user_name.contains("#"){
                            str = "#"+user_name.replacingOccurrences(of: " ", with: "_")
                        }else{
                            str = user_name.replacingOccurrences(of: " ", with: "_")
                        }
                        
                        if user_name.contains("&"){
                            str = str?.replacingOccurrences(of: "&", with: "µ")
                        }else{
                            
                        }
                        
                    }else{
                        if !user_name.contains("#"){
                            str!.append(", #" + user_name.replacingOccurrences(of: " ", with: "_"))
                        }else{
                            str!.append(user_name.replacingOccurrences(of: " ", with: "_"))
                        }
                        
                        if user_name.contains("&"){
                            str = str?.replacingOccurrences(of: "&", with: "µ")
                        }else{
                            
                        }
                    }
                }else{
                    
                }
            }
            
        }else{
            
        }
        print(str!)
        return str!
    }
    
    func typeOfPost(Index:Int)->[[String:Any]]?{
        var arrPostMultimediaContent = [[String:Any]]()
        guard arrPosts.count > Index else{
            return arrPostMultimediaContent
        }
        
        if let DictAlbm = arrPosts[Index]["album"]as? [String:Any]{
            print(DictAlbm)
            if let ArrImage = DictAlbm["images"]as? [[String:Any]]{
                if ArrImage.count != 0{
                    arrPostMultimediaContent.append(ArrImage[0])
                }
                
            }
            
            if let ArrVideo = DictAlbm["videos"]as? [[String:Any]]{
                if ArrVideo.count != 0{
                    arrPostMultimediaContent.append(ArrVideo[0])
                }
            }
            
            if let ArrAudio = DictAlbm["audios"]as? [[String:Any]]{
                if ArrAudio.count != 0{
                    arrPostMultimediaContent.append(ArrAudio[0])
                }
            }
            
        }else{

            if let dictImage = arrPosts[Index]["image"]as? [String:Any]{
                print(dictImage)
                arrPostMultimediaContent.append(dictImage)
                
            }
            
            if let dictVideo = arrPosts[Index]["video"]as? [String:Any]{
                print(dictVideo)
                arrPostMultimediaContent.append(dictVideo)
                
            }
            
            if let dictAudio = arrPosts[Index]["audio"]as? [String:Any]{
                print(dictAudio)
                arrPostMultimediaContent.append(dictAudio)
            }
        }
        print(arrPostMultimediaContent)
        return arrPostMultimediaContent
    }
    
  
    
    // profile
    
    func fullName(Index:Int)->String{
        guard arrProfiles.count > Index else {
            return ""
        }
        if let str = arrProfiles[Index]["full_name"]as? String{
            return str
        }
        
        return ""
    }
   
    func userName(Index:Int)->String{
        guard arrProfiles.count > Index else {
            return ""
        }
        if let str = arrProfiles[Index]["user_name"]as? String{
            return "@"+str
        }
        return ""
    }
    func ProfilePic(Index:Int)->String{
        guard arrProfiles.count > Index else {
            return ""
        }
        if let str = arrProfiles[Index]["profile_image_url"]as? String{
            return str
        }
        return ""
    }
    
    func profesionalText(Index:Int)->String{
        guard arrProfiles.count > Index else {
            return ""
        }
        if let str = arrProfiles[Index]["professional_text_line"]as? String{
            return str
        }
        return ""
    }
    func mutualContects(Index:Int)->String{
        guard arrProfiles.count > Index else {
            return ""
        }
        if let str = arrProfiles[Index]["mutual_connections"]as? Int{
            return String(str) + " Mutual Connections"
        }
        return ""
    }
    
    func setLableFirst(lbl1:String,lbl2:String)->NSMutableAttributedString{
        let attrs1 = [NSAttributedStringKey.font : UIFont(name: "HelveticaNeue-Bold", size: 14) ?? UIFont.systemFont(ofSize: 14, weight: .regular)  , NSAttributedStringKey.foregroundColor : (UIColor.black)]
        let attrs2 = [NSAttributedStringKey.font :UIFont(name: "HelveticaNeue-Regular", size: 14) ?? UIFont.systemFont(ofSize: 14, weight: .regular), NSAttributedStringKey.foregroundColor : UIColor.darkGray]
        let attributedString1 = NSMutableAttributedString(string:lbl1, attributes:attrs1)
        let attributedString2 = NSMutableAttributedString(string:" "+lbl2, attributes:attrs2)
        attributedString1.append(attributedString2)
        return attributedString1
    }
    
}
