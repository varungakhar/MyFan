//
//  MyVideosScreenVC.swift
//  MyFan
//
//  Created by user on 04/10/18.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit

class MyVideosScreenVC: UIViewController {
    @IBOutlet weak var tblView: UITableView!
    
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
            #selector(MyPhotosScreenVC.handleRefresh(_:)),
                                 for: UIControlEvents.valueChanged)
        
        refreshControl.tintColor = systemcolor
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        return refreshControl
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tblView.delegate = self
        tblView.dataSource = self
        tblView.estimatedRowHeight = 150
        tblView.rowHeight = UITableViewAutomaticDimension
        self.tblView.addSubview(self.refreshControl)
        lblFooter.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 50)
        getData(tab: selectedBtnIndex, refresh: false)
    }
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        
        getData(tab: selectedBtnIndex, refresh: true)
        arrPageCount[selectedBtnIndex] = 1
    }
    
    @IBAction func btnBackAction(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "DashboardViewController")as! DashboardViewController
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func getData(tab:Int,refresh:Bool){
        objDashboard.GetPost_MyVideos(tab: tab, Refresh: refresh, vc: self) { (responce,str)  in
            self.tblView.reloadData()
            self.isLoading = false
            
            self.refreshControl.endRefreshing()
            self.spinner.stopAnimating()
            //            if str != "No more Posts"{
            //            self.tblViewDashBoard.tableFooterView?.isHidden = true
            //            }else{
            self.tblView.tableFooterView?.isHidden = true
            //}
        }
    }
    
    @IBAction func btnHeaderActions(_ sender: UIButton) {
        tblView.scrollsToTop = true
        
        //    selectedBtnIndex = sender.tag
        //    getData(tab: sender.tag, refresh: false)
        
        tblView.reloadData()
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
                self.tblView.reloadData()
            }else{
                Utility().displayAlert(title: msg, message: "", control: ["ok"])
            }
        }
        
    }
    @IBAction func btnDisLikeCell(_ sender: UIButton) {
        print(sender.tag)
        
        objDashboard.DownvotePost( Index: sender.tag, vc: self) { (responce, msg) in
            if responce!{
                self.tblView.reloadData()
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
}
extension MyVideosScreenVC:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return objDashboard.postsCount()
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = DashboardTableViewCell()
        

        guard let arrPost = objDashboard.typeOfPost_VIDEO(Index: indexPath.row) else{
            return cell
        }
        
        print(arrPost)
        if arrPost.count == 0{
            cell = tblView.dequeueReusableCell(withIdentifier: "cellid1")as! DashboardTableViewCell
            cell.viewMediaContentHeight.constant = 0.0
            cell.layoutIfNeeded()
            // cell.imgPlay1Cell1.isHidden = true
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
                  
                    let imgGif = UIImage.gifImageWithURL(str)
                    cell.img1Cell1.image = imgGif
                    
                    
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
                   
                        let imgGif = UIImage.gifImageWithURL(str)
                        cell.imgsCell2[i].image = imgGif
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
                       
                        let imgGif = UIImage.gifImageWithURL(str)
                        cell.imgsCell3[i].image = imgGif
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
                       
                        let imgGif = UIImage.gifImageWithURL(str)
                        cell.imgsCell4[i].image = imgGif
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
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
            
            tblView.tableFooterView = spinner
            tblView.tableFooterView?.isHidden = false
            
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
            tblView.tableFooterView?.isHidden = false
            self.lblFooter.textAlignment = .center
            self.lblFooter.textColor = UIColor.gray
            self.lblFooter.backgroundColor = UIColor.white
            self.lblFooter.text = "No More Data"
            tblView.tableFooterView?.addSubview(self.lblFooter)
        }
        
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
        
        return 50
        
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableViewAutomaticDimension
        
    }
    
    
}
