//
//  MyAssestsViewModel.swift
//  MyFan
//
//  Created by user on 01/10/18.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit

class MyAssestsViewModel: NSObject {
//    let KMy_Audios = "my-audios"
//    let KMy_Photos = "my-photos"
//    let KMy_Videos = "my-videos"
    
    var arrTrending = [[String:Any]]()
    var arrRecent = [[String:Any]]()
    var arrSpotlight = [[String:Any]]()
    var arrPopular = [[String:Any]]()
    var selectedArr : [[String:Any]]? = nil
    
    var GstrUrl : String? = nil
    var arrGurls = ["","","","",""]
    var TotalPages = [1,1,1,1,1]
    
   
    var arrLocalUpDownvoteIds = [String]()
    var arrLocalUpDownvoteStatus = [String]()
    
    // Audio
//    func GetMyAudios(vc:UIViewController, completion:@escaping (Bool?)->()){
//
//        let header = ["Accept":"application/json",
//                      "Authorization":UserDefaults.standard.value(forKey: "Ktoken")as! String]
//
//        getData(url: KMainUrl+KMy_Audios, parameter: nil, header: header, vc: vc, showHud: "yes", title: "", message: "") { (DictResponce) in
//            // print(DictResponce)
//            if let arr = DictResponce?.value(forKey: "posts")as? [[String:Any]]{
//                self.arrMyAudios.removeAll()
//                for dict in arr{
//
//                    self.arrMyAudios.append(dict)
//                }
//                completion(true)
//            }else{
//                completion(false)
//            }
//        }
//
//    }
    
    
    // video
    
//    func GetMyVideos(vc:UIViewController, completion:@escaping (Bool?)->()){
//
//        let header = ["Accept":"application/json",
//                      "Authorization":UserDefaults.standard.value(forKey: "Ktoken")as! String]
//
//        getData(url: KMainUrl+KMy_Videos, parameter: nil, header: header, vc: vc, showHud: "yes", title: "", message: "") { (DictResponce) in
//            // print(DictResponce)
//            if let arr = DictResponce?.value(forKey: "posts")as? [[String:Any]]{
//                self.arrMyVideos.removeAll()
//                for dict in arr{
//
//                    self.arrMyVideos.append(dict)
//                }
//                completion(true)
//            }else{
//                completion(false)
//            }
//        }
//
//    }
//
    // photos
    
//    func GetMyPhotos(vc:UIViewController, completion:@escaping (Bool?)->()){
//
//        let header = ["Accept":"application/json",
//                      "Authorization":UserDefaults.standard.value(forKey: "Ktoken")as! String]
//
//        getData(url: KMainUrl+KMy_Videos, parameter: nil, header: header, vc: vc, showHud: "yes", title: "", message: "") { (DictResponce) in
//            // print(DictResponce)
//            if let arr = DictResponce?.value(forKey: "posts")as? [[String:Any]]{
//                self.arrMyPhotos.removeAll()
//                for dict in arr{
//
//                    self.arrMyPhotos.append(dict)
//                }
//                completion(true)
//            }else{
//                completion(false)
//            }
//        }
//
//    }
    
    /////////////
    
    //===================              =====================//
    
    func GetMyPhotos(tab:Int,Refresh:Bool ,vc:UIViewController, completion:@escaping (Bool?,String)->()){
        
        let arrApis = ["",KMy_Videos+"?page=1",KMy_Videos+"?page=1",KMy_Videos+"?page=1",KMy_Videos+"?page=1"]
        
        let header = ["Accept":"application/json",
                      "Authorization":UserDefaults.standard.value(forKey: "Ktoken")as! String]
        var url = String()
        if Refresh == true{
            arrGurls[tab] = ""
            if tab == 1{
                arrTrending.removeAll()
            }else if tab == 2{
                arrRecent.removeAll()
            }else if tab == 3{
                arrSpotlight.removeAll()
            }else if tab == 4{
                arrPopular.removeAll()
            }
        }
        guard arrGurls[tab] != "last" else{
            completion(false, "No more Data")
            return
        }
        
        if arrGurls[tab] != ""{
            let tmpUrl = KMainUrl.replacingOccurrences(of: "/api/v1/", with: "")
            
            url = tmpUrl+arrGurls[tab]
        }else{
            url = KMainUrl+arrApis[tab]
        }
        print(url)
        
        getData(url: url, parameter: nil, header: header, vc: vc, showHud: "yes", title: "", message: "") { (DictResponce) in
            
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
                completion(true, "")
            }else{
                
            }
            
            
            if let dictMeta = DictResponce?.value(forKey: "meta")as? [String:Any]{
                if let dictPagination = dictMeta["pagination"]as? [String:Any]{
                    if let pages = dictPagination["total_pages"]as? Int{
                        print(tab)
                        self.TotalPages[tab] = pages
                    }
                    if let dictLinks = dictPagination["links"]as? [String:Any]{
                        if let strUrl = dictLinks["next"]as? String{
                            self.arrGurls[tab] = strUrl
                        }else{
                            
                            self.arrGurls[tab] = "last"
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
        }else if selectedTab == 4{
            selectedArr = arrPopular
        }
        print(selectedArr?.count)
    }
    
    func totalPageCount(tab:Int)->Int{
        return TotalPages[tab]
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
    func GetPostID(Index:Int)->String{
        guard selectedArr != nil else{
            return ""
        }
        guard Index < selectedArr!.count else {
            return "0"
        }
        if let str = selectedArr![Index]["id"] as? String{
            return str
        }
        if let str = selectedArr![Index]["id"] as? Int{
            return String(str)
        }
        return ""
    }
    
    func UserfullName(Index:Int)->String{
        
        guard selectedArr != nil else{
            return ""
        }
        guard Index < selectedArr!.count else {
            return "0"
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
        guard Index < selectedArr!.count else {
            return "0"
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
        guard Index < selectedArr!.count else {
            return "0"
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
        guard Index < selectedArr!.count else {
            return "0"
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
        guard Index < selectedArr!.count else {
            return "0"
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
        guard Index < selectedArr!.count else {
            return "0"
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
        guard Index < selectedArr!.count else {
            return "0"
        }
        if let visibility = selectedArr![Index]["visibility"]as? String{
            return visibility
        }else{
            return ""
        }
        
    }
    func upVotedCount(Index:Int,pluse:Int)->String{
        guard selectedArr != nil else{
            return ""
        }
        guard Index < selectedArr!.count else {
            return "0"
        }
        if let upVoted = selectedArr![Index]["upvotes_count"]as? Int{
            return String(upVoted+pluse)
        }else{
            return ""
        }
        
    }
    
    func downVotedCount(Index:Int,pluse:Int)->String{
        guard selectedArr != nil else{
            return ""
        }
        guard Index < selectedArr!.count else {
            return "0"
        }
        if let downVoted = selectedArr![Index]["downvotes_count"]as? Int{
            return String(downVoted+pluse)
        }else{
            return ""
        }
        
    }
    
    
    func upVotedByCurntUser(Index:Int)->String{
        guard selectedArr != nil else{
            return ""
        }
        guard Index < selectedArr!.count else {
            return "0"
        }
        if let upvoted_by_current_user = selectedArr![Index]["upvoted_by_current_user"]as? Bool{
            print(String(upvoted_by_current_user))
            return String(upvoted_by_current_user)
        }else{
            return ""
        }
        
    }
    
    func downVotedByCurntUser(Index:Int)->String{
        guard selectedArr != nil else{
            return ""
        }
        guard Index < selectedArr!.count else {
            return "0"
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
        guard Index < selectedArr!.count else {
            return "0"
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
        guard Index < selectedArr!.count else {
            return "0"
        }
        if let views_count = selectedArr![Index]["views_count"]as? Int{
            return String(views_count)
        }else{
            return ""
        }
        
    }
    
    func CheakUpvoteDownvoteLocaly(Index:Int)->String{
        
        let PostID =  GetPostID(Index: Index)
        if arrLocalUpDownvoteIds.contains(PostID){
            return "1"
        }
        return "0"
    }
    
    func GetLocalStatusUpvoteOrDOwnVote(Index:Int)->String{
        
        let PostID =  GetPostID(Index: Index)
        if let index = self.arrLocalUpDownvoteIds.index(of: PostID){
            guard index < arrLocalUpDownvoteStatus.count else{
                return "LocalDislike"
            }
            print(arrLocalUpDownvoteStatus[index])
            return  arrLocalUpDownvoteStatus[index]
        }
        return "LocalDislike"
    }
    
    
    func setLableFirst(lbl1:String,lbl2:String)->NSMutableAttributedString{
        let attrs1 = [NSAttributedStringKey.font : UIFont(name: "HelveticaNeue-Bold", size: 15) ?? UIFont.systemFont(ofSize: 15, weight: .regular)  , NSAttributedStringKey.foregroundColor : (UIColor.black)]
        let attrs2 = [NSAttributedStringKey.font :UIFont(name: "HelveticaNeue-Regular", size: 11) ?? UIFont.systemFont(ofSize: 11, weight: .regular), NSAttributedStringKey.foregroundColor : UIColor.black]
        let attributedString1 = NSMutableAttributedString(string:lbl1, attributes:attrs1)
        let attributedString2 = NSMutableAttributedString(string:" "+lbl2, attributes:attrs2)
        attributedString1.append(attributedString2)
        return attributedString1
    }
    
    
    //  MARK:- Upvote Post
    func UpvotePost(Index:Int,vc:UIViewController, completion:@escaping (Bool?,String)->()){
        let header = ["Accept":"application/json",
                      "Authorization":UserDefaults.standard.value(forKey: "Ktoken")as! String]
        let postID = GetPostID(Index: Index)
        let url = KMainUrl+"posts/"+postID+KfeedsUpvote
        print(url)
        postData(url: url, parameter: nil, header: header, vc: vc, showHud: "no") { (DictResponce) in
            if let str = DictResponce?.value(forKey: "message")as? String{
                if str == "Upvoted successfully!" || str == "Success!"{
                    
                    if let index = self.arrLocalUpDownvoteIds.index(of: postID){
                        
                        self.arrLocalUpDownvoteStatus[index] = "LocalLike"
                    }else{
                        self.arrLocalUpDownvoteStatus.append("LocalLike")
                        self.arrLocalUpDownvoteIds.append(postID)
                    }
                    
                    
                    completion(true, str)
                }else{
                    completion(false, str)
                    
                }
            }else{
                completion(false, "Error!")
            }
        }
        
    }
    
    //  MARK:- Downvote Post
    func DownvotePost(Index:Int,vc:UIViewController, completion:@escaping (Bool?,String)->()){
        let header = ["Accept":"application/json",
                      "Authorization":UserDefaults.standard.value(forKey: "Ktoken")as! String]
        let postID = GetPostID(Index: Index)
        
        let url = KMainUrl+"posts/"+postID+KfeedsDownvote
        print(url)
        postData(url: url, parameter: nil, header: header, vc: vc, showHud: "no") { (DictResponce) in
            if let str = DictResponce?.value(forKey: "message")as? String{
                if str == "Downvoted successfully!" || str == "Success!"{
                    
                    if let index = self.arrLocalUpDownvoteIds.index(of: postID){
                        
                        self.arrLocalUpDownvoteStatus[index] = "LocalDislike"
                    }else{
                        self.arrLocalUpDownvoteStatus.append("LocalDislike")
                        self.arrLocalUpDownvoteIds.append(postID)
                    }
                    
                    completion(true, str)
                }else{
                    completion(false, str)
                }
            }else{
                completion(false, "Error!")
            }
        }
        
    }
    
}

