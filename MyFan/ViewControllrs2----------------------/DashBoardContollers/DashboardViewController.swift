//
//  DashboardViewController.swift
//  MyFan
//
//  Created by user on 31/08/18.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit
import Kingfisher

class DashboardViewController: UIViewController {
    
    @IBOutlet weak var viewSIdeMenu: UIView!
    @IBOutlet weak var imgUser: UIImageView!
    
    @IBOutlet weak var lblUserName1: UILabel!
    
    @IBOutlet weak var lblUserName2: UILabel!
    @IBOutlet weak var tblView: UITableView!
    
    @IBOutlet weak var sideViewLeadingCons: NSLayoutConstraint!
    @IBOutlet weak var tblViewDashBoard: UITableView!
    @IBOutlet weak var clcViewSelectedCatgry: UICollectionView!
    @IBOutlet weak var txtSearch: UITextField!
    
    @IBOutlet weak var viewTabBarBottom: UIView!
    
    @IBOutlet weak var btnTab1: UIButton!
    @IBOutlet weak var btnTab2: UIButton!
    @IBOutlet weak var btnTab3: UIButton!
    @IBOutlet weak var btnTab4: UIButton!
    @IBOutlet weak var btnTab5: UIButton!
    let mf = MediaFetcher()
    var selectedBtnIndex = 1
    var isLoading = false
    var sideMenuIsHidden = true
    var spinner = UIActivityIndicatorView()
    let objDashboard = DashboardViewModel()
    var arrPageCount = [1,1,1,1,1]
    var lblFooter = UILabel()

    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
            #selector(DashboardViewController.handleRefresh(_:)),
                                 for: UIControlEvents.valueChanged)
       
        refreshControl.tintColor = systemcolor
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        return refreshControl
    }()
    let arrTitle = ["","Connection","Messenger","My Funds","My Buzz","My Schedular","My Reviews","My Photos","My Videos","My Music","My Faves","Settings",""]
    let arrImgs = ["","connections.png","messanger.png","my_fundsIcon.png","buzz_feed.png","schduler.png","reviews.png","camera.png","video.png","music.png","MyfavesIconNew.png","settings.png",""]
    override func viewDidLoad() {
        super.viewDidLoad()

       self.navigationController?.isNavigationBarHidden = true
     txtSearch.delegate = self
        tblView.delegate = self
        tblView.dataSource = self
        
        tblViewDashBoard.delegate = self
        tblViewDashBoard.dataSource = self
        tblViewDashBoard.estimatedRowHeight = 150
        tblViewDashBoard.rowHeight = UITableViewAutomaticDimension
        
        self.tblViewDashBoard.addSubview(self.refreshControl)
        
        clcViewSelectedCatgry.delegate = self
        clcViewSelectedCatgry.dataSource = self
        

        self.sideViewLeadingCons.constant = -307
        self.view.layoutIfNeeded()
     
        lblFooter.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 50)
        GetLoginData()
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
         getData(tab: selectedBtnIndex, refresh: true)
        arrPageCount[selectedBtnIndex] = 1
    }
    @IBAction func btnSideMenu(_ sender: Any) {
    sidemenu()
    }
    func sidemenu(){
        UIView.animate(withDuration: 0.25, delay: 0.0, options: [], animations: {
            if self.sideMenuIsHidden {
              self.sideViewLeadingCons.constant = 0
                self.view.layoutIfNeeded()
            }else{
              self.sideViewLeadingCons.constant = -307
                self.view.layoutIfNeeded()
            }
            
        }, completion: { (finished: Bool) in
            if self.sideMenuIsHidden {
                self.sideMenuIsHidden = false
            }else{
                self.sideMenuIsHidden = true
            }
        })
    }
    
      // MARK:- Api Handling
    func GetLoginData(){
        
        if objLoginData.id == nil{
            objDashboard.GetLoginData( vc: self) { (responce) in
                if responce!{
                    self.imgUser.kf.indicatorType = .activity
                    self.imgUser.kf.setImage(with: URL(string: objLoginData.profile_image_url!))
                    self.lblUserName1.text = objLoginData.full_name!
                     self.lblUserName2.text = "@"+objLoginData.user_name!
                    
                    
                    self.clcViewSelectedCatgry.reloadData()
                    self.getData(tab:1, refresh: false)
                }else{
                    self.clcViewSelectedCatgry.reloadData()
                }
            }
        }else{
            self.imgUser.kf.indicatorType = .activity
            self.imgUser.kf.setImage(with: URL(string: objLoginData.profile_image_url!))
            self.lblUserName1.text = objLoginData.full_name!
            self.lblUserName2.text = "@"+objLoginData.user_name!
            getData(tab:1, refresh: false)
        }

    }
    
    
    func getData(tab:Int,refresh:Bool){
        objDashboard.GetPostFeedData(tab: tab, Refresh: refresh, vc: self) { (responce,str)  in
            self.tblViewDashBoard.reloadData()
            self.isLoading = false
            
            self.refreshControl.endRefreshing()
            self.spinner.stopAnimating()
//            if str != "No more Posts"{
//            self.tblViewDashBoard.tableFooterView?.isHidden = true
//            }else{
              self.tblViewDashBoard.tableFooterView?.isHidden = true
            //}
        }
    }
    
    @IBAction func btnRefreshAction(_ sender: Any) {
    }
    
    @IBAction func btnSearchRytSide(_ sender: UIButton) {
      
    }
    
    @IBAction func btnHeaderActions(_ sender: UIButton) {
        tblViewDashBoard.scrollsToTop = true

        selectedBtnIndex = sender.tag
        getData(tab: sender.tag, refresh: false)
      
         tblViewDashBoard.reloadData()
    }
    @IBAction func btnLikeCell(_ sender: UIButton) {
        print(sender.tag)
//        guard objDashboard.CheakUpvoteLocaly(Index: sender.tag) != "1" else {
//            return
//        }
//        guard objDashboard.upVotedByCurntUser(Index: sender.tag) != "true" else {
//            return
//        }
        
        objDashboard.UpvotePost(Index: sender.tag, vc: self) { (responce, msg) in
            if responce!{
                self.tblViewDashBoard.reloadData()
            }else{
                Utility().displayAlert(title: msg, message: "", control: ["ok"])
            }
        }
        
    }
    @IBAction func btnDisLikeCell(_ sender: UIButton) {
        print(sender.tag)
    
        objDashboard.DownvotePost( Index: sender.tag, vc: self) { (responce, msg) in
            if responce!{
                self.tblViewDashBoard.reloadData()
            }else{
                Utility().displayAlert(title: msg, message: "", control: ["ok"])
            }
        }
       
    }
    @IBAction func btnCommentCell(_ sender: UIButton) {
        print(sender.tag)
      
    }
    @IBAction func btnShareCell(_ sender: UIButton) {
        print(sender.tag)
       
    }
    
    @IBAction func btnTabActions(_ sender: UIButton) {
        if sender.tag == 1{
            // home
         //   btnTab1.setImage(<#T##image: UIImage?##UIImage?#>, for: .normal)
        }else if sender.tag == 2{
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "PostNewCreateVC")as! PostNewCreateVC
            self.navigationController?.pushViewController(vc, animated: false)
        }else if sender.tag == 3{
            
        }else if sender.tag == 4{
            //notification
        }else if sender.tag == 5{
           // profile
        }
    }
    
    @IBAction func btnSignOutAction(_ sender: Any) {
        UserDefaults.standard.removeObject(forKey: "Ktoken")
         UserDefaults.standard.removeObject(forKey: "KisLogin")
        Utility().pushViewControl(ViewControl: "MainViewController")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
extension DashboardViewController:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            if tableView == tblView{
            return arrTitle.count
            }else{
                return objDashboard.postsCount()
            }
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
             if tableView == tblView{
            if indexPath.row == 0
            {
                 let cell = tblView.dequeueReusableCell(withIdentifier: "cellid1")!
                
                return cell
            }else if indexPath.row < arrTitle.count-1{
                
                let cell = tblView.dequeueReusableCell(withIdentifier: "cellid2")as! CommonTblCell
                cell.lblSettings.text = arrTitle[indexPath.row]
                cell.imgSettings.image = UIImage(named: arrImgs[indexPath.row])
                return cell
            }else{
                let cell = tblView.dequeueReusableCell(withIdentifier: "cellid3")as! CommonTblCell
                return cell
            }
             }else{
                var cell = DashboardTableViewCell()

               guard let arrPost = objDashboard.typeOfPost(Index: indexPath.row) else{
                    return cell
                }
                
                print(arrPost)
                if arrPost.count == 0{
                 cell = tblViewDashBoard.dequeueReusableCell(withIdentifier: "cellid1")as! DashboardTableViewCell
                    cell.viewMediaContentHeight.constant = 0.0
                    cell.layoutIfNeeded()
                     cell.imgPlay1Cell1.isHidden = true
                     cell.img1Cell1.image = nil
                }
                else if arrPost.count == 1{
                cell = tblViewDashBoard.dequeueReusableCell(withIdentifier: "cellid1")as! DashboardTableViewCell
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
                             //   cell.img1Cell1.image = nil
//                                mf.downloadGifFile(URL(string: str)!) { (imgUrl) in
//                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
//                                         cell.img1Cell1.kf.setImage(with: imgUrl)
//
//                                    }
//
//                                }
                                let imgGif = UIImage.gifImageWithURL(str)
                                cell.img1Cell1.image = imgGif
                                
                                
                                cell.imgPlay1Cell1.isHidden = true
                                
                            }
                        }
                   
                    
                }else if arrPost.count == 2{
                   cell = tblViewDashBoard.dequeueReusableCell(withIdentifier: "cellid2")as! DashboardTableViewCell
                    
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
//                                cell.imgsCell2[i].image = nil
//                                mf.downloadGifFile(URL(string: str)!) { (imgUrl) in
//                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
//                                        cell.imgsCell2[i].kf.setImage(with: imgUrl)
//                                    }
//
//                                }
                                let imgGif = UIImage.gifImageWithURL(str)
                                cell.imgsCell2[i].image = imgGif
                                cell.imsPlayCell2[i].isHidden = true
                                
                            }
                        }
                    }
                    
                }else if arrPost.count == 3{
                   cell = tblViewDashBoard.dequeueReusableCell(withIdentifier: "cellid3")as! DashboardTableViewCell
                   
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
//                                cell.imgsCell3[i].image = nil
//                                mf.downloadGifFile(URL(string: str)!) { (imgUrl) in
//                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
//                                        cell.imgsCell3[i].kf.setImage(with: imgUrl)
//                                    }
//
//                                }
                                let imgGif = UIImage.gifImageWithURL(str)
                                cell.imgsCell3[i].image = imgGif
                                cell.imsPlayCell3[i].isHidden = true
                                
                            }
                        }
                    }

                }else if arrPost.count == 4{
                   cell = tblViewDashBoard.dequeueReusableCell(withIdentifier: "cellid4")as! DashboardTableViewCell
                 
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
//                                 cell.imgsCell4[i].image = nil
//                                mf.downloadGifFile(URL(string: str)!) { (imgUrl) in
//                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
//                                        cell.imgsCell4[i].kf.setImage(with: imgUrl)
//                                    }
//
//                                }
                                let imgGif = UIImage.gifImageWithURL(str)
                                cell.imgsCell4[i].image = imgGif
                                cell.imsPlayCell4[i].isHidden = true
                                
                            }
                        }
                    }

                }else  {
                    cell = tblViewDashBoard.dequeueReusableCell(withIdentifier: "cellid5")as! DashboardTableViewCell
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
//                                 cell.imgsCell5[i].image = nil
//                                mf.downloadGifFile(URL(string: str)!) { (imgUrl) in
//                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
//
//                                        cell.imgsCell5[i].kf.setImage(with: imgUrl)
////                                          cell.imgsCell5[i].kf.setImage(with: imgUrl, placeholder: cell.imgsCell5[i].image, options: nil, progressBlock: nil, completionHandler: nil)
//                                    }
//
//                                }
                                let imgGif = UIImage.gifImageWithURL(str)
                                cell.imgsCell5[i].image  = imgGif
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
//                       cell = tblViewDashBoard.dequeueReusableCell(withIdentifier: "cellid5")as! DashboardTableViewCell
//                    cell.lblMoreCell5.text = "+\(arrPost.count-5) More"
//                    cell.lblMoreCell5.isHidden = true
//                }
 
                cell.imgUserDashBoard.kf.indicatorType = .activity
                cell.imgUserDashBoard.kf.setImage(with: URL(string: objDashboard.UserProfilePic(Index: indexPath.row)))
                
                cell.lbl1DashBoard.attributedText = objDashboard.setLableFirst(lbl1: objDashboard.UserfullName(Index: indexPath.row), lbl2: objDashboard.UserUser_name(Index: indexPath.row)+" · "+"2d")
                
                cell.lbl2DashBoard.text = objDashboard.userVisibility(Index: indexPath.row)+" · "+objDashboard.viewsCount(Index: indexPath.row) + "Views"
                
                cell.lblDiscriptionDashBoard.text = objDashboard.PostBody(Index: indexPath.row)
                
                 cell.lblHashTagOnlyForShow.text = objDashboard.HashTagTopicsOnlyForShow(Index: indexPath.row)
                 cell.lblHashTagDashBoard.text = objDashboard.HashTagTopics(Index: indexPath.row)
                print(objDashboard.HashTagTopics(Index: indexPath.row))
                 cell.lblHashTagDashBoard.handleHashtagTap { (hashtag) in
                    print(hashtag)
                    print(self.objDashboard.HashTagTopics(Index: indexPath.row))
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "TagHashViewController")as! TagHashViewController
                    vc.strHashTag = hashtag
                    self.present(vc, animated: true, completion: nil)
                }
                
                if   objDashboard.CheakUpvoteDownvoteLocaly(Index: indexPath.row) != "1"{
                
                if objDashboard.upVotedByCurntUser(Index: indexPath.row) == "true"{
                    cell.imgLike.image = UIImage(named: "redHearticonneww.png")
                    cell.btnLike.isHidden = true
                }else{
                    cell.imgLike.image = UIImage(named: "like.png")
                     cell.btnLike.isHidden = false
                }
                
                if objDashboard.downVotedByCurntUser(Index: indexPath.row) == "true"{
                    cell.imgDislike.image = UIImage(named: "heartBroken.png")
                    cell.btDislike.isHidden = true
                }else{
                    cell.imgDislike.image = UIImage(named: "dislike.png")
                    cell.btDislike.isHidden = false
                }
                    cell.lblLike.text = objDashboard.upVotedCount(Index: indexPath.row, pluse: 0)
                cell.lblDislike.text = objDashboard.downVotedCount(Index: indexPath.row, pluse: 0)
                }else{
                let str = objDashboard.GetLocalStatusUpvoteOrDOwnVote(Index: indexPath.row)
                    print(str)
                    if str == "LocalLike"{
                        if cell.imgDislike.image == UIImage(named: "heartBroken.png"){
                            // selected dislike

                            if let cnt = Int(cell.lblLike.text!){
                                cell.lblLike.text = String(cnt+1)
                            }
                            if let cnt = Int(cell.lblDislike.text!){
                                cell.lblDislike.text = String(cnt-1)
                            }
                            
                        }else{

                            cell.lblLike.text = objDashboard.upVotedCount(Index: indexPath.row, pluse: 1)
                            cell.lblDislike.text = objDashboard.downVotedCount(Index: indexPath.row, pluse: 0)
                            
                        }
                        cell.imgLike.image = UIImage(named: "redHearticonneww.png")
                        cell.imgDislike.image = UIImage(named: "dislike.png")
                        
                        cell.btnLike.isHidden = true
                        cell.btDislike.isHidden = false
                        
                        
                        
                    }else{
                        if cell.imgLike.image == UIImage(named: "redHearticonneww.png"){
                            cell.lblDislike.text = objDashboard.upVotedCount(Index: indexPath.row, pluse: 1)
                            cell.lblLike.text = objDashboard.downVotedCount(Index: indexPath.row, pluse: -1)
                            
                        }else{
                            cell.lblDislike.text = objDashboard.upVotedCount(Index: indexPath.row, pluse: 1)
                            cell.lblLike.text = objDashboard.downVotedCount(Index: indexPath.row, pluse: 0)
                            
                        }
                        cell.imgDislike.image = UIImage(named: "heartBroken.png")
                         cell.imgLike.image = UIImage(named: "like.png")
                        cell.btDislike.isHidden = true
                        cell.btnLike.isHidden = false
                        
                    }
                    
                    
                }
                
                
                
                
//              if objDashboard.CheakUpvoteLocaly(Index: indexPath.row) == "1"{
//                cell.imgLike.image = UIImage(named: "redHearticonneww.png")
//                cell.lblLike.text = objDashboard.upVotedCount(Index: indexPath.row, pluse: 1)
//              }else{
//                if objDashboard.upVotedByCurntUser(Index: indexPath.row) == "true"{
//                    cell.imgLike.image = UIImage(named: "redHearticonneww.png")
//                }else{
//                    cell.imgLike.image = UIImage(named: "like.png")
//                }
//                cell.lblLike.text = objDashboard.upVotedCount(Index: indexPath.row, pluse: 0)
//                }
//
//                // downvote
//                if objDashboard.CheakDownvoteLocaly(Index: indexPath.row) == "1"{
//                    cell.imgDislike.image = UIImage(named: "redHearticonneww.png")
//                    cell.lblDislike.text = objDashboard.downVotedCount(Index: indexPath.row, pluse: 1)
//
//                }else{
//                    if objDashboard.downVotedByCurntUser(Index: indexPath.row) == "true"{
//                          cell.imgDislike.image = UIImage(named: "redHearticonneww.png")
//                    }else{
//                        cell.imgDislike.image = UIImage(named: "dislike.png")
//                    }
//                    cell.lblDislike.text = objDashboard.downVotedCount(Index: indexPath.row, pluse: 0)
//                }
                
                
           
        
                cell.lblComment.text = objDashboard.commentCount(Index: indexPath.row)
                // cell.lblShare.text = objDashboard.
                
                cell.btnLike.tag = indexPath.row
                cell.btDislike.tag = indexPath.row
                cell.btnComment.tag = indexPath.row
                cell.btnShare.tag = indexPath.row
                
                
                return cell
            }
        }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         if tableView != tblViewDashBoard {
           
            sidemenu()
            if indexPath.row == 1{
                // connection
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "MyConnectionVC")as! MyConnectionVC
                self.navigationController?.pushViewController(vc, animated: true)
            }
            else if indexPath.row == 2{
                // messenger
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "messangerScreenVC")as! messangerScreenVC
                self.navigationController?.pushViewController(vc, animated: true)
            }
            else if indexPath.row == 3{
                // my funds
            }
            else if indexPath.row == 4{
               // my buzz
            }
            else if indexPath.row == 5{
                // my shedular
            }
            else if indexPath.row == 6{
                // my reviews
            }
            else if indexPath.row == 7{
                // my photos
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "MyPhotosScreenVC")as! MyPhotosScreenVC
                self.navigationController?.pushViewController(vc, animated: true)
            }
            else if indexPath.row == 8{
                // my videos
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "MyVideosScreenVC")as! MyVideosScreenVC
                self.navigationController?.pushViewController(vc, animated: true)
            }
            else if indexPath.row == 9{
                // my music
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "MyMusicVC_Main")as! MyMusicVC_Main
                self.navigationController?.pushViewController(vc, animated: true)
            }
            else if indexPath.row == 10{
                // my favs
            }
            else if indexPath.row == 10{
                // settings
            }
            
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if tableView == tblViewDashBoard {
            spinner.stopAnimating()
            self.lblFooter.isHidden = true
        if indexPath.row == objDashboard.postsCount()-1 && self.isLoading == false && refreshControl.isRefreshing == false && arrPageCount[selectedBtnIndex] < objDashboard.totalPageCount(tab:selectedBtnIndex){
          
            self.isLoading = true
            print(arrPageCount[selectedBtnIndex])
           arrPageCount[selectedBtnIndex] += 1
             print(arrPageCount[selectedBtnIndex])
            spinner = UIActivityIndicatorView(activityIndicatorStyle: .gray)
            spinner.startAnimating()
            spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(60))
            
            tblViewDashBoard.tableFooterView = spinner
            tblViewDashBoard.tableFooterView?.isHidden = false
            
        if selectedBtnIndex == 1{
            getData(tab: 1, refresh: false)
            
        }else if selectedBtnIndex == 2{
            getData(tab: 2, refresh: false)
            
        }else if selectedBtnIndex == 3{
            getData(tab: 3, refresh: false)
            
        }else if selectedBtnIndex == 4{
            getData(tab: 4, refresh: false)
            
            }
            
           
        }else{
            self.lblFooter.isHidden = false
            tblViewDashBoard.tableFooterView?.isHidden = false
            self.lblFooter.textAlignment = .center
            self.lblFooter.textColor = UIColor.gray
            self.lblFooter.backgroundColor = UIColor.white
            self.lblFooter.text = "No More Data"
            tblViewDashBoard.tableFooterView?.addSubview(self.lblFooter)
            }
      }
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tblViewDashBoard.dequeueReusableCell(withIdentifier: "cellidHeader")as! DashboardTableViewCell
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
        if tableView == tblView{
            return 0
        }else{
            return 50
            
        }
    }
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            if tableView == tblView{
            if indexPath.row == 0{
                return 87
            }else if indexPath.row < arrTitle.count-1{
                return 50
            }else{
              return 120
            }
            }else{
               return UITableViewAutomaticDimension
            }
        }


}
extension DashboardViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return objLoginData.arrIntrst.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row < objLoginData.arrIntrst.count{
            let cell = clcViewSelectedCatgry.dequeueReusableCell(withReuseIdentifier: "cellid", for: indexPath) as! CategoryCollectionViewCell
            
        if let str = objLoginData.arrIntrst[indexPath.row].intrstname {
            cell.lblTitleProfession.text = str
        }
        
            return cell
        }else{
            let cell = clcViewSelectedCatgry.dequeueReusableCell(withReuseIdentifier: "cellid2", for: indexPath) as! CategoryCollectionViewCell
            
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row < objLoginData.arrIntrst.count{
               print("okoke")
        }else{
            print("ok")
            //            let vc = self.storyboard?.instantiateViewController(withIdentifier: "")as!
            //            self.navigationController?.pushViewController(vc, animated: true)
      }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.row < objLoginData.arrIntrst.count{
            if let str = objLoginData.arrIntrst[indexPath.row].intrstname{
                if str.count > 4{
                    if str.count > 12{
                        return CGSize(width: CGFloat(str.count*10), height: collectionView.frame.size.height)
                    }else{
              return CGSize(width: CGFloat(str.count*15), height: collectionView.frame.size.height)
                    }
                }else{
                   return CGSize(width: CGFloat(str.count*27), height: collectionView.frame.size.height)
                }
            }
            
            return CGSize(width: 50, height: collectionView.frame.size.height)
            // return UICollectionViewFlowLayoutAutomaticSize
        }else{
           return CGSize(width: 50, height: collectionView.frame.size.height)
         }
        
    }
    
}
extension DashboardViewController:UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SearchHashTagsInTableVC")as! SearchHashTagsInTableVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
class MediaFetcher {
    func downloadGifFile(_ url: URL, completion: @escaping (_ imageURL: URL) -> () = { (imageURL) in} ) {
        KingfisherManager.shared.retrieveImage(with: url, options: .none, progressBlock: nil) { (image, error, cacheType, imageUrl) in
            guard error == nil else {
                return
            }
            guard let imageUrl = imageUrl else {
                return
            }
            completion(imageUrl)
        }
        
    }
}
