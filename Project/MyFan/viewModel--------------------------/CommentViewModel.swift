//
//  CommentViewModel.swift
//  MyFan
//
//  Created by user on 15/10/18.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit

class CommentViewModel: NSObject {
    var arrComments = [[String:Any]]()
    var arrReply = [[String:Any]]()
    // MARK:- Received Requests data
    func GetCommentsOnPost(postID:String,Refresh:Bool ,vc:UIViewController, completion:@escaping (Bool?,String)->()){
        let header = ["Accept":"application/json",
                      "Authorization":UserDefaults.standard.value(forKey: "Ktoken")as! String]
        
        let url = KMainUrl+"posts/"+postID+KGetPostComments
        print(url)
        getData(url:url , parameter: nil, header: header, vc: vc, showHud: "yes", title: "", message: "") { (DictResponce) in
            print(DictResponce)
            if let arrData = DictResponce?.value(forKey: "post/comments")as? [[String:Any]]{
                self.arrComments.removeAll()
                for dict in arrData{
                    
                    self.arrComments.append(dict)
                    
                }
                
                
                completion(true, "")
            }else{
                
            }
            
        }
    }
    
    func CommentsCount()->Int{
        return arrComments.count
    }
    
    
    func getCommentID(Index:Int)->String{
        guard Index<arrComments.count else {
            return ""
        }
        if let str = arrComments[Index]["id"] as? String{
            return str
        }
        if let str = arrComments[Index]["id"] as? Int{
            
            return String(str)
        }
        return ""
    }
    
    func getCommentSourceID(Index:Int)->String{
        guard Index<arrComments.count else {
            return ""
        }
        if let str = arrComments[Index]["source_id"] as? String{
            return str
        }
        if let str = arrComments[Index]["source_id"] as? Int{
            return String(str)
        }
        return ""
    }
    
    func getCommentSlug(Index:Int)->String{
        guard Index<arrComments.count else {
            return ""
        }
        if let str = arrComments[Index]["slug"] as? String{
            return str
        }
     
        return ""
    }
    
    func getCommentBody(Index:Int)->String{
        guard Index<arrComments.count else {
            return ""
        }
        if let str = arrComments[Index]["body"] as? String{
            return str
        }
        
        return ""
    }
    
    func getCommentUpvoteCount(Index:Int)->String{
        guard Index<arrComments.count else {
            return ""
        }
        if let str = arrComments[Index]["upvote_count"] as? String{
            return str
        }
        if let str = arrComments[Index]["upvote_count"] as? Int{
            return String(str)
        }
        return ""
    }
    
    func getCommentDownvoteCount(Index:Int)->String{
        guard Index<arrComments.count else {
            return ""
        }
        if let str = arrComments[Index]["downvote_count"] as? String{
            return str
        }
        if let str = arrComments[Index]["downvote_count"] as? Int{
            return String(str)
        }
        return ""
    }
    
    
    func getCommentUpvoteBtCrrntUser(Index:Int)->String{
        guard Index<arrComments.count else {
            return ""
        }
        if let str = arrComments[Index]["upvoted_by_current_user"] as? String{
            return str
        }
        if let str = arrComments[Index]["upvoted_by_current_user"] as? Bool{
            return String(str)
        }
        return ""
    }
    
    func getCommentDownvoteBtCrrntUser(Index:Int)->String{
        guard Index<arrComments.count else {
            return ""
        }
        if let str = arrComments[Index]["downvoted_by_current_user"] as? String{
            return str
        }
        if let str = arrComments[Index]["downvoted_by_current_user"] as? Bool{
            return String(str)
        }
        return ""
    }
    
    func getCommentRepliesCount(Index:Int)->String{
        guard Index<arrComments.count else {
            return ""
        }
        if let str = arrComments[Index]["replies_count"] as? String{
            return str
        }
        if let str = arrComments[Index]["replies_count"] as? Bool{
            return String(str)
        }
        return ""
    }
    
    
    // User Info
    func Comment_User_ID(Index:Int)->String{
        guard Index<arrComments.count else {
            return ""
        }
        if let dict = arrComments[Index]["user"] as? [String:Any]{
            if let str = dict["id"]as? String{
                return str
            }
            if let str = dict["id"]as? Int{
                return String(str)
            }
        }
        
        return ""
    }
    
    func Comment_Full_Name(Index:Int)->String{
        guard Index<arrComments.count else {
            return ""
        }
        if let dict = arrComments[Index]["user"] as? [String:Any]{
            if let str = dict["full_name"]as? String{
                return str
            }
        }
      
        return ""
    }
    
    func Comment_User_Name(Index:Int)->String{
        guard Index<arrComments.count else {
            return ""
        }
        if let dict = arrComments[Index]["user"] as? [String:Any]{
            if let str = dict["user_name"]as? String{
                return str
            }
        }
        
        return ""
    }
    
    func Comment_User_ProfilePic(Index:Int)->String{
        guard Index<arrComments.count else {
            return ""
        }
        if let dict = arrComments[Index]["user"] as? [String:Any]{
            if let str = dict["profile_image_url"]as? String{
                return str
            }
        }
        
        return ""
    }
    
    func createAtrributeLable(Index:Int)->NSAttributedString{
      return  DashboardViewModel().setLableFirst(lbl1: Comment_Full_Name(Index: Index), lbl2: Comment_User_Name(Index: Index))
    }
    
    
    // replies content
    
    func Comment_RepliesCount(Index:Int)->Int{
        guard Index<arrComments.count else {
            arrReply.removeAll()
            return 0
        }
        if let arr = arrComments[Index]["replies"] as? [[String:Any]]{
            
           arrReply = arr
           return arrReply.count
            
            }
        arrReply.removeAll()
        return 0
    }
    
    func Comment_RepliesID(Index:Int)->String{
        guard Index<arrReply.count else {
            return ""
        }
         let dict = arrReply[Index]
            if let str = dict["id"]  as? String{
                return str
            }
            if let str = dict["id"]  as? Int{
                return String(str)
            }
        
        return ""
    }
    
    
    func Comment_RepliesBody(Index:Int)->String{
        guard Index<arrReply.count else {
            return ""
        }
        let dict = arrReply[Index]
        if let str = dict["body"]  as? String{
            return str
        }
      
        
        return ""
    }
    
    func Comment_RepliesSource_id(Index:Int)->String{
        guard Index<arrReply.count else {
            return ""
        }
        let dict = arrReply[Index]
        if let str = dict["source_id"]  as? String{
            return str
        }
        if let str = dict["source_id"]  as? Int{
            return String(str)
        }
        
        return ""
    }
    
    
    func Comment_RepliesSlug(Index:Int)->String{
        guard Index<arrReply.count else {
            return ""
        }
        let dict = arrReply[Index]
        if let str = dict["slug"]  as? String{
            return str
        }
        
        
        return ""
    }
    
    func Comment_RepliesUpvoted_by_current_user(Index:Int)->String{
        guard Index<arrReply.count else {
            return "false"
        }
        let dict = arrReply[Index]
        if let str = dict["upvoted_by_current_user"]  as? String{
            return str
        }
    if let str = dict["upvoted_by_current_user"]  as? Bool{
      return String(str)
    }
        
        return "false"
    }
    
    func Comment_RepliesDownvoted_by_current_user(Index:Int)->String{
        guard Index<arrReply.count else {
            return "false"
        }
        let dict = arrReply[Index]
        if let str = dict["downvoted_by_current_user"]  as? String{
            return str
        }
        if let str = dict["downvoted_by_current_user"]  as? Bool{
            return String(str)
        }
        
        return "false"
    }
    
    func Comment_RepliesUpvote_count(Index:Int)->String{
        guard Index<arrReply.count else {
            return ""
        }
        let dict = arrReply[Index]
        if let str = dict["upvote_count"]  as? String{
            return str
        }
        if let str = dict["upvote_count"]  as? Int{
            return String(str)
        }
        
        return ""
    }
    
    func Comment_RepliesDownvote_count(Index:Int)->String{
        guard Index<arrReply.count else {
            return ""
        }
        let dict = arrReply[Index]
        if let str = dict["downvote_count"]  as? String{
            return str
        }
        if let str = dict["downvote_count"]  as? Int{
            return String(str)
        }
        
        return ""
    }
    
    func Comment_RepliesReplies_count(Index:Int)->String{
        guard Index<arrReply.count else {
            return ""
        }
        let dict = arrReply[Index]
        if let str = dict["replies_count"]  as? String{
            return str
        }
        if let str = dict["replies_count"]  as? Int{
            return String(str)
        }
        
        return ""
    }
    
//    func RepliescreateAtrributeLable(Index:Int)->NSAttributedString{
//        return  DashboardViewModel().setLableFirst(lbl1: commen(Index: Index), lbl2: Comment_User_Name(Index: Index))
//    }
    
  //  MARK:- POST COMMENT
    
    func PostComment(parameter: [String:Any],vc:UIViewController ,completion:@escaping (Bool?)->()){
        
        print(parameter)
        let header = ["Accept":"application/json",
                      "Authorization":UserDefaults.standard.value(forKey: "Ktoken")as! String]
        
        postData(url: KMainUrl+KPostSendComments, parameter: parameter, header: header, vc: vc, showHud: "yes") { (DictResponce) in
            print(DictResponce)
            if let msg = DictResponce?.value(forKey: "message")as? String{
                if msg == "Comment created successfully!"{
                    
                    completion(true)
                }else{
                    completion(false)
                }
            }else{
                 completion(false)
            }
        }
    }
    
    
    
    
    //  MARK:- Upvote Comment
    func UpvotePost(Index:Int,vc:UIViewController, completion:@escaping (Bool?,String)->()){
        let header = ["Accept":"application/json",
                      "Authorization":UserDefaults.standard.value(forKey: "Ktoken")as! String]
        let Slug = getCommentSlug(Index: Index)
        
        let url = KMainUrl+"comments/"+Slug+KCommentUpvote
        print(url)
        postData(url: url, parameter: nil, header: header, vc: vc, showHud: "yes") { (DictResponce) in
            if let str = DictResponce?.value(forKey: "message")as? String{
                if str == "Success!" || str == "Comment Upvoted successfully!"{
                    
                    completion(true, str)
                }else{
                    completion(false, str)
                    
                }
            }else{
                completion(false, "Error!")
            }
        }
        
    }
    
   //   MARK:- Downvote Post
    
    func DownvotePost(Index:Int,vc:UIViewController, completion:@escaping (Bool?,String)->()){
        let header = ["Accept":"application/json",
                      "Authorization":UserDefaults.standard.value(forKey: "Ktoken")as! String]
        let Slug = getCommentSlug(Index: Index)
        
        let url = KMainUrl+"comments/"+Slug+KCommentDownvote
        print(url)
        postData(url: url, parameter: nil, header: header, vc: vc, showHud: "yes") { (DictResponce) in
            if let str = DictResponce?.value(forKey: "message")as? String{
                if str == "Success!" || str == "Comment Downvoted successfully!"{
                    
                    completion(true, str)
                }else{
                    completion(false, str)
                }
            }else{
                completion(false, "Error!")
            }
        }
    
    }
    
    
    
    
    //   MARK:- Reply_To_Comment
 
        
    func reply_To_Comment(txt:String,Index:Int,vc:UIViewController, completion:@escaping (Bool?,String)->()){
            let header = ["Accept":"application/json",
                          "Authorization":UserDefaults.standard.value(forKey: "Ktoken")as! String]
            let Slug = getCommentSlug(Index: Index)
                   // POST /comments/{slug}/comment-reply
            let url = KMainUrl+"comments/"+Slug+KCommentReply
            print(url)
        let param = ["slug":Slug,"body":txt]
        print(param)
            postData(url: url, parameter: param, header: header, vc: vc, showHud: "yes") { (DictResponce) in
                if let str = DictResponce?.value(forKey: "message")as? String{
                    if str == "Success!" || str == "Comment created successfully!"{
                        
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






