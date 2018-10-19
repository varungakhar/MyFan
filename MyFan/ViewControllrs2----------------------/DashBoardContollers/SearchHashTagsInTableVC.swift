
//
//  SearchHashTagsInTableVC.swift
//  MyFan
//
//  Created by user on 12/09/18.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit
import ActiveLabel
class SearchHashTagsInTableVC: UIViewController {

    @IBOutlet weak var txtSearch: UITextField!
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet var btnsOutles: [UIButton]!
    @IBOutlet weak var lblLine: UILabel!
    @IBOutlet weak var scrllView: UIScrollView!
    @IBOutlet weak var tblTags: UITableView!
    @IBOutlet weak var tblPosts: UITableView!
    @IBOutlet weak var tblProfile: UITableView!
    @IBOutlet weak var tblAll: UITableView!
    
    @IBOutlet weak var lblLineLeadingConstraint: NSLayoutConstraint!
    let arrHeader = ["Tags","Posts","Profile"]
    
    var isLoadingTag = false
     var isLoadingPost = false
     var isLoadingProfile = false
var spinner = UIActivityIndicatorView()
    var lblFooter = UILabel()
     let mf = MediaFetcher()
    let objSearchTag = PostNewCreateViewModel()
    let objSearchPostProfile = SearchHashTagsInTableViewModel()
    
    var tagcount = 1
    var postcount = 1
    var profilecount = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
     
          txtSearch.addTarget(self, action: #selector(textDidChanged(sender:)), for: UIControlEvents.editingChanged)
        txtSearch.becomeFirstResponder()
        
        tblView.delegate = self
        tblView.dataSource = self
        tblView.estimatedRowHeight = 60
        tblView.rowHeight = UITableViewAutomaticDimension
        
        tblTags.delegate = self
        tblTags.dataSource = self
        tblTags.estimatedRowHeight = 52
        tblTags.rowHeight = UITableViewAutomaticDimension
        
        tblPosts.delegate = self
        tblPosts.dataSource = self
        tblPosts.estimatedRowHeight = 90
        tblPosts.rowHeight = UITableViewAutomaticDimension
        
        tblProfile.delegate = self
        tblProfile.dataSource = self
        tblProfile.estimatedRowHeight = 75
        tblProfile.rowHeight = UITableViewAutomaticDimension
        
        tblAll.delegate = self
        tblAll.dataSource = self
        tblAll.estimatedRowHeight = 5
        tblAll.rowHeight = UITableViewAutomaticDimension
        scrllView.delegate = self
        
        lblFooter.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 50)
      
    }
  
    @objc func textDidChanged(sender:UITextField){
        
        if(sender == txtSearch){
          print(sender.text!)
            tblView.isHidden = false
            objSearchTag.getTags(text: sender.text!, vc: self) { (responce) in
                
                self.tblView.reloadData()
            }
        }
    }
    
    @IBAction func btnsActions(_ sender: UIButton) {
        for i in 0 ..< btnsOutles.count{
            if i == sender.tag{
              btnsOutles[i].setTitleColor(UIColor.black, for: .normal)
            }else{
               btnsOutles[i].setTitleColor(UIColor.gray, for: .normal)
            }
        }
      //  lblLineLeadingConstraint.constant = btnsOutles[sender.tag].frame.origin.x
        if sender.tag == 0{
            scrllView.setContentOffset(CGPoint(x:0 , y: 0), animated: true)
        } else if sender.tag == 1{
            scrllView.setContentOffset(CGPoint(x:self.view.frame.width , y: 0), animated: true)
        }
        else if sender.tag == 2{
            scrllView.setContentOffset(CGPoint(x:self.view.frame.width*2 , y: 0), animated: true)
        }
        else if sender.tag == 3{
           scrllView.setContentOffset(CGPoint(x:self.view.frame.width*3 , y: 0), animated: true)
        }
    }
  
    func searchTags(txt:String,hitNext:Bool,showHud:String){
    objSearchPostProfile.SearchTags(text: txt, showHud: showHud, vc: self) { (responce,msg)  in
          print(responce!)
            self.isLoadingTag = false
            
            self.tblTags.reloadData()
            self.spinner.stopAnimating()
      
            if hitNext{
                self.searchPosts(txt:txt, hitNext: true, showHud: "yes")
            }
        }
    }
    func searchPosts(txt:String,hitNext:Bool,showHud:String){
        objSearchPostProfile.searchPosts(text: txt, showHud: showHud, vc: self) { (responce,msg) in
             print(responce!)
            self.isLoadingPost = false
            
            self.tblPosts.reloadData()
            self.spinner.stopAnimating()
            
            if hitNext{
                self.searchProfiles(txt:txt, hitNext: false, showHud: "yes")
            }
        }
    }
    func searchProfiles(txt:String,hitNext:Bool,showHud:String){
        objSearchPostProfile.searchProfile(text: txt, showHud: showHud, vc: self) { (responce,msg) in
            self.tblAll.reloadData()
           
            self.isLoadingProfile = false
             self.tblProfile.reloadData()
            self.spinner.stopAnimating()
       
                self.tblTags.tableFooterView?.isHidden = true
            
             print(responce!)
        }
    }
    
    @IBAction func btnTagAction(_ sender: UIButton) {
        print(sender.tag)
    }
    
    @IBAction func btnConnectAction(_ sender: UIButton) {
         print(sender.tag)
    }
    
    
    @IBAction func btnBackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
extension SearchHashTagsInTableVC:UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        if tableView == tblAll{
           return arrHeader.count
        }else{
            return 1
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == tblAll{
            if section == 0{
              return objSearchPostProfile.tagsCount1()
            }else if section == 1{
               return objSearchPostProfile.PostsCount1()
            }else{
              return objSearchPostProfile.profilesCount1()
            }
            
        }else if tableView == tblTags{
            return objSearchPostProfile.tagsCount()
        }else if tableView == tblPosts{
            return objSearchPostProfile.PostsCount()
        }else if tableView == tblProfile{
            return objSearchPostProfile.profilesCount()
        }else{
        return objSearchTag.tagsCount()
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == tblAll{
            if indexPath.section == 0{
            let cell = tblAll.dequeueReusableCell(withIdentifier: "cellid1") as! SearchHashTagsInTblCell
                let txt = "   "+objSearchPostProfile.tagsName(Index: indexPath.row)+"   "
                cell.btnTag.setTitle(txt, for: .normal)
            return cell
            }else if indexPath.section == 1{
                let cell = tblAll.dequeueReusableCell(withIdentifier: "cellid2") as! SearchHashTagsInTblCell
                cell.lblBodyPosts.text = objSearchPostProfile.postBody(Index: indexPath.row)
                let arrPost = objSearchPostProfile.typeOfPost(Index: indexPath.row)
                if arrPost?.count != 0 && arrPost != nil{
                    let dict = arrPost![0]
                    if let str = dict["attachment_url"]as? String{
                        cell.imgPosts.kf.indicatorType = .activity
                        
                        if str.contains(".mp4"){
                            // video
                            if let strThmbImg = dict["video_thumb_url"]as? String{
                                cell.imgPosts.kf.setImage(with: URL(string: strThmbImg))
                                cell.imgVideoIcon.isHidden = false
                                
                            }
                        }else if str.contains(".m4a"){
                            // audio
                            if let strThmbImg = dict["audio_thumb_url"]as? String{
                                cell.imgPosts.kf.setImage(with: URL(string: strThmbImg))
                                cell.imgVideoIcon.isHidden = false
                            }
                        }else if str.contains(".jpg") || str.contains(".jpeg") || str.contains(".png"){
                            // image
                            cell.imgPosts.kf.setImage(with: URL(string: str))
                            cell.imgVideoIcon.isHidden = true
                            
                        }else if str.contains(".gif"){
                            cell.imgPosts.image = nil
                            mf.downloadGifFile(URL(string: str)!) { (imgUrl) in
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                    cell.imgPosts.kf.setImage(with: imgUrl)
                                    
                                }
                                
                            }
                            cell.imgVideoIcon.isHidden = true
                            
                        }
                        if arrPost!.count > 1{
                            cell.viewMore.isHidden = false
                        }else{
                            cell.viewMore.isHidden = true
                        }
                    }
                }
           
                cell.lblHashTagOnlyForShow.text = objSearchPostProfile.HashTagTopicsOnlyForShow(Index: indexPath.row)
                cell.lblHashTagDashBoard.text = objSearchPostProfile.HashTagTopics(Index: indexPath.row)
                print(objSearchPostProfile.HashTagTopics(Index: indexPath.row))
                cell.lblHashTagDashBoard.handleHashtagTap { (hashtag) in
                    print(hashtag)
                    print(self.objSearchPostProfile.HashTagTopics(Index: indexPath.row))
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "TagHashViewController")as! TagHashViewController
                    vc.strHashTag = hashtag
                    self.present(vc, animated: true, completion: nil)
                }
                return cell
            }else{
                let cell = tblAll.dequeueReusableCell(withIdentifier: "cellid3") as! SearchHashTagsInTblCell
                cell.imgProfile.kf.indicatorType = .activity
                cell.imgProfile.kf.setImage(with: URL(string: objSearchPostProfile.ProfilePic(Index: indexPath.row)))
                cell.imgProfile.layer.cornerRadius = 5.0
                cell.imgProfile.clipsToBounds = true
                cell.lbl1Profile.attributedText = objSearchPostProfile.setLableFirst(lbl1: objSearchPostProfile.fullName(Index: indexPath.row), lbl2: objSearchPostProfile.userName(Index: indexPath.row))
                
                cell.lbl2Profile.text = objSearchPostProfile.profesionalText(Index: indexPath.row)
                cell.lbl3Profile.text = objSearchPostProfile.mutualContects(Index: indexPath.row)
                cell.btnConnect.tag = indexPath.row
                return cell
            }
            
        }else if tableView == tblTags{
            let cell = tblTags.dequeueReusableCell(withIdentifier: "cellid1") as! SearchHashTagsInTblCell
            let txt = "   "+objSearchPostProfile.tagsName(Index: indexPath.row)+"   "
            cell.btnTag.setTitle(txt, for: .normal)
            return cell
        }else if tableView == tblPosts{
            let cell = tblPosts.dequeueReusableCell(withIdentifier: "cellid2") as! SearchHashTagsInTblCell
            cell.lblBodyPosts.text = objSearchPostProfile.postBody(Index: indexPath.row)
            // imgPosts
          let arrPost = objSearchPostProfile.typeOfPost(Index: indexPath.row)
            if arrPost?.count != 0 && arrPost != nil{
                let dict = arrPost![0]
                if let str = dict["attachment_url"]as? String{
                    cell.imgPosts.kf.indicatorType = .activity
                    
                    if str.contains(".mp4"){
                        // video
                        if let strThmbImg = dict["video_thumb_url"]as? String{
                            cell.imgPosts.kf.setImage(with: URL(string: strThmbImg))
                            cell.imgVideoIcon.isHidden = false
                            
                        }
                    }else if str.contains(".m4a"){
                        // audio
                        if let strThmbImg = dict["audio_thumb_url"]as? String{
                            cell.imgPosts.kf.setImage(with: URL(string: strThmbImg))
                            cell.imgVideoIcon.isHidden = false
                        }
                    }else if str.contains(".jpg") || str.contains(".jpeg") || str.contains(".png"){
                        // image
                        cell.imgPosts.kf.setImage(with: URL(string: str))
                        cell.imgVideoIcon.isHidden = true
                        
                    }else if str.contains(".gif"){
                        cell.imgPosts.image = nil
                        mf.downloadGifFile(URL(string: str)!) { (imgUrl) in
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                cell.imgPosts.kf.setImage(with: imgUrl)
                                
                            }
                            
                        }
                        cell.imgVideoIcon.isHidden = true
                        
                    }
                    if arrPost!.count > 1{
                        cell.viewMore.isHidden = false
                    }else{
                        cell.viewMore.isHidden = true
                    }
                }
            }
            cell.lblHashTagOnlyForShow.text = objSearchPostProfile.HashTagTopicsOnlyForShow(Index: indexPath.row)
            cell.lblHashTagDashBoard.text = objSearchPostProfile.HashTagTopics(Index: indexPath.row)
            print(objSearchPostProfile.HashTagTopics(Index: indexPath.row))
            cell.lblHashTagDashBoard.handleHashtagTap { (hashtag) in
                print(hashtag)
                print(self.objSearchPostProfile.HashTagTopics(Index: indexPath.row))
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "TagHashViewController")as! TagHashViewController
                vc.strHashTag = hashtag
                self.present(vc, animated: true, completion: nil)
            }
            return cell
        }else if tableView == tblProfile{
            let cell = tblProfile.dequeueReusableCell(withIdentifier: "cellid3") as! SearchHashTagsInTblCell
            cell.imgProfile.kf.indicatorType = .activity
            cell.imgProfile.kf.setImage(with: URL(string: objSearchPostProfile.ProfilePic(Index: indexPath.row)))
            cell.imgProfile.layer.cornerRadius = 5.0
            cell.imgProfile.clipsToBounds = true
            cell.lbl1Profile.attributedText = objSearchPostProfile.setLableFirst(lbl1: objSearchPostProfile.fullName(Index: indexPath.row), lbl2: objSearchPostProfile.userName(Index: indexPath.row))
            
            cell.lbl2Profile.text = objSearchPostProfile.profesionalText(Index: indexPath.row)
            cell.lbl3Profile.text = objSearchPostProfile.mutualContects(Index: indexPath.row)
            cell.btnConnect.tag = indexPath.row
      
            return cell
        }else{
        
        let cell = tblView.dequeueReusableCell(withIdentifier: "cellid") as! CommonTblCell
        cell.lblHashTag.text = objSearchTag.tagName(Index: indexPath.row)
        return cell
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == tblAll{
            
        }else if tableView == tblTags{
            
        }else if tableView == tblPosts{
            
        }else if tableView == tblProfile{
            
        }else{
        print(objSearchTag.tagName(Index: indexPath.row))
            tblView.isHidden = true
            objSearchPostProfile.clearArrys()
            tagcount = 1
            postcount = 1
            profilecount = 1
            searchTags(txt:objSearchTag.tagName(Index: indexPath.row), hitNext: true, showHud: "yes")
            txtSearch.placeholder = objSearchTag.tagName(Index: indexPath.row)
            txtSearch.text = ""
            
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
            let cell = tblAll.dequeueReusableCell(withIdentifier: "cellHeader") as! SearchHashTagsInTblCell
            cell.backgroundColor = UIColor.white
        cell.lblHeaderTag.attributedText = NSAttributedString(string: arrHeader[section], attributes:
            [.underlineStyle: NSUnderlineStyle.styleSingle.rawValue])
        
            return cell
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if tableView == tblAll{
            return 52
        }else{
            return 0
        }
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
              spinner.stopAnimating()
             self.lblFooter.isHidden = true
        if tableView == tblTags{
                    if indexPath.row == objSearchPostProfile.tagsCount()-1 && self.isLoadingTag == false && tagcount < objSearchPostProfile.totalPageTag(){
            tagcount += 1
                        
                        self.isLoadingTag = true
            
                        spinner = UIActivityIndicatorView(activityIndicatorStyle: .gray)
                        spinner.startAnimating()
                        spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(60))
            
                        tblTags.tableFooterView = spinner
                        tblTags.tableFooterView?.isHidden = false
                    
                        searchTags(txt:"", hitNext: false, showHud: "no")
                    }else{
                         self.lblFooter.isHidden = false
                        self.tblTags.tableFooterView?.isHidden = false
                        self.lblFooter.textAlignment = .center
                        self.lblFooter.textColor = UIColor.gray
                        self.lblFooter.backgroundColor = UIColor.white
                        self.lblFooter.text = "No More Data"
                        self.tblTags.tableFooterView?.addSubview(self.lblFooter)
                        
                    //    self.tblTags.tableFooterView?.isHidden = true
                        
            }
        }else if tableView == tblPosts{
            if indexPath.row == objSearchPostProfile.PostsCount()-1 && self.isLoadingPost == false && postcount < objSearchPostProfile.totalPagePosts(){
                postcount += 1
                self.isLoadingPost = true
                
                spinner = UIActivityIndicatorView(activityIndicatorStyle: .gray)
                spinner.startAnimating()
                spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(60))
                
                tblPosts.tableFooterView = spinner
                tblPosts.tableFooterView?.isHidden = false
                self.searchPosts(txt:"", hitNext: false, showHud: "no")
     
            }else{
                self.lblFooter.isHidden = false
                self.tblPosts.tableFooterView?.isHidden = false
                self.lblFooter.textAlignment = .center
                self.lblFooter.textColor = UIColor.gray
                self.lblFooter.backgroundColor = UIColor.white
                self.lblFooter.text = "No More Data"
                self.tblPosts.tableFooterView?.addSubview(self.lblFooter)
                
              //  self.tblPosts.tableFooterView?.isHidden = true
            }

        }else if tableView == tblProfile{
            if indexPath.row == objSearchPostProfile.profilesCount()-1 && self.isLoadingProfile == false && postcount < objSearchPostProfile.totalPageProfiles(){
                profilecount += 1
                self.isLoadingProfile = true
                
                spinner = UIActivityIndicatorView(activityIndicatorStyle: .gray)
                spinner.startAnimating()
                spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(60))
                
                tblProfile.tableFooterView = spinner
                tblProfile.tableFooterView?.isHidden = false
                self.searchProfiles(txt:"", hitNext: false, showHud: "no")
            }else{
                self.lblFooter.isHidden = false
                self.tblProfile.tableFooterView?.isHidden = false
                self.lblFooter.textAlignment = .center
                self.lblFooter.textColor = UIColor.gray
                self.lblFooter.backgroundColor = UIColor.white
                self.lblFooter.text = "No More Data"
                self.tblProfile.tableFooterView?.addSubview(self.lblFooter)
                
              //  self.tblProfile.tableFooterView?.isHidden = true
            }
        }

    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        lblLine.frame.origin = CGPoint(x: scrllView.contentOffset.x/4, y: lblLine.frame.origin.y)
    
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let page = Int(round(scrollView.contentOffset.x/scrollView.frame.width))
        for i in 0 ..< btnsOutles.count{
            if i == page{
                btnsOutles[i].setTitleColor(UIColor.black, for: .normal)
            }else{
                btnsOutles[i].setTitleColor(UIColor.gray, for: .normal)
            }
        }
        
    }
    
}

class SearchHashTagsInTblCell:UITableViewCell{
  
    // 1
    @IBOutlet weak var btnTag: ButtonCustom!
    
  // 3
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lbl1Profile: UILabel!
    @IBOutlet weak var lbl2Profile: UILabel!
    @IBOutlet weak var lbl3Profile: UILabel!
    @IBOutlet weak var btnConnect: ButtonCustom!
    
    // 2
    @IBOutlet weak var imgPosts: ImageCustom!
    
    @IBOutlet weak var imgVideoIcon: UIImageView!
    @IBOutlet weak var viewMore: UIView!
    
    @IBOutlet weak var lblBodyPosts: UILabel!
    @IBOutlet weak var lblHashTagDashBoard: ActiveLabel!
    @IBOutlet weak var lblHashTagOnlyForShow: UILabel!
    
  // header
    
    @IBOutlet weak var lblHeaderTag: UILabel!
    
}
