//
//  AlbumViewModel.swift
//  MyFan
//
//  Created by user on 27/09/18.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit

class AlbumViewModel: NSObject {
//    let KGetAlbums = "albums"
//    let KAlbumSongs = "/albums_songs"
    var strSelectedAlbumName = String()
    var arrAlbums = [[String:Any]]()
    var arrSongs = [[String:Any]]()
    func GetAlbums(vc:UIViewController, completion:@escaping (Bool?)->()){
        
        let header = ["Accept":"application/json",
                      "Authorization":UserDefaults.standard.value(forKey: "Ktoken")as! String]
        
        getData(url: KMainUrl+KGetAlbums, parameter: nil, header: header, vc: vc, showHud: "yes", title: "", message: "") { (DictResponce) in
            // print(DictResponce)
            if let arr = DictResponce?.value(forKey: "albums")as? [[String:Any]]{
                self.arrAlbums.removeAll()
                for dict in arr{
                    
                    self.arrAlbums.append(dict)
                }
                completion(true)
            }else{
                completion(false)
            }
        }
        
    }
    
   // MARK:- Album Detail
    func AlbumCount()->Int{
        return arrAlbums.count
    }
    func albumID(Index:Int)->String{
        guard Index < arrAlbums.count else{
            return ""
        }
        if let str = arrAlbums[Index]["id"]as? String{
            
            return str
        }
        if let str = arrAlbums[Index]["id"]as? Int{
            return String(str)
        }
        return ""
    }
    func albumName(Index:Int)->String{
        guard Index < arrAlbums.count else{
            return ""
        }
        if let str = arrAlbums[Index]["name"]as? String{
            
            return str
        }
         return ""
    }
    func albumSlug(Index:Int)->String{
        guard Index < arrAlbums.count else{
            return ""
        }
        if let str = arrAlbums[Index]["slug"]as? String{
            
            return str
        }
        
        if let str = arrAlbums[Index]["slug"]as? Int{
            return String(str)
        }
        return ""
    }
    func SongsCountInAlbum(Index:Int)->String{
        guard Index < arrAlbums.count else{
            return "0 Songs"
        }
        if let arr = arrAlbums[Index]["album_audios"]as? [[String:Any]]{
            
             return String(arr.count)+" Songs"
        }
        
       return "0 Songs"
    }
    //MARK:- Album Songs Detail
    
    func FillSongsArr(Index:Int){
        guard Index < arrAlbums.count else{
              arrSongs.removeAll()
            return
        }
        if let arr = arrAlbums[Index]["album_audios"]as? [[String:Any]]{
            
            arrSongs = arr
            strSelectedAlbumName = albumName(Index: Index)
        }else{
            arrSongs.removeAll()
        }
    }
    
    func SelectedAlbumName()->String{
     return strSelectedAlbumName
    }
    
    
    func albumSongCount()->Int{
      return arrSongs.count
    }
    func albumSongID(Index:Int)->String{
        guard Index < arrSongs.count else{
            return ""
        }
        if let str = arrSongs[Index]["id"]as? String{
            
            return str
        }
        if let str = arrSongs[Index]["id"]as? Int{
            return String(str)
        }
        return ""
    }
    func albumSongName(Index:Int)->String{
        guard Index < arrSongs.count else{
            return ""
        }
        if let str = arrSongs[Index]["name"]as? String{
            
            return str
        }
        return ""
    }
    func albumSongSlug(Index:Int)->String{
        guard Index < arrSongs.count else{
            return ""
        }
        if let str = arrSongs[Index]["slug"]as? String{
            
            return str
        }
        
        if let str = arrSongs[Index]["slug"]as? Int{
            return String(str)
        }
        return ""
    }
    

    func albumSongAudioUrl(Index:Int)->String{
        guard Index < arrSongs.count else{
            return ""
        }
        if let str = arrSongs[Index]["audio_thumb_url"]as? String{
            
            return str
        }
    
        return ""
    }
    
    func albumSongImageUrl(Index:Int)->String{
        guard Index < arrSongs.count else{
            return ""
        }
        if let str = arrSongs[Index]["banner_url"]as? String{
            
            return str
        }
   
        return ""
    }
    func albumSongRank(Index:Int)->String{
        guard Index < arrSongs.count else{
            return ""
        }
        if let str = arrSongs[Index]["rank"]as? String{
            
            return str
        }
        
        if let str = arrSongs[Index]["rank"]as? Int{
            return String(str)
        }
        return ""
    }
    
    //MARK:- Song Artist
    
    func songArtistId(Index:Int)->String{
        guard Index < arrSongs.count else{
            return ""
        }
        if let dict = arrSongs[Index]["artist"]as? [String:Any]{
            
            if let str = dict["id"]as? String{
                return str
            }
            if let str = dict["id"]as? Int{
                return String(str)
            }
        }
        return ""
    }
    
    func songArtistName(Index:Int)->String{
        guard Index < arrSongs.count else{
            return ""
        }
        if let dict = arrSongs[Index]["artist"]as? [String:Any]{
            
            if let str = dict["full_name"]as? String{
                return str
            }
        }
        return ""
    }
    func songArtistSlug(Index:Int)->String{
        guard Index < arrSongs.count else{
            return ""
        }
        if let dict = arrSongs[Index]["artist"]as? [String:Any]{
            
            if let str = dict["slug"]as? String{
                return str
            }
        }
        return ""
    }
    func songArtistEmail(Index:Int)->String{
        guard Index < arrSongs.count else{
            return ""
        }
        if let dict = arrSongs[Index]["artist"]as? [String:Any]{
            
            if let str = dict["email"]as? String{
                return str
            }
        }
        return ""
    }
    
//    {
//    "albums": [
//    {
//    "id": 48,
//    "slug": "225ba322277fb52012edab765ea891",
//    "name": "testing album",
//    "user_id": 52,
//    "post_id": null,
//    "visibility": "public",
//    "album_type": "music",
//    "created_at": "2018-09-26T07:13:08.590Z",
//    "updated_at": "2018-09-26T07:13:08.590Z",
//    "images": [],
//    "videos": [],
//    "audios": [],
//    "album_audios": [
//    {
//    "id": 47,
//    "slug": "4f23f6006c701ed51ca0b5aec6dec0",
//    "audio_thumb_url": "http://192.168.1.150:3000/system/album/audios/attachments/000/000/047/original/Hindi_vs_Punjabi_Sad_Songs_Mashup___Deepshikha___Acoustic_Singh___Bollywood_Punj.mp3?1537945999",
//    "banner_url": "http://192.168.1.150:3000/assets/default_music-83c8901e9063bae3884633d7f641355b927a27e15b8ae88b6786b18652d84773.png",
//    "rank": 68,
//    "artist": {
//    "id": 185,
//    "slug": "naina-naina",
//    "full_name": "naina",
//    "email": "naina@gmail.com"
//    }
//    },
//    {
//    "id": 46,
//    "slug": "e58f5cbd68269d30d2a8eb33100532",
//    "audio_thumb_url": "http://192.168.1.150:3000/system/album/audios/attachments/000/000/046/original/Hindi_vs_Punjabi_Sad_Songs_Mashup___Deepshikha___Acoustic_Singh___Bollywood_Punj.mp3?1537945988",
//    "banner_url": "http://192.168.1.150:3000/assets/default_music-83c8901e9063bae3884633d7f641355b927a27e15b8ae88b6786b18652d84773.png",
//    "rank": 77,
//    "artist": {
//    "id": 185,
//    "slug": "naina-naina",
//    "full_name": "naina",
//    "email": "naina@gmail.com"
//    }
//    },
//    {
//    "id": 51,
//    "slug": "1aa31027cf01a2b3ad9889fbfac842",
//    "audio_thumb_url": "http://192.168.1.150:3000/system/album/audios/attachments/000/000/051/original/hayatitamildadainforingtone-42186.mp3?1538033577",
//    "banner_url": "http://192.168.1.150:3000/system/album/audio/images/attachments/000/001/108/original/genre_pop.jpg?1538033577",
//    "rank": 18,
//    "artist": {
//    "id": 143,
//    "slug": "maksdit-143-maksdit",
//    "full_name": "Maksdit",
//    "email": "spectrocoin3@mail.ru"
//    }
//    },
//    {
//    "id": 52,
//    "slug": "e7769ce441f702d855037660f447a8",
//    "audio_thumb_url": "http://192.168.1.150:3000/system/album/audios/attachments/000/000/052/original/blessed_bet.mp3?1538043630",
//    "banner_url": "http://192.168.1.150:3000/system/album/audio/images/attachments/000/001/109/original/cropped4147297460853141425.jpg?1538043630",
//    "rank": 37,
//    "artist": {
//    "id": 185,
//    "slug": "naina-naina",
//    "full_name": "naina",
//    "email": "naina@gmail.com"
//    }
//    },
//    {
//    "id": 54,
//    "slug": "973198fd834af830bac163f3a6a716",
//    "audio_thumb_url": "http://192.168.1.150:3000/system/album/audios/attachments/000/000/054/original/hayatitamildadainforingtone-42186.mp3?1538107047",
//    "banner_url": "http://192.168.1.150:3000/system/album/audio/images/attachments/000/001/111/original/genre_rock_beat.jpg?1538107048",
//    "rank": 49,
//    "artist": {
//    "id": 143,
//    "slug": "maksdit-143-maksdit",
//    "full_name": "Maksdit",
//    "email": "spectrocoin3@mail.ru"
//    }
//    }
//    ]
//    },
    
    
    
    
    
    
//    {
//    "id": 49,
//    "slug": "c49589a1d4d34c12f4a34b642d875c",
//    "name": "new album",
//    "user_id": 52,
//    "post_id": null,
//    "visibility": "public",
//    "album_type": "music",
//    "created_at": "2018-09-26T07:33:51.026Z",
//    "updated_at": "2018-09-26T07:33:51.026Z",
//    "images": [],
//    "videos": [],
//    "audios": [],
//    "album_audios": [
//    {
//    "id": 48,
//    "slug": "350266487407564782fb1d53e5ffd9",
//    "audio_thumb_url": "http://192.168.1.150:3000/system/album/audios/attachments/000/000/048/original/Hindi_vs_Punjabi_Sad_Songs_Mashup___Deepshikha___Acoustic_Singh___Bollywood_Punj.mp3?1537947231",
//    "banner_url": "http://192.168.1.150:3000/system/album/audio/images/attachments/000/001/106/original/Yummi-footer.png?1537947231",
//    "rank": 91,
//    "artist": {
//    "id": 185,
//    "slug": "naina-naina",
//    "full_name": "naina",
//    "email": "naina@gmail.com"
//    }
//    },
//    {
//    "id": 49,
//    "slug": "6532d2c8043e904f6ec4953fd8cf52",
//    "audio_thumb_url": "http://192.168.1.150:3000/system/album/audios/attachments/000/000/049/original/Hindi_vs_Punjabi_Sad_Songs_Mashup___Deepshikha___Acoustic_Singh___Bollywood_Punj.mp3?1537951403",
//    "banner_url": "http://192.168.1.150:3000/system/album/audio/images/attachments/000/001/107/original/sp.jpg?1537951403",
//    "rank": 31,
//    "artist": {
//    "id": 185,
//    "slug": "naina-naina",
//    "full_name": "naina",
//    "email": "naina@gmail.com"
//    }
//    }
//    ]
//    },
//    {
//    "id": 50,
//    "slug": "30c2590147d507435e575d5beb0ed6",
//    "name": "asas",
//    "user_id": 52,
//    "post_id": null,
//    "visibility": "public",
//    "album_type": "music",
//    "created_at": "2018-09-27T13:23:14.464Z",
//    "updated_at": "2018-09-27T13:23:14.464Z",
//    "images": [],
//    "videos": [],
//    "audios": [],
//    "album_audios": [
//    {
//    "id": 53,
//    "slug": "5e0b992cf2140bccdf78403e5b9eb9",
//    "audio_thumb_url": "http://192.168.1.150:3000/system/album/audios/attachments/000/000/053/original/SampleAudio_0.7mb.mp3?1538054595",
//    "banner_url": "http://192.168.1.150:3000/system/album/audio/images/attachments/000/001/110/original/icons8-topic-50.png?1538054595",
//    "rank": 4,
//    "artist": null
//    }
//    ]
//    }
//    ],
//    "meta": {
//    "pagination": {
//    "per_page": 20,
//    "total_pages": 1,
//    "total_objects": 3,
//    "links": {
//    "first": "/api/v1/albums?page=1",
//    "last": "/api/v1/albums?page=1"
//    }
//    }
//    }
//    }
    
    
    
    
    
    
    
    
}
