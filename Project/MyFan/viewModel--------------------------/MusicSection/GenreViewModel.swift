//
//  GenreViewModel.swift
//  MyFan
//
//  Created by user on 27/09/18.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit

class GenreViewModel: NSObject {
//    let KGetGenresList = "genres"
//    let KGetGenreSongs = "/genre-songs"
    
    var arrGenres = [[String:Any]]()
    var arrGenresSongs = [[String:Any]]()
    
    func GetGenre(vc:UIViewController, completion:@escaping (Bool?)->()){
        
        let header = ["Accept":"application/json",
                      "Authorization":UserDefaults.standard.value(forKey: "Ktoken")as! String]
        
        getData(url: KMainUrl+KGetGenresList, parameter: nil, header: header, vc: vc, showHud: "yes", title: "", message: "") { (DictResponce) in
            // print(DictResponce)
            if let arr = DictResponce?.value(forKey: "genres")as? [[String:Any]]{
                self.arrGenres.removeAll()
                for dict in arr{
                    
                    self.arrGenres.append(dict)
                }
                completion(true)
            }else{
                completion(false)
            }
        }
        
    }
    
    func GenreCount()->Int{
        return arrGenres.count
    }
    
    func GenreID(Index:Int)->String{
        guard Index < arrGenres.count else{
            return ""
        }
        if let str = arrGenres[Index]["id"]as? String{
            
            return str
        }
        if let str = arrGenres[Index]["id"]as? Int{
            return String(str)
        }
        return ""
    }
    
    func GenretTitle(Index:Int)->String{
        guard Index < arrGenres.count else{
            return ""
        }
        if let str = arrGenres[Index]["title"]as? String{
            
            return str
        }
        
        return ""
    }
    
    func GenreSlug(Index:Int)->String{
        guard Index < arrGenres.count else{
            return ""
        }
        if let str = arrGenres[Index]["slug"]as? String{
            
            return str
        }
        
        return ""
    }
    func GenreBannerImage(Index:Int)->String{
        guard Index < arrGenres.count else{
            return ""
        }
        if let str = arrGenres[Index]["banner_image_url"]as? String{
            
            return str
        }
        
        return ""
    }
    func GenreProfileImage(Index:Int)->String{
        guard Index < arrGenres.count else{
            return ""
        }
        if let str = arrGenres[Index]["profile_image_url"]as? String{
            
            return str
        }
        
        return ""
    }
    func GetPlaylistSongs(Index:Int,vc:UIViewController, completion:@escaping (Bool?)->()){
        
        let header = ["Accept":"application/json",
                      "Authorization":UserDefaults.standard.value(forKey: "Ktoken")as! String]
        let strSlug = GenreSlug(Index:Index)
        let url = KMainUrl+KGetGenresList+"/"+strSlug+KGetGenreSongs
        print(url)

        getData(url: url, parameter: nil, header: header, vc: vc, showHud: "yes", title: "", message: "") { (DictResponce) in
            // print(DictResponce)
            if let arr = DictResponce?.value(forKey: "albums")as? [[String:Any]]{
                self.arrGenresSongs.removeAll()
                for dict in arr{
                    
                    self.arrGenresSongs.append(dict)
                }
                completion(true)
            }else{
                completion(false)
            }
        }
        
    }
}

//{
//    "genres": [
//    {
//    "id": 1,
//    "slug": "first-genre",
//    "title": "First Genre",
//    "status": true,
//    "visibility": "public",
//    "profile_image_url": "http://192.168.1.150:3000/assets/banner-00c27ad156dd561260bc788967f26280f54e8479f6bac811148aa8d318255da8.png",
//    "banner_image_url": "http://192.168.1.150:3000/assets/banner-00c27ad156dd561260bc788967f26280f54e8479f6bac811148aa8d318255da8.png",
//    "created_at": "2018-09-26T10:05:29.004Z",
//    "updated_at": "2018-09-26T10:05:29.004Z",
//    "user": {
//    "id": 52,
//    "slug": "rvtech-dev-52-rv_dev",
//    "full_name": "test ",
//    "user_name": "rv_dev",
//    "email": "rvtechdev@mailinator.com",
//    "profile_image_url": "http://192.168.1.150:3000/system/user/images/attachments/000/001/075/original/cropped4332852902863477010.jpg?1535631888",
//    "banner_image_url": "http://192.168.1.150:3000/system/user/banners/attachments/000/001/076/original/cropped4623975126480139255.jpg?1535631942"
//    }
//    },
