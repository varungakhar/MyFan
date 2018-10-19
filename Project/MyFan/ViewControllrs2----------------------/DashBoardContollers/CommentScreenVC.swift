//
//  CommentScreenVC.swift
//  MyFan
//
//  Created by user on 12/10/18.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit

class CommentScreenVC: UIViewController {

    @IBOutlet weak var txtViewComment: UITextView!
    @IBOutlet weak var viewCommentMain: UIView!
    @IBOutlet weak var tblView: UITableView!
    var objDashboard2 = DashboardViewModel()
    
    let objComment = CommentViewModel()
    var selectedIndex = Int()
    let mf = MediaFetcher()
    var selectedBtnIndex = Int()
    override func viewDidLoad() {
        super.viewDidLoad()
        viewCommentMain.frame = CGRect(x: 0, y: 0, width: viewCommentMain.frame.size.width, height: 0)
        viewCommentMain.isHidden = true
        tblView.delegate = self
        tblView.dataSource = self
        tblView.estimatedRowHeight = 150
        tblView.rowHeight = UITableViewAutomaticDimension
       
        txtViewComment.delegate = self
        txtViewComment.text = "Share your Comment"
        txtViewComment.textColor = UIColor.lightGray
      
    }
    override func viewWillAppear(_ animated: Bool) {
          GetComments(refresh: false)
    }
    func GetComments(refresh:Bool){
        let postid = objDashboard2.GetPostID(Index: selectedIndex)
        print(postid)
        objComment.GetCommentsOnPost(postID: postid, Refresh: refresh, vc: self) { (responce, msg) in
            self.tblView.reloadData()
        }
    }
    
    @IBAction func btnMoreAction(_ sender: UIButton) {
        print(sender.tag)
        openActionSheet(Index: sender.tag)
    }
    @IBAction func btnLikeCmntAction(_ sender: UIButton) {
        objComment.UpvotePost(Index: sender.tag, vc: self) { (responce, msg) in
            
        }
    }
    
    @IBAction func btnDislikeCmntAction(_ sender: UIButton) {
        objComment.DownvotePost(Index: sender.tag, vc: self) { (responce, msg) in
            
        }
    }
    
    @IBAction func btnBuzzingAction(_ sender: UIButton) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "FanBuzzingScreenVC")as! FanBuzzingScreenVC
        vc.objComment2 = objComment
        vc.selectedIndex = sender.tag
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func btnBackAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnPostAction(_ sender: UIButton) {
        if viewCommentMain.frame.size.height == 0{
          viewCommentMain.frame = CGRect(x: 0, y: 0, width: viewCommentMain.frame.size.width, height: 125)
            viewCommentMain.isHidden = false
         //   txtViewComment.becomeFirstResponder()
            
        }else{
           viewCommentMain.frame = CGRect(x: 0, y: 0, width: viewCommentMain.frame.size.width, height: 0)
            viewCommentMain.isHidden = true
            txtViewComment.resignFirstResponder()
        }
        tblView.reloadData()
    }
    
    @IBAction func btnShareAction(_ sender: UIButton) {
        
        if txtViewComment.text == "Share your Comment"{
            Utility().displayAlert(title: "Please add a comment", message: "", control: ["ok"])
        }else{
            let postSlug = objDashboard2.PostSlug(Index: selectedIndex)
            print(postSlug)
            let param = ["post_slug":postSlug,"body":txtViewComment.text!]
            objComment.PostComment(parameter: param, vc: self) { (responce) in
                if responce!{
                    
                }else{
                   Utility().displayAlert(title: "Comment can't be added right now", message: "", control: ["ok"])
                }
                self.GetComments(refresh: true)
            }
        }
    }
    
    @IBAction func btnHeaderActions(_ sender: UIButton) {
//        tblView.scrollsToTop = true
//
//        selectedBtnIndex = sender.tag
//        getData(tab: sender.tag, refresh: false)
//
//        tblView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
extension CommentScreenVC{
    func openActionSheet(Index:Int){
        
        let alert = UIAlertController(title: "Choose an action", message: "", preferredStyle: .actionSheet)
        
        
        // fav
        let fav = UIAlertAction(title: "Fave", style: .default) { (UIAlertAction) in
            
        }
        if let icon = UIImage(named: "MyfavesIconNew.png")?.imageWithSize(scaledToSize: CGSize(width: 32, height: 32)){
            fav.setValue(icon, forKey: "image")
        }
        
        // Share
        let Share = UIAlertAction(title: "Share", style: .default) { (UIAlertAction) in
            
        }
        if let icon = UIImage(named: "ShareIcon.png")?.imageWithSize(scaledToSize: CGSize(width: 32, height: 32)){
            Share.setValue(icon, forKey: "image")
        }
        
        
        // copy text
        let copy = UIAlertAction(title: "Copy Text", style: .default) { (UIAlertAction) in
            
        }
        if let icon = UIImage(named: "copy_text.png")?.imageWithSize(scaledToSize: CGSize(width: 32, height: 32)){
            copy.setValue(icon, forKey: "image")
        }
        
        
        // Report
        let Report = UIAlertAction(title: "Report", style: .default) { (UIAlertAction) in
            
        }
        
        if let icon = UIImage(named: "flag.png")?.imageWithSize(scaledToSize: CGSize(width: 32, height: 32)){
            Report.setValue(icon, forKey: "image")
            
        }
        
        // delete
        let delete = UIAlertAction(title: "Delete", style: .destructive) { (UIAlertAction) in
            
        }
        if let icon = UIImage(named: "delete-button.png")?.imageWithSize(scaledToSize: CGSize(width: 32, height: 32)){
            delete.setValue(icon, forKey: "image")
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (UIAlertAction) in
            
        }
        
        alert.addAction(fav)
        alert.addAction(Share)
        alert.addAction(copy)
        alert.addAction(Report)
        alert.addAction(delete)
        alert.addAction(cancel)
        
        self.present(alert, animated: true, completion: {
            print("completion block")
        })
    }
}

extension CommentScreenVC:UITextViewDelegate{
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        if txtViewComment.textColor == UIColor.lightGray {
            txtViewComment.text = ""
            txtViewComment.textColor = UIColor.black
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        
        if txtViewComment.text == "" {
            
            txtViewComment.text = "Share your Comment"
            txtViewComment.textColor = UIColor.lightGray
        }
    }
    
}
// MARK:- Table view datasource and delagate

extension CommentScreenVC:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 1
        }else{
            return objComment.CommentsCount()
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        
         if indexPath.section == 0{
            var cell = DashboardTableViewCell()
            
            guard let arrPost = objDashboard2.typeOfPost(Index: selectedIndex) else{
                return cell
            }
            
            print(arrPost)
            if arrPost.count == 0{
                cell = tblView.dequeueReusableCell(withIdentifier: "cellid1")as! DashboardTableViewCell
                cell.viewMediaContentHeight.constant = 0.0
                cell.layoutIfNeeded()
                cell.imgPlay1Cell1.isHidden = true
                cell.img1Cell1.image = nil
            }
            else if arrPost.count == 1{
                cell = tblView.dequeueReusableCell(withIdentifier: "cellid1")as! DashboardTableViewCell
                cell.viewMediaContentHeight.constant = 210.0
                cell.layoutIfNeeded()
                let dict = arrPost[0]
                if let str = dict["attachment_url"]as? String{
                    cell.img1Cell1.kf.indicatorType = .activity
                    
                    if str.contains(".mp4"){
                        // video
                        if let strThmbImg = dict["video_thumb_url"]as? String{
                            cell.img1Cell1.kf.setImage(with: URL(string: strThmbImg))
                            cell.imgPlay1Cell1.isHidden = false
                            
                        }
                    }else if str.contains(".m4a"){
                        // audio
                        if let strThmbImg = dict["audio_thumb_url"]as? String{
                            cell.img1Cell1.kf.setImage(with: URL(string: strThmbImg))
                            cell.imgPlay1Cell1.isHidden = false
                        }
                    }else if str.contains(".jpg") || str.contains(".jpeg") || str.contains(".png"){
                        // image
                        cell.img1Cell1.kf.setImage(with: URL(string: str))
                        cell.imgPlay1Cell1.isHidden = true
                        
                    }else if str.contains(".gif"){
                        cell.img1Cell1.image = nil
                        mf.downloadGifFile(URL(string: str)!) { (imgUrl) in
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                cell.img1Cell1.kf.setImage(with: imgUrl)
                                
                            }
                            
                        }
                        //                                let imgGif = UIImage.gifImageWithURL(str)
                        //                                cell.img1Cell1.image = imgGif
                        
                        //                                if let url = URL(string: str){
                        //                                if let data = try? Data(contentsOf: url){
                        //                                   cell.img1Cell1.image = UIImage(data: data)
                        //                                  }
                        //                                }
                        cell.imgPlay1Cell1.isHidden = true
                        
                    }
                }
                
                
            }else if arrPost.count == 2{
                cell = tblView.dequeueReusableCell(withIdentifier: "cellid2")as! DashboardTableViewCell
                
                for i in 0..<arrPost.count {
                    let dict = arrPost[i]
                    if let str = dict["attachment_url"]as? String{
                        cell.imgsCell2[i].kf.indicatorType = .activity
                        
                        if str.contains(".mp4"){
                            // video
                            if let strThmbImg = dict["video_thumb_url"]as? String{
                                cell.imgsCell2[i].kf.setImage(with: URL(string: strThmbImg))
                                cell.imsPlayCell2[i].isHidden = false
                            }
                        }else if str.contains(".m4a"){
                            // audio
                            if let strThmbImg = dict["audio_thumb_url"]as? String{
                                cell.imgsCell2[i].kf.setImage(with: URL(string: strThmbImg))
                                cell.imsPlayCell2[i].isHidden = false
                            }
                        }else if str.contains(".jpg") || str.contains(".jpeg") || str.contains(".png"){
                            // image
                            cell.imgsCell2[i].kf.setImage(with: URL(string: str))
                            cell.imsPlayCell2[i].isHidden = true
                            
                        }else if str.contains(".gif"){
                            cell.imgsCell2[i].image = nil
                            mf.downloadGifFile(URL(string: str)!) { (imgUrl) in
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                    cell.imgsCell2[i].kf.setImage(with: imgUrl)
                                }
                                
                            }
                            //                                let imgGif = UIImage.gifImageWithURL(str)
                            //                                cell.imgsCell2[i].image = imgGif
                            cell.imsPlayCell2[i].isHidden = true
                            
                        }
                    }
                }
                
            }else if arrPost.count == 3{
                cell = tblView.dequeueReusableCell(withIdentifier: "cellid3")as! DashboardTableViewCell
                
                for i in 0..<arrPost.count {
                    let dict = arrPost[i]
                    if let str = dict["attachment_url"]as? String{
                        cell.imgsCell3[i].kf.indicatorType = .activity
                        
                        if str.contains(".mp4"){
                            // video
                            if let strThmbImg = dict["video_thumb_url"]as? String{
                                cell.imgsCell3[i].kf.setImage(with: URL(string: strThmbImg))
                                cell.imsPlayCell3[i].isHidden = false
                            }
                        }else if str.contains(".m4a"){
                            // audio
                            if let strThmbImg = dict["audio_thumb_url"]as? String{
                                cell.imgsCell3[i].kf.setImage(with: URL(string: strThmbImg))
                                cell.imsPlayCell3[i].isHidden = false
                            }
                        }else if str.contains(".jpg") || str.contains(".jpeg") || str.contains(".png"){
                            // image
                            cell.imgsCell3[i].kf.setImage(with: URL(string: str))
                            cell.imsPlayCell3[i].isHidden = true
                            
                        }else if str.contains(".gif"){
                            cell.imgsCell3[i].image = nil
                            mf.downloadGifFile(URL(string: str)!) { (imgUrl) in
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                    cell.imgsCell3[i].kf.setImage(with: imgUrl)
                                }
                                
                            }
                            //                                let imgGif = UIImage.gifImageWithURL(str)
                            //                                cell.imgsCell3[i].image = imgGif
                            cell.imsPlayCell3[i].isHidden = true
                            
                        }
                    }
                }
                
            }else if arrPost.count == 4{
                cell = tblView.dequeueReusableCell(withIdentifier: "cellid4")as! DashboardTableViewCell
                
                for i in 0..<arrPost.count {
                    let dict = arrPost[i]
                    if let str = dict["attachment_url"]as? String{
                        cell.imgsCell4[i].kf.indicatorType = .activity
                        
                        if str.contains(".mp4"){
                            // video
                            if let strThmbImg = dict["video_thumb_url"]as? String{
                                cell.imgsCell4[i].kf.setImage(with: URL(string: strThmbImg))
                                cell.imsPlayCell4[i].isHidden = false
                            }
                        }else if str.contains(".m4a"){
                            // audio
                            if let strThmbImg = dict["audio_thumb_url"]as? String{
                                cell.imgsCell4[i].kf.setImage(with: URL(string: strThmbImg))
                                cell.imsPlayCell4[i].isHidden = false
                            }
                        }else if str.contains(".jpg") || str.contains(".jpeg") || str.contains(".png"){
                            // image
                            cell.imgsCell4[i].kf.setImage(with: URL(string: str))
                            cell.imsPlayCell4[i].isHidden = true
                            
                        }else if str.contains(".gif"){
                            cell.imgsCell4[i].image = nil
                            mf.downloadGifFile(URL(string: str)!) { (imgUrl) in
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                    cell.imgsCell4[i].kf.setImage(with: imgUrl)
                                }
                                
                            }
                            //                                let imgGif = UIImage.gifImageWithURL(str)
                            //                                cell.imgsCell4[i].image = imgGif
                            cell.imsPlayCell4[i].isHidden = true
                            
                        }
                    }
                }
                
            }else  {
                cell = tblView.dequeueReusableCell(withIdentifier: "cellid5")as! DashboardTableViewCell
                cell.lblMoreCell5.isHidden = true
                
                print(arrPost.count)
                for i in 0..<5 {
                    let dict = arrPost[i]
                    if let str = dict["attachment_url"]as? String{
                        cell.imgsCell5[i].kf.indicatorType = .activity
                        
                        if str.contains(".mp4"){
                            // video
                            if let strThmbImg = dict["video_thumb_url"]as? String{
                                cell.imgsCell5[i].kf.setImage(with: URL(string: strThmbImg))
                                cell.imsPlayCell5[i].isHidden = false
                            }
                        }else if str.contains(".m4a"){
                            // audio
                            if let strThmbImg = dict["audio_thumb_url"]as? String{
                                cell.imgsCell5[i].kf.setImage(with: URL(string: strThmbImg))
                                cell.imsPlayCell5[i].isHidden = false
                            }
                        }else if str.contains(".jpg") || str.contains(".jpeg") || str.contains(".png"){
                            // image
                            cell.imgsCell5[i].kf.setImage(with: URL(string: str))
                            cell.imsPlayCell5[i].isHidden = true
                            
                        }else if str.contains(".gif"){
                            cell.imgsCell5[i].image = nil
                            mf.downloadGifFile(URL(string: str)!) { (imgUrl) in
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                    
                                    cell.imgsCell5[i].kf.setImage(with: imgUrl)
                                    //                                          cell.imgsCell5[i].kf.setImage(with: imgUrl, placeholder: cell.imgsCell5[i].image, options: nil, progressBlock: nil, completionHandler: nil)
                                }
                                
                            }
                            //                                let imgGif = UIImage.gifImageWithURL(str)
                            //                                cell.imgsCell5[i].image  = imgGif
                            cell.imsPlayCell5[i].isHidden = true
                            
                        }
                    }
                }
                if arrPost.count > 5{
                    cell.lblMoreCell5.text = "+\(arrPost.count-5) More"
                    cell.lblMoreCell5.isHidden = false
                }
                
            }
            //                else{
            //                       cell = tblView.dequeueReusableCell(withIdentifier: "cellid5")as! DashboardTableViewCell
            //                    cell.lblMoreCell5.text = "+\(arrPost.count-5) More"
            //                    cell.lblMoreCell5.isHidden = true
            //                }
            
            cell.imgUserDashBoard.kf.indicatorType = .activity
            cell.imgUserDashBoard.kf.setImage(with: URL(string: objDashboard2.UserProfilePic(Index: selectedIndex)))
            
            cell.lbl1DashBoard.attributedText = objDashboard2.setLableFirst(lbl1: objDashboard2.UserfullName(Index: selectedIndex), lbl2: objDashboard2.UserUser_name(Index: selectedIndex)+" · "+"2d")
            
            cell.lbl2DashBoard.text = objDashboard2.userVisibility(Index: selectedIndex)+" · "+objDashboard2.viewsCount(Index: selectedIndex) + "Views"
            
            cell.lblDiscriptionDashBoard.text = objDashboard2.PostBody(Index: selectedIndex)
            
            cell.lblHashTagOnlyForShow.text = objDashboard2.HashTagTopicsOnlyForShow(Index: selectedIndex)
            cell.lblHashTagDashBoard.text = objDashboard2.HashTagTopics(Index: selectedIndex)
            print(objDashboard2.HashTagTopics(Index: selectedIndex))
            cell.lblHashTagDashBoard.handleHashtagTap { (hashtag) in
                print(hashtag)
                print(self.objDashboard2.HashTagTopics(Index: self.selectedIndex))
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "TagHashViewController")as! TagHashViewController
                vc.strHashTag = hashtag
                self.present(vc, animated: true, completion: nil)
            }
            
          
            
            return cell
         }else{
             let cellCommnt = tblView.dequeueReusableCell(withIdentifier: "cellComment")as! CommentScreenTblCell
            
            cellCommnt.imgComent.kf.indicatorType = .activity
           cellCommnt.imgComent.kf.setImage(with: URL(string: objComment.Comment_User_ProfilePic(Index: indexPath.row)))
            cellCommnt.lblname.attributedText = objComment.createAtrributeLable(Index: indexPath.row)
             cellCommnt.lblComentBody.text = objComment.getCommentBody(Index: indexPath.row)
            
            // like
   
            cellCommnt.lblLikeCmnt.text = objComment.getCommentUpvoteCount(Index: indexPath.row)
            if objComment.getCommentUpvoteBtCrrntUser(Index: indexPath.row) == "true"{
             cellCommnt.imgLikeCmnnt.image = UIImage(named: "redHearticonneww.png")
            }else{
              cellCommnt.imgLikeCmnnt.image = UIImage(named: "like.png")
            }
        
            
             // dislike
            cellCommnt.lblDisLikeCmnt.text = objComment.getCommentDownvoteCount(Index: indexPath.row)
            if objComment.getCommentDownvoteBtCrrntUser(Index: indexPath.row) == "true"{
                cellCommnt.imgDisLikeCmnnt.image = UIImage(named: "heartBroken.png")
            }else{
                cellCommnt.imgDisLikeCmnnt.image = UIImage(named: "dislike.png")
            }
print(objLoginData.id!)
            if objLoginData.id! == objComment.Comment_User_ID(Index: indexPath.row){
               cellCommnt.lblBuzzingCount.isHidden = true
                cellCommnt.btnBuzzing.isHidden = true
            }else{
              cellCommnt.btnBuzzing.isHidden = false
                cellCommnt.lblBuzzingCount.text = "  "+String(objComment.Comment_RepliesCount(Index: indexPath.row))+" Buzzing  "
            }
            
            cellCommnt.btnMore.tag = indexPath.row
            cellCommnt.btnLike.tag = indexPath.row
            cellCommnt.btnDisLike.tag = indexPath.row
            cellCommnt.btnBuzzing.tag = indexPath.row
            return cellCommnt
            }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tblView.dequeueReusableCell(withIdentifier: "cellidHeader")as! DashboardTableViewCell
        if  selectedBtnIndex == 1{
            cell.imgTrending.image = UIImage(named:"trending_blue.png")
            
            cell.imgRecent.image = UIImage(named:"recent.png")
            cell.imgSpotLight.image = UIImage(named:"spotlight.png")
            cell.imgPopular.image = UIImage(named:"popular.png")
            
        }else if  selectedBtnIndex == 2{
            cell.imgRecent.image = UIImage(named:"recent_blue.png")
            
            cell.imgTrending.image = UIImage(named:"trending.png")
            cell.imgSpotLight.image = UIImage(named:"spotlight.png")
            cell.imgPopular.image = UIImage(named:"popular.png")
        }else if  selectedBtnIndex == 3{
            cell.imgSpotLight.image = UIImage(named:"spotlight_blue.png")
            
            cell.imgTrending.image = UIImage(named:"trending.png")
            cell.imgRecent.image = UIImage(named:"recent.png")
            cell.imgPopular.image = UIImage(named:"popular.png")
        }else if  selectedBtnIndex == 4{
            cell.imgPopular.image = UIImage(named:"popular_blue.png")
            
            cell.imgTrending.image = UIImage(named:"trending.png")
            cell.imgRecent.image = UIImage(named:"recent.png")
            cell.imgSpotLight.image = UIImage(named:"spotlight.png")
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0{
            return 0
        }else{
            return 50
            
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
            return UITableViewAutomaticDimension
        
    }
    
    
}


// MARK:- table view cell

class CommentScreenTblCell:UITableViewCell{
  //  cellComment
    
    @IBOutlet weak var imgComent: ImageCustom!
    @IBOutlet weak var lblname: UILabel!
    @IBOutlet weak var lblComentBody: UILabel!
    @IBOutlet weak var btnMore: UIButton!
    // like
    @IBOutlet weak var imgLikeCmnnt: UIImageView!
    @IBOutlet weak var lblLikeCmnt: UILabel!
   @IBOutlet weak var btnLike: UIButton!
     // Dislike
     @IBOutlet weak var imgDisLikeCmnnt: UIImageView!
    @IBOutlet weak var lblDisLikeCmnt: UILabel!
    @IBOutlet weak var btnDisLike: UIButton!
    
    @IBOutlet weak var lblBuzzingCount: LabelCustom!
    
    @IBOutlet weak var btnBuzzing: UIButton!
}





