//
//  MusicViewModel.swift
//  MyFan
//
//  Created by user on 27/09/18.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit

class MusicViewModel: NSObject {
//    let KGetNearByArtist = "music-feeds/near-artists"
//    
//    let KMusicFeedsTrending = "music-feeds/trending"
//    let KMusicFeedsRecent = "music-feeds/recent"
//    let KMusicFeedsSpotlight = "music-feeds/spotlight"
//    let KMusicFeedsPopular = "music-feeds/popular"
    var ArrNearByArtist = [[String:Any]]()
    
    var arrTrending = [[String:Any]]()
    var arrRecent = [[String:Any]]()
    var arrSpotlight = [[String:Any]]()
    var arrPopular = [[String:Any]]()
    var selectedArr : [[String:Any]]? = nil
    
    var GstrUrl : String? = nil
    var arrGurls = ["","","","",""]
    var TotalPages = [1,1,1,1,1]
    var arrUpvoteTemp = [[Int]]()
    var arrDownvoteTemp = [[Int]]()
    
    func GetNearByArtis(vc:UIViewController, completion:@escaping (Bool?)->()){
        
        let header = ["Accept":"application/json",
                      "Authorization":UserDefaults.standard.value(forKey: "Ktoken")as! String]
        
        getData(url: KMainUrl+KGetNearByArtist, parameter: nil, header: header, vc: vc, showHud: "yes", title: "", message: "") { (DictResponce) in
            // print(DictResponce)
            if let arr = DictResponce?.value(forKey: "users")as? [[String:Any]]{
                self.ArrNearByArtist.removeAll()
                for dict in arr{
                    self.ArrNearByArtist.append(dict)
                }
                completion(true)
            }else{
                completion(false)
            }
        }
        
    }
    
    func NearByArtistCount()->Int{
        return ArrNearByArtist.count
    }
    
    func NearByArtistfullName(Index:Int)->String{
        guard Index < ArrNearByArtist.count else {
            return ""
        }
        if let str = ArrNearByArtist[Index]["full_name"]as? String{
            return str
        }
        return ""
    }
    
    func NearByArtistAbout(Index:Int)->String{
        guard Index < ArrNearByArtist.count else {
            return ""
        }
        if let str = ArrNearByArtist[Index]["professional_text_line"]as? String{
            return str
        }
        return ""
    }
    
    func NearByArtistImage(Index:Int)->String{
        guard Index < ArrNearByArtist.count else {
            return ""
        }
        if let str = ArrNearByArtist[Index]["profile_image_url"]as? String{
            return str
        }
        return ""
    }

    
 
    
    
    //===================              =====================//
    
    func GeMusicFeedData(tab:Int,Refresh:Bool ,vc:UIViewController, completion:@escaping (Bool?,String)->()){
        
        let arrApis = ["",KMusicFeedsTrending+"?page=1",KMusicFeedsRecent+"?page=1",KMusicFeedsSpotlight+"?page=1",KMusicFeedsPopular+"?page=1"]
        
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
            
            if let arrData = DictResponce?.value(forKey: "album/audios")as? [[String:Any]]{
                
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
   
    func postsCount()->Int{
        guard selectedArr != nil else {
            return 0
        }
        print(selectedArr!.count)
        return selectedArr!.count
    }
    
    //  MARK:- Audio Detail
    
    func AudioId(Index:Int)->String{
        guard selectedArr != nil else{
            return ""
        }
        guard Index < selectedArr!.count else {
            return ""
        }
        if let str = selectedArr![Index]["id"] as? String{
            return str
        }
        if let str = selectedArr![Index]["id"] as? Int{
            return String(str)
        }
        return ""
    }
    
    func AudioTitle(Index:Int)->String{
        guard selectedArr != nil else{
            return ""
        }
        guard Index < selectedArr!.count else {
            return ""
        }
        if let str = selectedArr![Index]["title"] as? String{
            return str
        }
       
        return ""
    }
    
    func AudioThumbImg(Index:Int)->String{
        guard selectedArr != nil else{
            return ""
        }
        guard Index < selectedArr!.count else {
            return ""
        }
        if let str = selectedArr![Index]["audio_thumb_url"] as? String{
            return str
        }
        
        return ""
    }
    
    func AudioUrl(Index:Int)->String{
        guard selectedArr != nil else{
            return ""
        }
        guard Index < selectedArr!.count else {
            return ""
        }
        if let str = selectedArr![Index]["attachment_url"] as? String{
            return str
        }
        
        return ""
    }
    
    func AudioVisibility(Index:Int)->String{
        guard selectedArr != nil else{
            return ""
        }
        guard Index < selectedArr!.count else {
            return ""
        }
        if let str = selectedArr![Index]["visibility"] as? String{
            return str
        }
        
        return ""
    }
    
    func AudioSlug(Index:Int)->String{
        guard selectedArr != nil else{
            return ""
        }
        guard Index < selectedArr!.count else {
            return ""
        }
        if let str = selectedArr![Index]["slug"] as? String{
            return str
        }
        
        return ""
    }
    
    func AudioComments_count(Index:Int)->String{
        guard selectedArr != nil else{
            return ""
        }
        guard Index < selectedArr!.count else {
            return ""
        }
        if let str = selectedArr![Index]["comments_count"] as? String{
            return str
        }
        if let str = selectedArr![Index]["comments_count"] as? Int{
            return String(str)
        }
        return ""
    }
    
    func AudioUpvotes_count(Index:Int)->String{
        guard selectedArr != nil else{
            return ""
        }
        guard Index < selectedArr!.count else {
            return ""
        }
        if let str = selectedArr![Index]["upvotes_count"] as? String{
            return str
        }
        if let str = selectedArr![Index]["upvotes_count"] as? Int{
            return String(str)
        }
        return ""
    }
    
    func AudioDownvotes_count(Index:Int)->String{
        guard selectedArr != nil else{
            return ""
        }
        guard Index < selectedArr!.count else {
            return ""
        }
        if let str = selectedArr![Index]["downvotes_count"] as? String{
            return str
        }
        if let str = selectedArr![Index]["downvotes_count"] as? Int{
            return String(str)
        }
        return ""
    }
    
    func AudioCreated_at(Index:Int)->String{
        guard selectedArr != nil else{
            return ""
        }
        guard Index < selectedArr!.count else {
            return ""
        }
        if let str = selectedArr![Index]["created_at"] as? String{
            return str
        }
        if let str = selectedArr![Index]["created_at"] as? Int{
            return String(str)
        }
        return ""
    }
    
    func AudioViews_count(Index:Int)->String{
        guard selectedArr != nil else{
            return ""
        }
        guard Index < selectedArr!.count else {
            return ""
        }
        if let str = selectedArr![Index]["views_count"] as? String{
            return str
        }
        if let str = selectedArr![Index]["views_count"] as? Int{
            return String(str)
        }
        return ""
    }
    
    func AudioUpvoted_by_current_user(Index:Int)->String{
        guard selectedArr != nil else{
            return "0"
        }
        guard Index < selectedArr!.count else {
            return "0"
        }
  
        if let bool = selectedArr![Index]["upvoted_by_current_user"] as? Bool{
            return String(bool)
        }
        return "0"
    }
    
    func AudioDownvoted_by_current_user(Index:Int)->String{
        guard selectedArr != nil else{
            return "0"
        }
        guard Index < selectedArr!.count else {
            return "0"
        }
        
        if let bool = selectedArr![Index]["downvoted_by_current_user"] as? Bool{
            return String(bool)
        }
        return "0"
    }
    
    
    
  //  MARK:- Artist
    
    func ArtistfullName(Index:Int)->String{
        
        guard selectedArr != nil else{
            return ""
        }
        guard Index < selectedArr!.count else {
            return ""
        }
        
        if let atist = selectedArr![Index]["artist"] as? [String:Any]{
            if let str = atist["full_name"]as? String{
                return str
            }
        }
        return ""
    }
    
    func ArtistID(Index:Int)->String{
        
        guard selectedArr != nil else{
            return ""
        }
        guard Index < selectedArr!.count else {
            return ""
        }
        
        if let atist = selectedArr![Index]["artist"] as? [String:Any]{
            if let str = atist["id"]as? String{
                return str
            }
            if let str = atist["id"]as? Int{
                return String(str)
            }
        }
        return ""
    }
    
    func ArtistSlug(Index:Int)->String{
        
        guard selectedArr != nil else{
            return ""
        }
        guard Index < selectedArr!.count else {
            return ""
        }
        
        if let atist = selectedArr![Index]["artist"] as? [String:Any]{
            if let str = atist["slug"]as? String{
                return str
            }
        }
        return ""
    }
    
    
    func ArtistProfilePic(Index:Int)->String{
        
        guard selectedArr != nil else{
            return ""
        }
        guard Index < selectedArr!.count else {
            return ""
        }
        
        if let atist = selectedArr![Index]["artist"] as? [String:Any]{
            if let str = atist["profile_image_url"]as? String{
                return str
            }
        }
        return ""
    }
    func ArtistUser_name(Index:Int)->String{
        
        guard selectedArr != nil else{
            return ""
        }
        guard Index < selectedArr!.count else {
            return ""
        }
        
        if let atist = selectedArr![Index]["artist"] as? [String:Any]{
            if let str = atist["user_name"]as? String{
                return str
            }
        }
        return ""
    }
    
    
    func ArtistVisibility(Index:Int)->String{
        
        guard selectedArr != nil else{
            return ""
        }
        guard Index < selectedArr!.count else {
            return ""
        }
        
        if let atist = selectedArr![Index]["artist"] as? [String:Any]{
            if let str = atist["visibility"]as? String{
                return str
            }
        }
        return ""
    }
    
    func ArtistBanner_image_url(Index:Int)->String{
        
        guard selectedArr != nil else{
            return ""
        }
        guard Index < selectedArr!.count else {
            return ""
        }
        
        if let atist = selectedArr![Index]["artist"] as? [String:Any]{
            if let str = atist["banner_image_url"]as? String{
                return str
            }
        }
        return ""
    }
    
    
    func ArtistEmail(Index:Int)->String{
        
        guard selectedArr != nil else{
            return ""
        }
        guard Index < selectedArr!.count else {
            return ""
        }
        
        if let atist = selectedArr![Index]["artist"] as? [String:Any]{
            if let str = atist["email"]as? String{
                return str
            }
        }
        return ""
    }
    
    
    
    
    func setLableFirst(lbl1:String,lbl2:String)->NSMutableAttributedString{
        let attrs1 = [NSAttributedStringKey.font : UIFont(name: "HelveticaNeue-Bold", size: 15) ?? UIFont.systemFont(ofSize: 15, weight: .regular)  , NSAttributedStringKey.foregroundColor : (UIColor.black)]
        let attrs2 = [NSAttributedStringKey.font :UIFont(name: "HelveticaNeue-Regular", size: 11) ?? UIFont.systemFont(ofSize: 11, weight: .regular), NSAttributedStringKey.foregroundColor : UIColor.black]
        let attributedString1 = NSMutableAttributedString(string:lbl1, attributes:attrs1)
        let attributedString2 = NSMutableAttributedString(string:" @"+lbl2, attributes:attrs2)
        attributedString1.append(attributedString2)
        return attributedString1
    }
    
    
    
    
}
