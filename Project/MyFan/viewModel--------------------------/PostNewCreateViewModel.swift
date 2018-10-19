//
//  PostNewCreateViewModel.swift
//  MyFan
//
//  Created by user on 10/09/18.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit

class PostNewCreateViewModel: NSObject {
    var arrTags = [[String:Any]]()
    var arrPostItems = [[String:Any]]()
    var typeofuplodeMedia = [String]()
    func getTags(text:String ,vc:UIViewController ,completion:@escaping (Bool?)->()){
        let header = ["Accept":"application/json",
                      "Authorization":UserDefaults.standard.value(forKey: "Ktoken")as! String]
        
        let param = ["search":text]
        postData(url: KMainUrl+KSuggetionTags, parameter: param, header: header, vc: vc, showHud: "no") { (DictResponce) in
       
            if let arr = DictResponce?.value(forKey: "topics")as? [[String:Any]]{
              self.arrTags.removeAll()
                for dict in arr{
                    self.arrTags.append(dict)
                }

               completion(true)
            }else{
              self.arrTags.removeAll()
                completion(false)
            }
        }
  
    }

    func tagsCount()->Int{
  
        return arrTags.count
    }
    func tagName(Index:Int)-> String{
        guard Index<arrTags.count else{
            return ""
        }
        if let str = arrTags[Index]["name"]as? String{
            return str
        }else{
            return ""
        }
    }
    func tagID(Index:Int)-> String{
        guard Index<arrTags.count else{
            return ""
        }
        if let str = arrTags[Index]["id"]as? Int{
            return String(str)
        }else{
            return ""
        }
    }
    
    //MultiPart

    func postMultimediaData(param:[String:String],dictImg:[String:Data]?,vc:UIViewController ,completion:@escaping (Bool?)->()){
        
        let header = ["Accept":"application/json",
                      "Content-Type": "multipart/form-data",
                      "Authorization":UserDefaults.standard.value(forKey: "Ktoken")as! String]
       
        postDataWithImage2(url: KMainUrl+KUploadMultimedia, parameter: param as NSDictionary, header: header, dictUploadData: dictImg, vc: vc, showHud: "yes", title: "", message: "") { (dictResponce) in
            
            //  print(dictResponce)
            if let dictUser = dictResponce?.value(forKey: "user")as?[String:Any]{
                if let _ = dictUser["id"]as? Int{
                    self.arrPostItems.append(dictResponce as! [String : Any])
                    self.typeofuplodeMedia.append(param["upload_type"]!)
                    completion(true)
                }else{
                 completion(false)
                }
            }else{
               completion(false)
            }
            
        }
        
        
    }
    
    func ItemCount()-> Int{
        return arrPostItems.count
    }
    func itemImgUrl(Index:Int)->String{
        guard Index < arrPostItems.count else{
         return ""
        }
        if let str = arrPostItems[Index]["image_url"]as? String{
            return str
        }else{
             return ""
        }
    
    }
    func uploadType(Index:Int)->String{
        guard Index < arrPostItems.count else{
            return "image"
        }
        return typeofuplodeMedia[Index]
    }
    
    func UploadImgsIds()->[String]{
        var arr = [String]()
        print(typeofuplodeMedia)
        for i in 0..<typeofuplodeMedia.count{
            if typeofuplodeMedia[i] == "image"{
                if let dict = arrPostItems[i]["user"]as? [String:Any]{
                    if let id = dict["id"]as? Int{
                        arr.append(String(id))
                    }else{
                        
                    }
                }else{
                    
                }
            }
        }
        return arr
    }
    
    func UploadVideoIds()->[String]{
        var arr = [String]()
        print(typeofuplodeMedia)
        for i in 0..<typeofuplodeMedia.count{
            if typeofuplodeMedia[i] == "video"{
                if let dict = arrPostItems[i]["user"]as? [String:Any]{
                    if let id = dict["id"]as? Int{
                        arr.append(String(id))
                    }else{
                        
                    }
                }else{
                    
                }
            }
        }
        return arr
    }
    
    func UploadAudioIds()->[String]{
        var arr = [String]()
        print(typeofuplodeMedia)
        for i in 0..<typeofuplodeMedia.count{
            if typeofuplodeMedia[i] == "audio"{
                if let dict = arrPostItems[i]["user"]as? [String:Any]{
                    if let id = dict["id"]as? Int{
                        arr.append(String(id))
                    }else{
                        
                    }
                }else{
                    
                }
            }
        }
        return arr
    }
    // Share Post
    func ShareMyPost(param:[String:Any],vc:UIViewController ,completion:@escaping (Bool?,String)->()){
        
        
        let header = ["Accept":"application/json",
                      "Authorization":UserDefaults.standard.value(forKey: "Ktoken")as! String]
        
        
        postData(url: KMainUrl+KSharePost, parameter: param, header: header, vc: vc, showHud: "yes") { (DictResponce) in
            
            if let msg = DictResponce?.value(forKey: "message")as? String{
                if msg == "Post successfully created!"{
                    self.arrPostItems.removeAll()
                    self.typeofuplodeMedia.removeAll()
                    completion(true, msg)

                }else{
                    completion(true, msg)

                }
                }else{
                completion(true, "error!")

            }
        }
        
    }

}
