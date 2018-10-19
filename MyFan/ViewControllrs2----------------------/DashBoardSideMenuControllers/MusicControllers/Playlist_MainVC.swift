//
//  Playlist_MainVC.swift
//  MyFan
//
//  Created by user on 17/09/18.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit


class Playlist_MainVC: UIViewController {
    @IBOutlet weak var txtSearch: UITextField!
    @IBOutlet weak var clcView1: UICollectionView!
    @IBOutlet weak var clcView2: UICollectionView!
    @IBOutlet weak var clcView3: UICollectionView!
    @IBOutlet weak var clcView4: UICollectionView!
    @IBOutlet weak var clcView5: UICollectionView!
    @IBOutlet weak var viewLocation: ViewCustom!
    @IBOutlet weak var heightConstrintClc2: NSLayoutConstraint!
    @IBOutlet weak var heightConstrintClc3: NSLayoutConstraint!
    @IBOutlet weak var heightConstrintClc4: NSLayoutConstraint!
    @IBOutlet weak var heightConstrintClc5: NSLayoutConstraint!
    @IBOutlet weak var viewSideMenu: UIView!
    @IBOutlet weak var viewSideMenuTrailingCons: NSLayoutConstraint!
    
    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var viewTblHeader: UIView!

    let arr1 = ["Music","PlayList","Artists","Albums","Genre"]
    let arr2 = ["Jazz","Hip Hop","Folk","Electro","Rock Beat","Soalful","Pop","Soulful","Trance"]
    
    let arr3 = ["Soalful","Folk","Pop","Electro","Trancet","Soalful","Jazz","Hip Hop","Trance"]
    let arr4 = ["Asid Jazz","BigBand","Cool","Dixieland","GradeJazz","Contemporary","Dixieland"]
    let arr5 = ["Artists From Everywhere","USA","Australia","England","India","Canada","USA","Japan","China"]
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
            #selector(MyMusicVC_Main.handleRefresh(_:)),
                                 for: UIControlEvents.valueChanged)
        
        refreshControl.tintColor = systemcolor
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        return refreshControl
    }()
 
    var selectedBtnIndex = 1
    var  Selected1 = 1
    var  arrSelected2 = [Int]()
    var  arrSelected3 = [Int]()
    var  arrSelected4 = [Int]()
    var  arrSelected5 = [Int]()
    var tblCellHeight: CGFloat = 100
    
    var isBtnCliked = false
    let objPlaylistViewModel = PlaylistViewModel()
    let objSongstViewModel = PL_SongsViewModel()
    let objStationsViewModel = PL_StationsViewModel()
    let objDownLoadsViewModel = PL_DownLoadsViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
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
        
       tblView.delegate = self
        tblView.dataSource = self
        tblView.rowHeight = UITableViewAutomaticDimension
        tblView.estimatedRowHeight = 351
        tblView.addSubview(refreshControl)
        
        viewLocation.isHidden = true
        SetTblHeader()
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "SideMenuMusicVC")as! SideMenuMusicVC
        self.addChildViewController(vc)
        vc.view.frame = CGRect(x:0, y:0, width:self.viewContainer.frame.size.width, height:self.viewContainer.frame.size.height);
        self.viewContainer.addSubview(vc.view)
        vc.didMove(toParentViewController: self)
        
        showSideMenu(show:false)
        
        // MARK:- Api calling
        
        getData(Tag: 1, refresh: true)
        
       
    }
    func showSideMenu(show:Bool){
        UIView.animate(withDuration: 0.25, delay: 0.0, options: [], animations: {
            if show{
                self.viewSideMenuTrailingCons.constant = 0
                self.view.layoutIfNeeded()
            }else{
                self.viewSideMenuTrailingCons.constant = -270
                self.view.layoutIfNeeded()
            }
        }, completion: { (finished: Bool) in
            
        })
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
       print(selectedBtnIndex)
        getData(Tag: selectedBtnIndex, refresh: true)
      
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
        tblView.reloadData()
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
        tblView.reloadData()
    }
    
    func clickedOnSubCat(){
        // Call on clc2 DidSelect
        heightConstrintClc3.constant = objCommonMusicSection.ShowClc3()
        viewTblHeader.frame.size.height = objCommonMusicSection.CalculateHeaderHeight()
        self.view.layoutIfNeeded()
        tblView.reloadData()
    }
    
    
    /////////////////  END ////////////////////////
    
    override func viewDidDisappear(_ animated: Bool) {
        showSideMenu(show:false)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 
 
    @IBAction func btnSearchMoreOptions(_ sender: Any) {
    clickedOnMore()
    }
    @IBAction func btnLocationAction(_ sender: Any) {
        LocationBtnClicked()

    }
    @IBAction func btnBackAction(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "DashboardViewController")as! DashboardViewController
       self.navigationController?.pushViewController(vc, animated: false)
    }
    @IBAction func btnSideMenuAction(_ sender: Any) {
        if  self.viewSideMenuTrailingCons.constant == -270{
            showSideMenu(show:true)
        }else{
            showSideMenu(show:false)
        }
    }
    
    @IBAction func btnCreatePlaylistAction(_ sender: Any) {
        let alert = UIAlertController(title: "Create New Playlist", message: "", preferredStyle: UIAlertControllerStyle.alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Enter name"
            textField.becomeFirstResponder()
        }
        let actionCan = UIAlertAction(title: "CANCEL", style: .cancel) { (alertAction) in
        }
        let actionAdd = UIAlertAction(title: "ADD", style: .default) { (alertAction) in
             let textField = alert.textFields![0] as UITextField
            print(textField.text!)
        }
        
        alert.addAction(actionCan)
        alert.addAction(actionAdd)
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func btnHeaderActions(_ sender: UIButton) {
         selectedBtnIndex = sender.tag
        print(selectedBtnIndex)
         isBtnCliked = true
        getData(Tag: selectedBtnIndex, refresh: false)
        
    }
    
    // MARK:- Api Handling
    
    func getData(Tag:Int,refresh:Bool){

        print(selectedBtnIndex)
        if Tag == 1{
            objPlaylistViewModel.GetPlaylist(Refresh:refresh,vc: self) { (responce) in
                self.tblCellHeight = CGFloat(((self.objPlaylistViewModel.PlaylistCount()/2)*200)+200)
                self.tblView.reloadData()
            }
        }else  if Tag == 2{
            objSongstViewModel.GetSongs(Refresh: refresh, vc: self) { (responce) in
                self.tblCellHeight = CGFloat((self.objSongstViewModel.SongsCount()*78)+78)
                self.tblView.reloadData()
            }
        }else  if Tag == 3{
            objStationsViewModel.GetStations(Refresh: refresh, vc: self) { (responce) in
                self.tblCellHeight = CGFloat(((self.objStationsViewModel.StationsCount()/2)*230)+230)
                self.tblView.reloadData()
            }
        }else  if Tag == 4{
            objDownLoadsViewModel.GetDownLoads(Refresh: refresh, vc: self) { (responce) in
                self.tblCellHeight = CGFloat((self.objDownLoadsViewModel.DownLoadsCount()*78)+78)
                self.tblView.reloadData()
            }
        }
      
        
        
    }
}

//extension Playlist_MainVC:tblReloadDelegate{
//    func reloadTable(height: CGFloat, Page: Int) {
//        tblCellHeight = height
//        selectedBtnIndex = Page
//        print(selectedBtnIndex)
//        getData(Tag: selectedBtnIndex, refresh: false)
//            tblView.reloadData()
//
//    }
//
//
//}

extension Playlist_MainVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
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
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "MyMusicVC_Main")as! MyMusicVC_Main
                self.navigationController?.pushViewController(vc, animated: false)
                
            }else  if indexPath.row == 1{
//                let vc = self.storyboard?.instantiateViewController(withIdentifier: "Playlist_MainVC")as! Playlist_MainVC
//                self.navigationController?.pushViewController(vc, animated: false)
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
extension Playlist_MainVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tblView.dequeueReusableCell(withIdentifier: "cellid")as! Playlist_Main_Tblcell
     // cell.objTblReload = self
         cell.setObjects(obj1: objPlaylistViewModel, obj2: objSongstViewModel, obj3: objStationsViewModel, obj4: objDownLoadsViewModel, tab: selectedBtnIndex)
        if isBtnCliked{
            isBtnCliked = false
            cell.scrllView.contentOffset.x = CGFloat(selectedBtnIndex-1) * UIScreen.main.bounds.width
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tblView.dequeueReusableCell(withIdentifier: "cellidHeader")as! DashboardTableViewCell
     
        for i in 0 ..< cell.btnsPlaylists.count{
            if i == selectedBtnIndex-1{
                cell.btnsPlaylists[i].setTitleColor(UIColor.black, for: .normal)
            }else{
                cell.btnsPlaylists[i].setTitleColor(UIColor.gray, for: .normal)
            }
         
    }
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 50
        
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tblCellHeight
    }
    

}
// MARK:- Table cell class  Playlist VC Main
protocol tblReloadDelegate {
    func reloadTable(height:CGFloat,Page:Int)
}
class Playlist_Main_Tblcell: UITableViewCell,UIScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout ,UITableViewDelegate,UITableViewDataSource{
 
    @IBOutlet weak var viewMainHeightCons: NSLayoutConstraint!
    
    @IBOutlet weak var viewMain: UIView!
    @IBOutlet weak var scrllView: UIScrollView!
    @IBOutlet weak var clcPlaylist: UICollectionView!
    @IBOutlet weak var tblSongs: UITableView!
    @IBOutlet weak var clcStations: UICollectionView!
    @IBOutlet weak var tblDownlods: UITableView!
   // var objTblReload : tblReloadDelegate?=nil
//     let KtblHeight:CGFloat = 78
//    var ktotalHeight:CGFloat = 0
    
    var objPlaylist = PlaylistViewModel()
    var objSongs = PL_SongsViewModel()
    var objStations = PL_StationsViewModel()
    var objDownLoads = PL_DownLoadsViewModel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        scrllView.delegate = self
     
        clcPlaylist.delegate = self
        clcPlaylist.dataSource = self
        
        clcStations.delegate = self
        clcStations.dataSource = self
        
        tblSongs.delegate = self
        tblSongs.dataSource = self
        tblSongs.estimatedRowHeight = 60
        tblSongs.rowHeight = UITableViewAutomaticDimension
        tblSongs.isScrollEnabled = false
        
        tblDownlods.delegate = self
        tblDownlods.dataSource = self
        tblDownlods.estimatedRowHeight = 60
        tblDownlods.rowHeight = UITableViewAutomaticDimension
        tblDownlods.isScrollEnabled = false
        
//        if objTblReload != nil{
//            ktotalHeight = ((10/2)*200)+200
//            objTblReload?.reloadTable(height: ktotalHeight, Page: 1)
//        }
//           NotificationCenter.default.addObserver(self, selector: #selector(self.Playlist_Main_Tblcell(notification:)), name: NSNotification.Name(rawValue: "ReloadData"), object: nil)
    }
    
    func setObjects(obj1:PlaylistViewModel , obj2:PL_SongsViewModel , obj3: PL_StationsViewModel , obj4:PL_DownLoadsViewModel,tab:Int){
        print(tab)
        if tab == 1{
            objPlaylist = obj1
           clcPlaylist.reloadData()
        }else if tab == 2{
            objSongs = obj2
           tblSongs.reloadData()
        }else if tab == 3{
            objStations = obj3
            clcStations.reloadData()
        }else if tab == 4{
            objDownLoads = obj4
           tblDownlods.reloadData()
        }
    }
    
    // MARK:- Scroll view delegates
 
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//
//        //  lblLine.frame.origin = CGPoint(x: scrllView.contentOffset.x/4, y: lblLine.frame.origin.y)
//
//    }
//
//    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
//      //  sdsdsdsdsd
//    }
//
//
//    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//        let page = Int(round(scrollView.contentOffset.x/scrollView.frame.width))
//
//        if page == 0{
//            ktotalHeight = ((10/2)*200)+200
//        }else if page == 1{
//           ktotalHeight = (10*KtblHeight)+230
//        }else if page == 2{
//             ktotalHeight = ((10/2)*230)
//        }else  if page == 3{
//             ktotalHeight = (10*KtblHeight)
//        }
//        if objTblReload != nil{
//            objTblReload?.reloadTable(height: ktotalHeight,Page:page+1)
//        }
//    }
    
    
   // MARK:- collection view delegates and datasource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == clcPlaylist{
        return objPlaylist.PlaylistCount()
        }else{
            return 10
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == clcPlaylist{
             let  cell = clcPlaylist.dequeueReusableCell(withReuseIdentifier: "cellid", for: indexPath)as! Playlist_Main_Playlist_ClcCell
            cell.imgPlalist.kf.indicatorType = .activity
            cell.imgPlalist.kf.setImage(with: URL(string: objPlaylist.PlaylistImage(Index: indexPath.row)))
            cell.lblPlaylistName.text = objPlaylist.PlaylistName(Index: indexPath.row)
            
            cell.btnPlay.tag = indexPath.row
             return cell
        }else{
            //clcViewStation
            let  cell = clcStations.dequeueReusableCell(withReuseIdentifier: "cellid", for: indexPath)as!  Playlist_Main_Stations_ClcCell

             return cell
         }
       
       
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == clcPlaylist{
        return CGSize(width: collectionView.frame.size.width/2.2, height: 200)
        }else{
            //clcViewStation
            return CGSize(width: collectionView.frame.size.width/2.2, height: 230)
        }
    }
    
    
     // MARK:- Table view delegates and datasource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == tblSongs{
            let cell = tblSongs.dequeueReusableCell(withIdentifier: "cellid")as! Playlist_Main_Songs_TblCell
            

        return cell
        }else{
            // tblViewDownlodes
            let cell = tblDownlods.dequeueReusableCell(withIdentifier: "cellid")as! Playlist_Main_Downlode_TblCell
            return cell
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}
class Playlist_Main_Playlist_ClcCell:UICollectionViewCell{
    @IBOutlet weak var imgPlalist: ImageCustom!
    @IBOutlet weak var lblPlaylistName: UILabel!
     @IBOutlet weak var lblPlaylistSongCount: UILabel!
    @IBOutlet weak var imgPlayIcon: UIImageView!
    @IBOutlet weak var btnPlay: UIButton!
    
}
class Playlist_Main_Stations_ClcCell:UICollectionViewCell{
    
    @IBOutlet weak var imgViewBnner: ImageCustom!
    
    @IBOutlet weak var imgStationType: UIImageView!
    
    @IBOutlet weak var lblFanof: UILabel!
    
    @IBOutlet weak var lblStationType: UILabel!
    
    @IBOutlet weak var lblFanCount: UILabel!
    
}
class Playlist_Main_Songs_TblCell:UITableViewCell{
    @IBOutlet weak var imgview: ImageCustom!
    @IBOutlet weak var lbl1: UILabel!
    @IBOutlet weak var lbl2: UILabel!
    @IBOutlet weak var lbl3: UILabel!
    @IBOutlet weak var imgPlayPause: UIImageView!
    @IBOutlet weak var lblSongTime: UILabel!
    @IBOutlet weak var btnMore: UIButton!
}
class Playlist_Main_Downlode_TblCell:UITableViewCell{
    @IBOutlet weak var imgview: ImageCustom!
    @IBOutlet weak var lbl1: UILabel!
    @IBOutlet weak var lbl2: UILabel!
    @IBOutlet weak var lbl3: UILabel!
    @IBOutlet weak var imgPlayPause: UIImageView!
    @IBOutlet weak var lblSongTime: UILabel!
    @IBOutlet weak var btnMore: UIButton!
}
