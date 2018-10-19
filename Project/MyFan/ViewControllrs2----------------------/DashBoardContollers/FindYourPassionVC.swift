//
//  FindYourPassionVC.swift
//  MyFan
//
//  Created by user on 08/10/18.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit

class FindYourPassionVC: UIViewController {

    @IBOutlet weak var txtSearch: UITextField!
    @IBOutlet var btnUpper: [UIButton]!
    @IBOutlet weak var tblFollowing: UITableView!
    @IBOutlet weak var tblFollow: UITableView!
    
    @IBOutlet weak var scrollview: UIScrollView!
     @IBOutlet weak var lblLine: UILabel!
    @IBOutlet weak var lblLineLeadingConst: NSLayoutConstraint!
     var selectedBtnIndex = 0
    var selectedSction = [-1]
    let objFindPassion = FindYourPassionViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollview.delegate = self
        tblFollowing.delegate = self
        tblFollow.delegate = self
        tblFollowing.dataSource = self
        tblFollow.dataSource = self
        
        tblFollowing.estimatedRowHeight = 75
        tblFollowing.rowHeight  = UITableViewAutomaticDimension
        tblFollow.estimatedRowHeight = 75
        tblFollow.rowHeight  = UITableViewAutomaticDimension
        setPage(Tab:0)
    }

    
    @IBAction func btnUpper(_ sender: UIButton) {
        setPage(Tab:sender.tag)
    }
    
    func setPage(Tab:Int){
        selectedBtnIndex = Tab
        
        scrollview.contentOffset.x = CGFloat(selectedBtnIndex) * UIScreen.main.bounds.width
        lblLineLeadingConst.constant = (UIScreen.main.bounds.width/2)*CGFloat(selectedBtnIndex)
        lblLine.layoutIfNeeded()
        for i in 0 ..< btnUpper.count{
            if i == selectedBtnIndex{
                btnUpper[i].setTitleColor(UIColor.black.withAlphaComponent(1.0), for: .normal)
            }else{
                btnUpper[i].setTitleColor(UIColor.black.withAlphaComponent(0.3), for: .normal)
            }
        }
        getData(tab: selectedBtnIndex)
    }
    
    func getData(tab:Int){
        if tab == 0{
            if objFindPassion.is_FollowingData_Empty(){
            objFindPassion.GetFollowingData(Refresh: false, vc: self) { (responce, msg) in
                
                self.tblFollowing.reloadData()
            }
            }
        }else if tab == 1{
            if objFindPassion.is_FollowListData_Empty(){
            objFindPassion.GetFollowListData(Refresh: false, vc: self) { (responce, msg) in
                self.tblFollow.reloadData()
            }
        }
        }
    }
    @IBAction func btnSectionAction(_ sender: UIButton) {
        if selectedSction.contains(sender.tag){
            if let index = selectedSction.index(of: sender.tag){
                selectedSction.remove(at: index)
            }
            tblFollowing.reloadData()
        }else{
           
        objFindPassion.GetTopicsData(Index: sender.tag, vc: self) { (responce, msg) in
            self.selectedSction.append(sender.tag)
             self.tblFollowing.reloadData()
        }
        }
    }
    
    
    @IBAction func btnBackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

extension FindYourPassionVC:UIScrollViewDelegate{
    
    // MARK:- Scroll view delegates
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView != tblFollowing && scrollView != tblFollow{
        lblLine.frame.origin = CGPoint(x: scrollView.contentOffset.x/2, y: lblLine.frame.origin.y)
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        //  sdsdsdsdsd
    }
    
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView != tblFollowing && scrollView != tblFollow{
        let page = Int(round(scrollView.contentOffset.x/scrollView.frame.width))
        setPage(Tab: page)
        }
    }
}
extension FindYourPassionVC:UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if tableView == tblFollowing{
            return objFindPassion.followingListCount()+1
        }else{
            return objFindPassion.followListCount()
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       if tableView == tblFollowing{
        if selectedSction.contains(section){
            return 1
            
        }else{
            return 0
            
        }
       
       }else{
         return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblFollowing.dequeueReusableCell(withIdentifier: "cellidClc")as! FindYourPassionRowTblCell
        cell.clcView.tag = indexPath.section
        cell.setObject(obj2: objFindPassion)
        print(indexPath.section)
        
        print(cell.clcView.tag)
        print(indexPath.section)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
      var cell = FindYourPassionSectionTblCell()
        if tableView == tblFollowing{
            
            if section < objFindPassion.followingListCount(){
                
                 cell = tblFollowing.dequeueReusableCell(withIdentifier: "cellid")as! FindYourPassionSectionTblCell
                cell.imgUser.kf.indicatorType = .activity
                cell.imgUser.kf.setImage(with: URL(string: objFindPassion.followingImageUrl(Index: section)))
                cell.lbl1.text = objFindPassion.followingName(Index: section)
                cell.lbl2.text = objFindPassion.followingTotalFollowers(Index: section)
                
                if objFindPassion.following_by_current_user(Index:section) == "true"{
                    cell.imgBell.image = UIImage(named: "bell2.png")
                }else{
                    cell.imgBell.image = UIImage(named: "bellwithoutcolornewt.png")
                }
                cell.btnSection.tag = section
          
                
                
            }else{
                 cell = tblFollowing.dequeueReusableCell(withIdentifier: "cellid2")as! FindYourPassionSectionTblCell
              
            }
       

        }else{
            
             cell = tblFollowing.dequeueReusableCell(withIdentifier: "cellid")as! FindYourPassionSectionTblCell
            
            cell.imgUser.kf.indicatorType = .activity
            cell.imgUser.kf.setImage(with: URL(string: objFindPassion.followImageUrl(Index: section)))
            cell.lbl1.text = objFindPassion.followName(Index: section)
            cell.lbl2.text = objFindPassion.followTotalFollowers(Index: section)
            if objFindPassion.follow_by_current_user(Index:section) == "true"{
                cell.imgBell.image = UIImage(named: "bell2.png")
            }else{
                cell.imgBell.image = UIImage(named: "bellwithoutcolornewt.png")
            }
            
            
           
        }
       return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 76
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 360
    }
}



class FindYourPassionSectionTblCell:UITableViewCell{
   
    @IBOutlet weak var imgUser: ImageCustom!
    @IBOutlet weak var lbl1: UILabel!
    @IBOutlet weak var lbl2: UILabel!
    @IBOutlet weak var imgBell: UIImageView!
    @IBOutlet weak var btnSection: UIButton!
}

 import TagCellLayout
class FindYourPassionRowTblCell:UITableViewCell,UICollectionViewDelegate,UICollectionViewDataSource,TagCellLayoutDelegate{
    
    @IBOutlet weak var clcView: UICollectionView!
    var obj = FindYourPassionViewModel()
    
    override func awakeFromNib() {
        clcView.delegate = self
        clcView.dataSource = self
        let tagLayout = TagCellLayout(alignment: .center, delegate: self)
        clcView.collectionViewLayout = tagLayout
    }
    func setObject(obj2:FindYourPassionViewModel){
        obj = obj2
        clcView.reloadData()
    }
    func tagCellLayoutTagSize(layout: TagCellLayout, atIndex index: Int) -> CGSize {
        let cnt = obj.topicsName(Section: clcView.tag, Index: index).count
        if cnt < 7{
            return CGSize(width: CGFloat(cnt*19), height: 54)
            
        }else{
            return CGSize(width: CGFloat((cnt*15)-(cnt*2)), height: 54)
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return obj.topicsCount(Section: clcView.tag)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = clcView.dequeueReusableCell(withReuseIdentifier: "cellid", for: indexPath) as! SearchHashTagClcCell
      
        cell.lblTags.text = obj.topicsName(Section: clcView.tag, Index: indexPath.row)
        cell.lblTags.textColor = systemcolor
        cell.lblTags.layer.cornerRadius = (cell.lblTags.frame.size.height)/2
        cell.lblTags.clipsToBounds = true
        cell.lblTags.backgroundColor = cellbgcolor
//        cell.lblTags.layer.borderWidth = 1.0
//        cell.lblTags.layer.borderColor = systemcolor.cgColor
      //  cell.backgroundColor = UIColor.brown
        
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let selectedTag = objSearchTag.tagName(Index: indexPath.row)
//        print(selectedTag)
//        tagsField.addTag(selectedTag)
//        self.arrSelectedIds.append(objSearchTag.tagID(Index: indexPath.row))
        
    }
    
    
}

//class FindYourPassionRowClcCell:UICollectionViewCell{
//
//
//}





