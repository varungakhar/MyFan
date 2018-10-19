//
//  PlaylistViewModel.swift
//  MyFan
//
//  Created by user on 27/09/18.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit

class PlaylistViewModel: NSObject {
    
    var arrPlaylist = [[String:Any]]()
    var arrPlaylistSongs = [[String:Any]]()
    func GetPlaylist(Refresh:Bool,vc:UIViewController, completion:@escaping (Bool?)->()){
        
        let header = ["Accept":"application/json",
                      "Authorization":UserDefaults.standard.value(forKey: "Ktoken")as! String]
        
        getData(url: KMainUrl+KGetPlaylists, parameter: nil, header: header, vc: vc, showHud: "yes", title: "", message: "") { (DictResponce) in
            // print(DictResponce)
            if let arr = DictResponce?.value(forKey: "playlists")as? [[String:Any]]{
                self.arrPlaylist.removeAll()
                for dict in arr{
                    
                    self.arrPlaylist.append(dict)
                }
                completion(true)
            }else{
                completion(false)
            }
        }
        
    }
    
    func PlaylistCount()->Int{
        return arrPlaylist.count
    }
    

    func PlaylistID(Index:Int)->String{
        guard Index < arrPlaylist.count else{
            return ""
        }
        if let str = arrPlaylist[Index]["id"]as? String{
            
            return str
        }
        if let str = arrPlaylist[Index]["id"]as? Int{
            return String(str)
        }
        return ""
    }
    
    func PlaylistName(Index:Int)->String{
        guard Index < arrPlaylist.count else{
            return ""
        }
        if let str = arrPlaylist[Index]["name"]as? String{
            
            return str
        }
     
        return ""
    }
    
    func PlaylistSlug(Index:Int)->String{
        guard Index < arrPlaylist.count else{
            return ""
        }
        if let str = arrPlaylist[Index]["slug"]as? String{
            
            return str
        }
        
        return ""
    }
    func PlaylistImage(Index:Int)->String{
        guard Index < arrPlaylist.count else{
            return ""
        }
        if let str = arrPlaylist[Index]["banner_image_url"]as? String{
            
            return str
        }
        
        return ""
    }
    
    func PlaylistVisibility(Index:Int)->String{
        guard Index < arrPlaylist.count else{
            return ""
        }
        if let str = arrPlaylist[Index]["visibility"]as? String{
            
            return str
        }
        
        return ""
    }
    
    func GetPlaylistSongs(Index:Int,vc:UIViewController, completion:@escaping (Bool?)->()){
        
        let header = ["Accept":"application/json",
                      "Authorization":UserDefaults.standard.value(forKey: "Ktoken")as! String]
        let strSlug = PlaylistSlug(Index:Index)
        let url = KMainUrl+KGetPlaylists+"/"+strSlug+KGetPlaylistSongs
        print(url)
        getData(url: url, parameter: nil, header: header, vc: vc, showHud: "yes", title: "", message: "") { (DictResponce) in
            // print(DictResponce)
            if let arr = DictResponce?.value(forKey: "albums")as? [[String:Any]]{
                self.arrPlaylistSongs.removeAll()
                for dict in arr{
                    
                    self.arrPlaylistSongs.append(dict)
                }
                completion(true)
            }else{
                completion(false)
            }
        }
        
    }

    
    
    
    
//    {
//    "playlists": [
//    {
    
    
    
//    "banner_image_url" = "http://192.168.1.150:3000/system/playlist/images/attachments/000/001/083/original/giphy.gif?1537778036";
//    "created_at" = "2018-09-24T07:32:12.632Z";
//    id = 1;
//    name = "music playlist rv";
//    slug = "music-playlist-rv";
//    status = 1;
//    "updated_at" = "2018-09-24T07:32:12.632Z";
//    "user_id" = 52;
//    visibility = public;
    
    
//    },
//    {
//    "id": 2,
//    "slug": "my-first-playlist",
//    "name": "My First Playlist",
//    "user_id": 52,
//    "status": true,
//    "visibility": "public",
//    "banner_image_url": "http://192.168.1.150:3000/assets/default_music-83c8901e9063bae3884633d7f641355b927a27e15b8ae88b6786b18652d84773.png",
//    "created_at": "2018-09-25T04:31:56.313Z",
//    "updated_at": "2018-09-25T04:31:56.313Z"
//    },
//    }
}
class PL_SongsViewModel: NSObject {
    var arrSongs = [[String:Any]]()
 
    func GetSongs(Refresh:Bool,vc:UIViewController, completion:@escaping (Bool?)->()){
        
        let header = ["Accept":"application/json",
                      "Authorization":UserDefaults.standard.value(forKey: "Ktoken")as! String]
        
        getData(url: KMainUrl+"", parameter: nil, header: header, vc: vc, showHud: "yes", title: "", message: "") { (DictResponce) in
            // print(DictResponce)
            if let arr = DictResponce?.value(forKey: "playlists")as? [[String:Any]]{
                self.arrSongs.removeAll()
                for dict in arr{
                    
                    self.arrSongs.append(dict)
                }
                completion(true)
            }else{
                completion(false)
            }
        }
        
    }
    func SongsCount()->Int{
        return arrSongs.count
    }
    
}

class PL_StationsViewModel: NSObject {
    var arrStations = [[String:Any]]()
    
    func GetStations (Refresh:Bool,vc:UIViewController, completion:@escaping (Bool?)->()){
        
        let header = ["Accept":"application/json",
                      "Authorization":UserDefaults.standard.value(forKey: "Ktoken")as! String]
        
        getData(url: KMainUrl+"", parameter: nil, header: header, vc: vc, showHud: "yes", title: "", message: "") { (DictResponce) in
            // print(DictResponce)
            if let arr = DictResponce?.value(forKey: "playlists")as? [[String:Any]]{
                self.arrStations.removeAll()
                for dict in arr{
                    
                    self.arrStations.append(dict)
                }
                completion(true)
            }else{
                completion(false)
            }
        }
        
    }
    func StationsCount()->Int{
        return arrStations.count
    }
}


class PL_DownLoadsViewModel: NSObject {
    var arrDownLoads = [[String:Any]]()
    
    func GetDownLoads(Refresh:Bool,vc:UIViewController, completion:@escaping (Bool?)->()){
        
        let header = ["Accept":"application/json",
                      "Authorization":UserDefaults.standard.value(forKey: "Ktoken")as! String]
        
        getData(url: KMainUrl+"", parameter: nil, header: header, vc: vc, showHud: "yes", title: "", message: "") { (DictResponce) in
            // print(DictResponce)
            if let arr = DictResponce?.value(forKey: "playlists")as? [[String:Any]]{
                self.arrDownLoads.removeAll()
                for dict in arr{
                    
                    self.arrDownLoads.append(dict)
                }
                completion(true)
            }else{
                completion(false)
            }
        }
        
    }
    
    func DownLoadsCount()->Int{
        return arrDownLoads.count
    }
}
