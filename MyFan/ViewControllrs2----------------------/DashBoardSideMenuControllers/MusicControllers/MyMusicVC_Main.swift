//
//  MyMusicVC_Main.swift
//  MyFan
//
//  Created by user on 14/09/18.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit
let objCommonMusicSection = CommonMusicSectionViewModel()
let objMusicViewModel = MusicViewModel()
class MyMusicVC_Main: UIViewController {
    
    @IBOutlet weak var txtSearch: UITextField!
    @IBOutlet weak var clcView1: UICollectionView!
    @IBOutlet weak var clcView2: UICollectionView!
    @IBOutlet weak var clcView3: UICollectionView!
    @IBOutlet weak var clcView4: UICollectionView!
    @IBOutlet weak var clcView5: UICollectionView!
    
    @IBOutlet weak var tblViewMain: UITableView!
    @IBOutlet weak var viewSideMenu: UIView!
    
    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var viewSideMenuTrailingCons: NSLayoutConstraint!
    @IBOutlet weak var viewTblHeader: UIView!
    @IBOutlet weak var viewLocation: ViewCustom!
    @IBOutlet weak var heightConstrintClc2: NSLayoutConstraint!
    @IBOutlet weak var heightConstrintClc3: NSLayoutConstraint!
    @IBOutlet weak var heightConstrintClc4: NSLayoutConstraint!
    @IBOutlet weak var heightConstrintClc5: NSLayoutConstraint!
    
    
    var selectedBtnIndex = 1
    var isLoading = false
    var spinner = UIActivityIndicatorView()
    var arrPageCount = [1,1,1,1,1]
    var lblFooter = UILabel()

    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
            #selector(MyMusicVC_Main.handleRefresh(_:)),
                                 for: UIControlEvents.valueChanged)
        
        refreshControl.tintColor = systemcolor
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        return refreshControl
    }()
    
    let arr1 = ["Music","PlayList","Artists","Albums","Genre"]
    let arr2 = ["Jazz","Hip Hop","Folk","Electro","Rock Beat","Soalful","Pop","Soulful","Trance"]
   
    let arr3 = ["Soalful","Folk","Pop","Electro","Trancet","Soalful","Jazz","Hip Hop","Trance"]
    let arr4 = ["Asid Jazz","BigBand","Cool","Dixieland","GradeJazz","Contemporary","Dixieland"]
    let arr5 = ["Artists From Everywhere","USA","Australia","England","India","Canada","USA","Japan","China"]
    
    
    var  Selected1 = 0
     var  arrSelected2 = [Int]()
     var  arrSelected3 = [Int]()
     var  arrSelected4 = [Int]()
     var  arrSelected5 = [Int]()
   
  
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.isNavigationBarHidden = true
      //  txtSearch.delegate = self
        tblViewMain.delegate = self
        tblViewMain.dataSource = self
        tblViewMain.estimatedRowHeight = 150
        tblViewMain.rowHeight = UITableViewAutomaticDimension
        self.tblViewMain.addSubview(self.refreshControl)
        
        clcView1.delegate = self
        clcView1.dataSource = self
    
        clcView2.delegate = self
        clcView2.dataSource = self
        
        clcView3.delegate = self
        clcView3.dataSource = self
        
        clcView4.delegate = self
        clcView4.dataSource = self
        
        clcView5.delegate = self
        clcView5.dataSource = self
        
        
       
        SetTblHeader()

        let vc = storyboard?.instantiateViewController(withIdentifier: "SideMenuMusicVC")as! SideMenuMusicVC
        self.addChildViewController(vc)
        vc.view.frame = CGRect(x:0, y:0, width:self.viewContainer.frame.size.width, height:self.viewContainer.frame.size.height);
        self.viewContainer.addSubview(vc.view)
        vc.didMove(toParentViewController: self)
        
        showSideMenu(show:false)
       getArtistNearBy()
        
    }
    // MARK:- Api Handling
    func getArtistNearBy(){
        
        objMusicViewModel.GetNearByArtis(vc: self) { (responce) in
            self.tblViewMain.reloadData()
          self.getMusicData(tab: 1, refresh: false)
        }
    }
    func getMusicData(tab:Int,refresh:Bool){
        objMusicViewModel.GeMusicFeedData(tab: tab, Refresh: refresh, vc: self) { (responce,str)  in
            self.tblViewMain.reloadData()
            self.isLoading = false
            
            self.refreshControl.endRefreshing()
            self.spinner.stopAnimating()
          
            self.tblViewMain.tableFooterView?.isHidden = true
           
        }
    }
    
    
    func showSideMenu(show:Bool){
     
        UIView.animate(withDuration: 0.25, delay: 0.0, options: [], animations: {
            if show{
                self.viewSideMenuTrailingCons.constant = 0
                self.view.layoutIfNeeded()
            }else{
                self.viewSideMenuTrailingCons.constant = 270
                self.view.layoutIfNeeded()
            }
        }, completion: { (finished: Bool) in
            
        })
        
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        getMusicData(tab: selectedBtnIndex, refresh: true)
        arrPageCount[selectedBtnIndex] = 1
    }
    @IBAction func btnSideMenuAction(_ sender: Any) {
        if  self.viewSideMenuTrailingCons.constant == 270{
         showSideMenu(show:true)
        }else{
          showSideMenu(show:false)
        }
    }
    override func viewDidDisappear(_ animated: Bool) {
        showSideMenu(show:false)
    }
    @IBAction func btnSearchMoreOptions(_ sender: Any) {
     clickedOnMore()

    }
    
    
    
    
    
    @IBAction func btnBackAction(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "DashboardViewController")as! DashboardViewController
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
                      // MARK:- Table Header Adjustment  ///////////////
    
    func SetTblHeader(){
        // Call in ViewDidLoad
        heightConstrintClc2.constant = objCommonMusicSection.clc2Height()
        heightConstrintClc3.constant = objCommonMusicSection.clc3Height()
        heightConstrintClc4.constant = objCommonMusicSection.clc4Height()
        heightConstrintClc5.constant = objCommonMusicSection.clc5Height()
        viewTblHeader.frame.size.height = objCommonMusicSection.CalculateHeaderHeight()
        if heightConstrintClc2.constant == 45{
            viewLocation.isHidden = false
        }else{
            viewLocation.isHidden = true
        }
        self.view.layoutIfNeeded()
    }
    
    func clickedOnMore(){
         // Call on More button Click
        heightConstrintClc2.constant = objCommonMusicSection.ShowClc2()
        heightConstrintClc4.constant = objCommonMusicSection.ShowClc4()
        if heightConstrintClc3.constant == 45{
            heightConstrintClc3.constant = objCommonMusicSection.ShowClc3()
        }
        if heightConstrintClc5.constant == 45{
            heightConstrintClc5.constant = objCommonMusicSection.ShowClc5()
        }
        viewTblHeader.frame.size.height = objCommonMusicSection.CalculateHeaderHeight()
        self.view.layoutIfNeeded()
        tblViewMain.reloadData()
        if heightConstrintClc2.constant == 45{
            viewLocation.isHidden = false
        }else{
            viewLocation.isHidden = true
        }
    }
    func LocationBtnClicked(){
        // Call on Location btn Click
        heightConstrintClc5.constant = objCommonMusicSection.ShowClc5()
        viewTblHeader.frame.size.height = objCommonMusicSection.CalculateHeaderHeight()
        self.view.layoutIfNeeded()
        tblViewMain.reloadData()
    }
    
    func clickedOnSubCat(){
        // Call on clc2 DidSelect
        heightConstrintClc3.constant = objCommonMusicSection.ShowClc3()
        viewTblHeader.frame.size.height = objCommonMusicSection.CalculateHeaderHeight()
        self.view.layoutIfNeeded()
        tblViewMain.reloadData()
    }
    
    
                   /////////////////  END ////////////////////////
    
    
    
    @IBAction func btnLocationAction(_ sender: Any) {
      LocationBtnClicked()
    }
    
 
    
    
    
    
    @IBAction func btnHeaderActions(_ sender: UIButton) {
      //  tblViewDashBoard.scrollsToTop = true
//        if sender.tag == 1{
//            // trending
//            selectedBtnIndex = 1
//
//            getMusicData(tab: 1, refresh: true)
//
//        }else if sender.tag == 2{
//            //recent
//            selectedBtnIndex = 2
//          getMusicData(tab: 2, refresh: true)
//
//        }else if sender.tag == 3{
//            //spotlight
//            selectedBtnIndex = 3
//        getMusicData(tab: 3, refresh: true)
//
//        }else if sender.tag == 4{
//            //popular
//            selectedBtnIndex = 4
//        getMusicData(tab: 4, refresh: true)
//
//        }

       // tblViewMain.reloadData()
        
        selectedBtnIndex = sender.tag
        getMusicData(tab: sender.tag, refresh: false)
        
        tblViewMain.reloadData()
        
        
    }
    @IBAction func btnLikeCell(_ sender: UIButton) {
        print(sender.tag)
     //   print(objDashboard.PostBody(Index: sender.tag))
        
    }
    @IBAction func btnDisLikeCell(_ sender: UIButton) {
        print(sender.tag)
     //   print(objDashboard.PostBody(Index: sender.tag))
    }
    @IBAction func btnCommentCell(_ sender: UIButton) {
        print(sender.tag)
     //   print(objDashboard.PostBody(Index: sender.tag))
    }
    @IBAction func btnShareCell(_ sender: UIButton) {
        print(sender.tag)
     //   print(objDashboard.PostBody(Index: sender.tag))
    }
    @IBAction func btnSeeAllAction(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SeeAllSingrsVC")as! SeeAllSingrsVC
       
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
extension MyMusicVC_Main:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == clcView1{
            return arr1.count
        }else if collectionView == clcView2{
            return arr2.count
        }else if collectionView == clcView3{
            return arr3.count
        }else if collectionView == clcView4{
            return arr4.count
        }else {
            return arr5.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         var cell =  CategoryCollectionViewCell()
        if collectionView == clcView1{
            cell = clcView1.dequeueReusableCell(withReuseIdentifier: "cellid", for: indexPath) as! CategoryCollectionViewCell
            if Selected1 == indexPath.row{
                cell.viewCellBack.backgroundColor = systemcolor
                cell.lblTitleProfession.textColor = UIColor.white
            }else{
                cell.viewCellBack.backgroundColor = cellbgcolor
                cell.lblTitleProfession.textColor = systemcolor
            }
            cell.lblTitleProfession.text = arr1[indexPath.row]
           
        }else if collectionView == clcView2{
            cell = clcView2.dequeueReusableCell(withReuseIdentifier: "cellid", for: indexPath) as! CategoryCollectionViewCell
            if arrSelected2.contains(indexPath.row) {
                cell.viewCellBack.backgroundColor = systemcolor
                cell.lblTitleProfession.textColor = UIColor.white
            }else{
                cell.viewCellBack.backgroundColor = cellbgcolor
                cell.lblTitleProfession.textColor = systemcolor
            }
            cell.lblTitleProfession.text = arr2[indexPath.row]
        }else if collectionView == clcView3{
            cell = clcView3.dequeueReusableCell(withReuseIdentifier: "cellid", for: indexPath) as! CategoryCollectionViewCell
            if arrSelected3.contains(indexPath.row) {
                cell.viewCellBack.backgroundColor = systemcolor
                cell.lblTitleProfession.textColor = UIColor.white
            }else{
                cell.viewCellBack.backgroundColor = cellbgcolor
                cell.lblTitleProfession.textColor = systemcolor
            }
            cell.lblTitleProfession.text = arr3[indexPath.row]
        }else if collectionView == clcView4{
            cell = clcView4.dequeueReusableCell(withReuseIdentifier: "cellid", for: indexPath) as! CategoryCollectionViewCell
            if arrSelected4.contains(indexPath.row) {
                cell.viewCellBack.backgroundColor = systemcolor
                cell.lblTitleProfession.textColor = UIColor.white
            }else{
                cell.viewCellBack.backgroundColor = cellbgcolor
                cell.lblTitleProfession.textColor = systemcolor
            }
            cell.lblTitleProfession.text = arr4[indexPath.row]
        }else {
            cell = clcView5.dequeueReusableCell(withReuseIdentifier: "cellid", for: indexPath) as! CategoryCollectionViewCell
            if arrSelected5.contains(indexPath.row) {
                cell.viewCellBack.backgroundColor = systemcolor
                cell.lblTitleProfession.textColor = UIColor.white
            }else{
                cell.viewCellBack.backgroundColor = cellbgcolor
                cell.lblTitleProfession.textColor = systemcolor
            }
            cell.lblTitleProfession.text = arr5[indexPath.row]
        }
         return cell
        
    }
    
     func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == clcView1{
              Selected1 = indexPath.row
            if indexPath.row == 0{
//                let vc = self.storyboard?.instantiateViewController(withIdentifier: "MyMusicVC_Main")as! MyMusicVC_Main
//              self.navigationController?.pushViewController(vc, animated: false)
                
            }else  if indexPath.row == 1{
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "Playlist_MainVC")as! Playlist_MainVC
                self.navigationController?.pushViewController(vc, animated: false)
            }else  if indexPath.row == 2{
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "ArtistVC")as! ArtistVC
                self.navigationController?.pushViewController(vc, animated: false)
            }else  if indexPath.row == 3{
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "AlbumsVC")as! AlbumsVC
                self.navigationController?.pushViewController(vc, animated: false)
            }else  if indexPath.row == 4{
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "GenreVC")as! GenreVC
                self.navigationController?.pushViewController(vc, animated: false)
            }
        }else if collectionView == clcView2{
            clickedOnSubCat()
            if arrSelected2.contains(indexPath.row){
                if let index = arrSelected2.index(of: indexPath.row){
                arrSelected2.remove(at: index)
                }
            }else{
               arrSelected2.append(indexPath.row)
            }
        }else if collectionView == clcView3{
           
            if arrSelected3.contains(indexPath.row){
                if let index = arrSelected3.index(of: indexPath.row){
                arrSelected3.remove(at: index)
                }
            }else{
                arrSelected3.append(indexPath.row)
            }
        }else if collectionView == clcView4{
            if arrSelected4.contains(indexPath.row){
                if let  index = arrSelected4.index(of: indexPath.row){
                arrSelected4.remove(at: index)
                }
            }else{
                arrSelected4.append(indexPath.row)
            }
        }else {
            if arrSelected5.contains(indexPath.row){
                if let index = arrSelected5.index(of: indexPath.row){
                arrSelected5.remove(at: index)
                }
            }else{
                arrSelected5.append(indexPath.row)
            }
       }
            relodClCView()
    }
    func relodClCView(){
        clcView1.reloadData()
        clcView2.reloadData()
        clcView3.reloadData()
        clcView4.reloadData()
        clcView5.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        var str = ""
        if clcView1 == collectionView{
          str = arr1[indexPath.row]
        }else if clcView2 == collectionView{
            str = arr2[indexPath.row]
        }else if clcView3 == collectionView{
            str = arr3[indexPath.row]
        }else if clcView4 == collectionView{
            str = arr4[indexPath.row]
        }else if clcView5 == collectionView{
            str = arr5[indexPath.row]
        }
     
         return CGSize(width: str.widthOfString(), height: collectionView.frame.size.height)
    }
    
}
extension MyMusicVC_Main:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     
            return objMusicViewModel.postsCount()+1
      
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
     let  cell = tblViewMain.dequeueReusableCell(withIdentifier: "cellid")as! MyMusicVC_MainTblCell
              cell.clcNearByArtistList.reloadData()
            return cell
    }else{
            let Index = indexPath.row - 1
            let  cell = tblViewMain.dequeueReusableCell(withIdentifier: "cellid2")as! DashboardTableViewCell
        
            cell.imgUserDashBoard.kf.indicatorType = .activity
            cell.imgUserDashBoard.kf.setImage(with: URL(string: objMusicViewModel.ArtistProfilePic(Index: Index)))
            cell.img1Cell1.kf.indicatorType = .activity
            cell.img1Cell1.kf.setImage(with: URL(string: objMusicViewModel.AudioThumbImg(Index: Index)))

            cell.lbl1DashBoard.attributedText = objMusicViewModel.setLableFirst(lbl1: objMusicViewModel.ArtistfullName(Index: Index), lbl2: objMusicViewModel.ArtistUser_name(Index: Index)+" · "+"2d")
            

            cell.lbl2DashBoard.text = objMusicViewModel.ArtistVisibility(Index: Index)+" · "+objMusicViewModel.AudioViews_count(Index: Index) + " Views"


            cell.lblLike.text = objMusicViewModel.AudioUpvotes_count(Index: Index)
            cell.lblDislike.text = objMusicViewModel.AudioDownvotes_count(Index: Index)
            cell.lblComment.text = objMusicViewModel.AudioComments_count(Index: Index)
           //  cell.lblShare.text = objDashboard.

            cell.btnLike.tag = Index
            cell.btDislike.tag = Index
            cell.btnComment.tag = Index
            cell.btnShare.tag = Index
            
           return cell
        }

    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row != 0{
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SongPlayerScreenVC")as! SongPlayerScreenVC
        self.present(vc, animated: true, completion: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if tableView == tblViewMain {
            spinner.stopAnimating()
            self.lblFooter.isHidden = true
            if indexPath.row == objMusicViewModel.postsCount()-1 && self.isLoading == false && refreshControl.isRefreshing == false && arrPageCount[selectedBtnIndex] < objMusicViewModel.totalPageCount(tab:selectedBtnIndex){

                self.isLoading = true
                print(arrPageCount[selectedBtnIndex])
                arrPageCount[selectedBtnIndex] += 1
                print(arrPageCount[selectedBtnIndex])
                spinner = UIActivityIndicatorView(activityIndicatorStyle: .gray)
                spinner.startAnimating()
                spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(60))

                tblViewMain.tableFooterView = spinner
                tblViewMain.tableFooterView?.isHidden = false

                if selectedBtnIndex == 1{
                    getMusicData(tab: 1, refresh: false)

                }else if selectedBtnIndex == 2{
                    getMusicData(tab: 2, refresh: false)

                }else if selectedBtnIndex == 3{
                    getMusicData(tab: 3, refresh: false)

                }else if selectedBtnIndex == 4{
                    getMusicData(tab: 4, refresh: false)

                }


            }else{
                self.lblFooter.isHidden = false
                tblViewMain.tableFooterView?.isHidden = false
                self.lblFooter.textAlignment = .center
                self.lblFooter.textColor = UIColor.gray
                self.lblFooter.backgroundColor = UIColor.white
                self.lblFooter.text = "No More Data"
                tblViewMain.tableFooterView?.addSubview(self.lblFooter)
            }
        }
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tblViewMain.dequeueReusableCell(withIdentifier: "cellidHeader")as! DashboardTableViewCell
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

class MyMusicVC_MainClcCell: UICollectionViewCell {
    @IBOutlet weak var imgArtist: UIImageView!
    
    @IBOutlet weak var lblArtistName: UILabel!
    

}


    // MARK:- Artist collection view delegate and datasource
class MyMusicVC_MainTblCell: UITableViewCell,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var btnSeeAll: UIButton!
    @IBOutlet weak var clcNearByArtistList: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        clcNearByArtistList.delegate = self
        clcNearByArtistList.dataSource = self
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
   
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return objMusicViewModel.NearByArtistCount()
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = clcNearByArtistList.dequeueReusableCell(withReuseIdentifier: "cellid", for: indexPath)as! MyMusicVC_MainClcCell
            cell.imgArtist.kf.indicatorType = .activity
            cell.imgArtist.kf.setImage(with: URL(string: objMusicViewModel.NearByArtistImage(Index: indexPath.row)))
            cell.lblArtistName.text = objMusicViewModel.NearByArtistfullName(Index: indexPath.row)
            return cell
        }
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
            return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        }
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            
            return CGSize(width: 104, height: collectionView.frame.size.height)
        }
    
}


