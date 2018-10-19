//
//  TagHashViewModel.swift
//  MyFan
//
//  Created by user on 08/09/18.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit

class TagHashViewModel: NSObject {

    var arrTrending = [[String:Any]]()
    var arrRecent = [[String:Any]]()
    var arrSpotlight = [[String:Any]]()
    var arrPopular = [[String:Any]]()
    
    var selectedArr : [[String:Any]]? = nil
    var GstrUrl : String? = nil
    var arrGurls = ["","","","",""]
    
    func GetTagHashData(strTagHash:String ,tab:Int,vc:UIViewController, completion:@escaping (Bool?)->()){
        
        let arrApis = ["",KtagPosts+"?tag_name=",KfeedsRecent+"?page=1",KfeedsSpotlight+"?page=1",KfeedsPopular+"?page=1"]
        
        let header = ["Accept":"application/json",
                      "Authorization":UserDefaults.standard.value(forKey: "Ktoken")as! String]
        var url = String()
        
        if arrGurls[tab] != ""{
            let tmpUrl = KMainUrl.replacingOccurrences(of: "/api/v1/", with: "")
            
            url = tmpUrl+arrGurls[tab]+"&tag_name="+strTagHash
        }else{
            url = KMainUrl+arrApis[tab]+strTagHash
        }
        print(url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
        
        getData(url: url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!, parameter: nil, header: header, vc: vc, showHud: "yes", title: "", message: "") { (DictResponce) in
            
            if let dictMeta = DictResponce?.value(forKey: "meta")as? [String:Any]{
                if let dictPagination = dictMeta["pagination"]as? [String:Any]{
                    if let dictLinks = dictPagination["links"]as? [String:Any]{
                        if let strUrl = dictLinks["next"]as? String{
                            self.arrGurls[tab] = strUrl
                        }else{
                            guard let strUrlLast = dictLinks["last"]as? String else{
                                
                                completion(true)
                                return
                            }
                            guard  strUrlLast != self.arrGurls[tab] else{
                                
                                completion(true)
                                return
                            }
                            
                        }
                            if let arrData = DictResponce?.value(forKey: "posts")as? [[String:Any]]{
                                
                                for dict in arrData{
                                    if tab == 1{
                                        self.arrTrending.append(dict)
                                    }else if tab == 2{
                                        self.arrRecent.append(dict)
                                    }else if tab == 3{
                                        self.arrSpotlight.append(dict)
                                    }else if tab == 4{
                                        self.arrPopular.append(dict)
                                    }
                                    
                                }
                                
                                self.setDataInSelectedArray(selectedTab: tab)
                                completion(true)
                            }else{
                                
                            }
                            
                            
                        
                        
                    }
                    
                }
            }
            
            
        }
    }
    
    func setDataInSelectedArray(selectedTab:Int){
        if selectedTab == 1{
            selectedArr = arrTrending
        }else if selectedTab == 2{
            selectedArr = arrRecent
        }else if selectedTab == 3{
            selectedArr = arrSpotlight
        }else if selectedTab == 3{
            selectedArr = arrPopular
        }
        print(selectedArr?.count)
    }
    
    func typeOfPost(Index:Int)->[[String:Any]]?{
        var arrPostMultimediaContent = [[String:Any]]()
        guard selectedArr != nil else {
            return arrPostMultimediaContent
        }
        
        if let DictAlbm = selectedArr![Index]["album"]as? [String:Any]{
            print(DictAlbm)
            if let ArrImage = DictAlbm["images"]as? [[String:Any]]{
                for dict in ArrImage{
                    arrPostMultimediaContent.append(dict)
                }
                
            }
            
            if let ArrVideo = DictAlbm["videos"]as? [[String:Any]]{
                for dict in ArrVideo{
                    arrPostMultimediaContent.append(dict)
                }
                
            }
            
            if let ArrAudio = DictAlbm["audios"]as? [[String:Any]]{
                for dict in ArrAudio{
                    arrPostMultimediaContent.append(dict)
                }
            }
            
            
        }else{
            
            if let dictImage = selectedArr![Index]["image"]as? [String:Any]{
                print(dictImage)
                arrPostMultimediaContent.append(dictImage)
                
                
            }
            
            if let dictVideo = selectedArr![Index]["video"]as? [String:Any]{
                print(dictVideo)
                arrPostMultimediaContent.append(dictVideo)
                
            }
            
            if let dictAudio = selectedArr![Index]["audio"]as? [String:Any]{
                print(dictAudio)
                arrPostMultimediaContent.append(dictAudio)
            }
        }
        print(arrPostMultimediaContent)
        return arrPostMultimediaContent
    }
    
    
    
    
    
    func postsCount()->Int{
        guard selectedArr != nil else {
            return 0
        }
        return selectedArr!.count
    }
    
    
    func UserfullName(Index:Int)->String{
        
        guard selectedArr != nil else{
            return ""
        }
        if let usrData = selectedArr![Index]["user"] as? [String:Any]{
            if let fullName = usrData["full_name"]as? String{
                return fullName
            }else{
                return ""
            }
            
        }else{
            return ""
        }
    }
    
    
    
    func UserProfilePic(Index:Int)->String{
        
        guard selectedArr != nil else{
            return ""
        }
        if let usrData = selectedArr![Index]["user"] as? [String:Any]{
            if let profile_image_url = usrData["profile_image_url"]as? String{
                return profile_image_url
            }else{
                return ""
            }
            
        }else{
            return ""
        }
    }
    
    func UserUser_name(Index:Int)->String{
        
        guard selectedArr != nil else{
            return ""
        }
        if let usrData = selectedArr![Index]["user"] as? [String:Any]{
            if let user_name = usrData["user_name"]as? String{
                return user_name
            }else{
                return ""
            }
            
        }else{
            return ""
        }
    }
    func HashTagTopicsOnlyForShow(Index:Int)->String{
        guard selectedArr != nil else{
            return ""
        }
        var str :String? = ""
        if let arrTopics = selectedArr![Index]["topics"] as? [[String:Any]]{
            
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
        guard selectedArr != nil else{
            return ""
        }
        var str :String? = ""
        if let arrTopics = selectedArr![Index]["topics"] as? [[String:Any]]{
            
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
    
    func PostBody(Index:Int)->String{
        guard selectedArr != nil else{
            return ""
        }
        if let body = selectedArr![Index]["body"]as? String{
            
            return body
        }else{
            return ""
        }
        
    }
    
    func userVisibility(Index:Int)->String{
        guard selectedArr != nil else{
            return ""
        }
        if let visibility = selectedArr![Index]["visibility"]as? String{
            return visibility
        }else{
            return ""
        }
        
    }
    func upVotedCount(Index:Int)->String{
        guard selectedArr != nil else{
            return ""
        }
        if let upVoted = selectedArr![Index]["upvotes_count"]as? Int{
            return String(upVoted)
        }else{
            return ""
        }
        
    }
    
    func downVotedCount(Index:Int)->String{
        guard selectedArr != nil else{
            return ""
        }
        if let downVoted = selectedArr![Index]["downvotes_count"]as? Int{
            return String(downVoted)
        }else{
            return ""
        }
        
    }
    
    
    func upVotedByCurntUser(Index:Int)->String{
        guard selectedArr != nil else{
            return ""
        }
        if let upvoted_by_current_user = selectedArr![Index]["upvoted_by_current_user"]as? Bool{
            return String(upvoted_by_current_user)
        }else{
            return ""
        }
        
    }
    
    func downVotedByCurntUser(Index:Int)->String{
        guard selectedArr != nil else{
            return ""
        }
        if let downvoted_by_current_user = selectedArr![Index]["downvoted_by_current_user"]as? Bool{
            return String(downvoted_by_current_user)
        }else{
            return ""
        }
        
    }
    
    func commentCount(Index:Int)->String{
        guard selectedArr != nil else{
            return ""
        }
        if let commentCount = selectedArr![Index]["comments_count"]as? Int{
            return String(commentCount)
        }else{
            return ""
        }
        
    }
    
    func viewsCount(Index:Int)->String{
        guard selectedArr != nil else{
            return ""
        }
        if let views_count = selectedArr![Index]["views_count"]as? Int{
            return String(views_count)
        }else{
            return ""
        }
        
    }
    
    
    
    
    
    
    
    
    
    
    func setLableFirst(lbl1:String,lbl2:String)->NSMutableAttributedString{
        let attrs1 = [NSAttributedStringKey.font : UIFont(name: "HelveticaNeue-Bold", size: 15) ?? UIFont.systemFont(ofSize: 15, weight: .regular)  , NSAttributedStringKey.foregroundColor : (UIColor.black)]
        let attrs2 = [NSAttributedStringKey.font :UIFont(name: "HelveticaNeue-Regular", size: 11) ?? UIFont.systemFont(ofSize: 11, weight: .regular), NSAttributedStringKey.foregroundColor : UIColor.black]
        let attributedString1 = NSMutableAttributedString(string:lbl1, attributes:attrs1)
        let attributedString2 = NSMutableAttributedString(string:" "+lbl2, attributes:attrs2)
        attributedString1.append(attributedString2)
        return attributedString1
    }
}
