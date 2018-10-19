//
//  FanBuzzingScreenVC.swift
//  MyFan
//
//  Created by user on 15/10/18.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit

class FanBuzzingScreenVC: UIViewController {

    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var tblView: UITableView!
    var objComment2 = CommentViewModel()
    
    var selectedIndex = Int()
    override func viewDidLoad() {
        super.viewDidLoad()

        print(selectedIndex)
        tblView.delegate = self
        tblView.dataSource = self
        tblView.estimatedRowHeight = 100
        tblView.rowHeight = UITableViewAutomaticDimension
        
    }

    
//    @IBAction func btnMoreAction(_ sender: UIButton) {
//        print(sender.tag)
//        openActionSheet(Index: sender.tag)
//    }
    @IBAction func btnLikeCmntAction(_ sender: UIButton) {
//        objComment.UpvotePost(Index: sender.tag, vc: self) { (responce, msg) in
//
//        }
    }
    
    @IBAction func btnDislikeCmntAction(_ sender: UIButton) {
//        objComment.DownvotePost(Index: sender.tag, vc: self) { (responce, msg) in
//
//        }
    }
    @IBAction func btnReplyAction(_ sender: UIButton) {
        
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "CommentReplyScreenVC")as! CommentReplyScreenVC
            
            vc.selectedIndex = sender.tag
           vc.objComment3 = objComment2
            self.present(vc, animated: true, completion: {
             
            })
        
       
    }
    
   
    
    
    @IBAction func btnBackAction(_ sender: Any) {
         self.dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
// MARK:- Table view datasource and delagate

extension FanBuzzingScreenVC:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 1
        }else{
            return objComment2.Comment_RepliesCount(Index: selectedIndex)
        }
}
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{
            let cellCommnt = tblView.dequeueReusableCell(withIdentifier: "cellComment")as! CommentScreenTblCell
            
            cellCommnt.imgComent.kf.indicatorType = .activity
            cellCommnt.imgComent.kf.setImage(with: URL(string: objComment2.Comment_User_ProfilePic(Index: selectedIndex)))
           cellCommnt.lblname.attributedText = objComment2.createAtrributeLable(Index: selectedIndex)
            cellCommnt.lblComentBody.text = objComment2.getCommentBody(Index:selectedIndex)
            
            // like
            
            cellCommnt.lblLikeCmnt.text = objComment2.getCommentUpvoteCount(Index:selectedIndex)
            if objComment2.getCommentUpvoteBtCrrntUser(Index: selectedIndex) == "true"{
                cellCommnt.imgLikeCmnnt.image = UIImage(named: "redHearticonneww.png")
            }else{
                cellCommnt.imgLikeCmnnt.image = UIImage(named: "like.png")
            }
            
            
            // dislike
            cellCommnt.lblDisLikeCmnt.text = objComment2.getCommentDownvoteCount(Index: selectedIndex)
            if objComment2.getCommentDownvoteBtCrrntUser(Index: selectedIndex) == "true"{
                cellCommnt.imgDisLikeCmnnt.image = UIImage(named: "heartBroken.png")
            }else{
                cellCommnt.imgDisLikeCmnnt.image = UIImage(named: "dislike.png")
            }

             return cellCommnt
        }else{
            let cellCommntReply = tblView.dequeueReusableCell(withIdentifier: "cellCommentReply")as! CommentScreenTblCell
            
            cellCommntReply.imgComent.kf.indicatorType = .activity
            cellCommntReply.imgComent.kf.setImage(with: URL(string: objComment2.Comment_User_ProfilePic(Index: indexPath.row)))
            cellCommntReply.lblname.attributedText = objComment2.createAtrributeLable(Index: indexPath.row)
            cellCommntReply.lblComentBody.text = objComment2.Comment_RepliesBody(Index: indexPath.row)
            
                        // like
            
            cellCommntReply.lblLikeCmnt.text = objComment2.Comment_RepliesUpvote_count(Index: indexPath.row)
                if objComment2.Comment_RepliesUpvoted_by_current_user(Index: indexPath.row) == "true"{
                cellCommntReply.imgLikeCmnnt.image = UIImage(named: "redHearticonneww.png")
                }else{
                cellCommntReply.imgLikeCmnnt.image = UIImage(named: "like.png")
                }
            
            
                // dislike
            cellCommntReply.lblDisLikeCmnt.text = objComment2.Comment_RepliesDownvote_count(Index: indexPath.row)
            if objComment2.Comment_RepliesDownvoted_by_current_user(Index: indexPath.row) == "true"{
                   cellCommntReply.imgDisLikeCmnnt.image = UIImage(named: "heartBroken.png")
            }else{
                cellCommntReply.imgDisLikeCmnnt.image = UIImage(named: "dislike.png")
            }
            
            
            cellCommntReply.btnMore.tag = indexPath.row
            cellCommntReply.btnLike.tag = indexPath.row
            cellCommntReply.btnDisLike.tag = indexPath.row
           // cellCommntReply.btnBuzzing.tag = indexPath.row
            
             return cellCommntReply
        }
        
}
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableViewAutomaticDimension
        
}
}
