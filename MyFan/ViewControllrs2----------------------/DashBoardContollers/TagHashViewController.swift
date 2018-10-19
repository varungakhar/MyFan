//
//  TagHashViewController.swift
//  MyFan
//
//  Created by user on 31/08/18.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit

class TagHashViewController: UIViewController {
    @IBOutlet weak var lblUserHashTag: UILabel!
    @IBOutlet weak var tblViewHashTag: UITableView!
    
     @IBOutlet weak var imgTrending: UIImageView!
     @IBOutlet weak var imgRecent: UIImageView!
     @IBOutlet weak var imgSpotLight: UIImageView!
     @IBOutlet weak var imgPopular: UIImageView!
    
    
    var selectedBtnIndex = 1
    var strHashTag:String? = nil
    
    let mf = MediaFetcher()
    var isLoading = false
    var spinner = UIActivityIndicatorView()
    let objTagHash = TagHashViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
      
        
        tblViewHashTag.delegate = self
        tblViewHashTag.dataSource = self
        tblViewHashTag.estimatedRowHeight = 150
        tblViewHashTag.rowHeight = UITableViewAutomaticDimension
       
        if strHashTag != nil{
            strHashTag = strHashTag?.replacingOccurrences(of: "_", with: " ")
            strHashTag = strHashTag?.replacingOccurrences(of: "µ", with: " ")
            lblUserHashTag.text = "#"+strHashTag!
             print(strHashTag!)
            getHashTagData(tab:1, str: strHashTag!)
        }
    }

    func getHashTagData(tab:Int,str:String){
        objTagHash.GetTagHashData(strTagHash:str ,tab: tab, vc: self) { (responce) in
            self.tblViewHashTag.reloadData()
            self.isLoading = false
            
            self.spinner.stopAnimating()
            self.tblViewHashTag.tableFooterView?.isHidden = true
        }
    }
  
    @IBAction func btnHeaderActions(_ sender: UIButton) {
        
        if  sender.tag == 1{
            imgTrending.image = UIImage(named:"trending_blue.png")
            
           imgRecent.image = UIImage(named:"recent.png")
            imgSpotLight.image = UIImage(named:"spotlight.png")
            imgPopular.image = UIImage(named:"popular.png")
            
        }else if  sender.tag == 2{
            imgRecent.image = UIImage(named:"recent_blue.png")
            
            imgTrending.image = UIImage(named:"trending.png")
            imgSpotLight.image = UIImage(named:"spotlight.png")
            imgPopular.image = UIImage(named:"popular.png")
        }else if  sender.tag == 3{
           imgSpotLight.image = UIImage(named:"spotlight_blue.png")
            
            imgTrending.image = UIImage(named:"trending.png")
            imgRecent.image = UIImage(named:"recent.png")
            imgPopular.image = UIImage(named:"popular.png")
        }else if  sender.tag == 4{
            imgPopular.image = UIImage(named:"popular_blue.png")
            
            imgTrending.image = UIImage(named:"trending.png")
            imgRecent.image = UIImage(named:"recent.png")
            imgSpotLight.image = UIImage(named:"spotlight.png")
        }
     
    }
    
    @IBAction func btnBackAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 
}

extension TagHashViewController:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
            return objTagHash.postsCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
            var cell = DashboardTableViewCell()
            
            guard let arrPost = objTagHash.typeOfPost(Index: indexPath.row) else{
                return cell
            }
            
            print(arrPost)
            if arrPost.count == 0{
                cell = tblViewHashTag.dequeueReusableCell(withIdentifier: "cellid1")as! DashboardTableViewCell
                cell.viewMediaContentHeight.constant = 0.0
                cell.layoutIfNeeded()
                cell.imgPlay1Cell1.isHidden = true
                cell.img1Cell1.image = nil
            }
            else if arrPost.count == 1{
                cell = tblViewHashTag.dequeueReusableCell(withIdentifier: "cellid1")as! DashboardTableViewCell
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
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                cell.img1Cell1.kf.setImage(with: imgUrl)
                                
                            }
                            
                        }
                        cell.imgPlay1Cell1.isHidden = true
                        
                    }
                }
                
                
            }else if arrPost.count == 2{
                cell = tblViewHashTag.dequeueReusableCell(withIdentifier: "cellid2")as! DashboardTableViewCell
                
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
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                    cell.imgsCell2[i].kf.setImage(with: imgUrl)
                                }
                                
                            }
                            cell.imsPlayCell2[i].isHidden = true
                            
                        }
                    }
                }
                
            }else if arrPost.count == 3{
                cell = tblViewHashTag.dequeueReusableCell(withIdentifier: "cellid3")as! DashboardTableViewCell
                
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
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                    cell.imgsCell3[i].kf.setImage(with: imgUrl)
                                }
                                
                            }
                            cell.imsPlayCell3[i].isHidden = true
                            
                        }
                    }
                }
                
            }else if arrPost.count == 4{
                cell = tblViewHashTag.dequeueReusableCell(withIdentifier: "cellid4")as! DashboardTableViewCell
                
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
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                    cell.imgsCell4[i].kf.setImage(with: imgUrl)
                                }
                                
                            }
                            cell.imsPlayCell4[i].isHidden = true
                            
                        }
                    }
                }
                
            }else  {
                cell = tblViewHashTag.dequeueReusableCell(withIdentifier: "cellid5")as! DashboardTableViewCell
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
                            cell.imsPlayCell5[i].isHidden = true
                            
                        }
                    }
                }
                if arrPost.count > 5{
                    cell.lblMoreCell5.text = "+\(arrPost.count-5) More"
                    cell.lblMoreCell5.isHidden = false
                }
                
            }
            cell.imgUserDashBoard.kf.indicatorType = .activity
            cell.imgUserDashBoard.kf.setImage(with: URL(string: objTagHash.UserProfilePic(Index: indexPath.row)))
            
            cell.lbl1DashBoard.attributedText = objTagHash.setLableFirst(lbl1: objTagHash.UserfullName(Index: indexPath.row), lbl2: objTagHash.UserUser_name(Index: indexPath.row) + " © " + "2d")
            
            cell.lbl2DashBoard.text = objTagHash.userVisibility(Index: indexPath.row) + " © " + objTagHash.viewsCount(Index: indexPath.row) + "Views"
            
            cell.lblDiscriptionDashBoard.text = objTagHash.PostBody(Index: indexPath.row)
            
            cell.lblHashTagOnlyForShow.text = objTagHash.HashTagTopicsOnlyForShow(Index: indexPath.row)
            cell.lblHashTagDashBoard.text = objTagHash.HashTagTopics(Index: indexPath.row)
            print(objTagHash.HashTagTopics(Index: indexPath.row))
            cell.lblHashTagDashBoard.handleHashtagTap { (hashtag) in
                print(hashtag)
                print(self.objTagHash.HashTagTopics(Index: indexPath.row))
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "TagHashViewController")as! TagHashViewController
                vc.strHashTag = hashtag
                self.present(vc, animated: true, completion: nil)
            }
            
            cell.lblLike.text = objTagHash.upVotedCount(Index: indexPath.row)
            cell.lblDislike.text = objTagHash.downVotedCount(Index: indexPath.row)
            cell.lblComment.text = objTagHash.commentCount(Index: indexPath.row)
            // cell.lblShare.text = objTagHash.
            
            cell.btnLike.tag = indexPath.row
            cell.btDislike.tag = indexPath.row
            cell.btnComment.tag = indexPath.row
            cell.btnShare.tag = indexPath.row
            
            
            return cell
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
            if indexPath.row == objTagHash.postsCount()-1 && self.isLoading == false{
                self.isLoading = true
                
                spinner = UIActivityIndicatorView(activityIndicatorStyle: .gray)
                spinner.startAnimating()
                spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(60))
                
                tblViewHashTag.tableFooterView = spinner
                tblViewHashTag.tableFooterView?.isHidden = false
                
//                if selectedBtnIndex == 1{
//                    getData(tab: 1)
//
//                }else if selectedBtnIndex == 2{
//                    getData(tab: 2)
//
//                }else if selectedBtnIndex == 3{
//                    getData(tab: 3)
//
//                }else if selectedBtnIndex == 4{
//                    getData(tab: 4)
//
//                }
                
                
            }
        
    }


    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         return UITableViewAutomaticDimension
       }
    
    
}
