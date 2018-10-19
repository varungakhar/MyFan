//
//  AlbumsVC.swift
//  MyFan
//
//  Created by user on 18/09/18.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit

class AlbumsVC: UIViewController {

    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var txtSearch: UITextField!
    @IBOutlet weak var clcView1: UICollectionView!
    @IBOutlet weak var clcView2: UICollectionView!
    @IBOutlet weak var clcView3: UICollectionView!
    @IBOutlet weak var clcView4: UICollectionView!
    @IBOutlet weak var clcView5: UICollectionView!
    
    
    @IBOutlet weak var viewTblHeader: UIView!
    @IBOutlet weak var viewRandomColor: UIView!
    @IBOutlet weak var viewLocation: ViewCustom!
    @IBOutlet weak var heightConstrintClc2: NSLayoutConstraint!
    @IBOutlet weak var heightConstrintClc3: NSLayoutConstraint!
    @IBOutlet weak var heightConstrintClc4: NSLayoutConstraint!
    @IBOutlet weak var heightConstrintClc5: NSLayoutConstraint!
    @IBOutlet weak var viewSideMenu: UIView!
    @IBOutlet weak var viewSideMenuTrailingCons: NSLayoutConstraint!
    @IBOutlet weak var viewContainer: UIView!
    var selectedBtnIndex = 1
    
    let arr1 = ["Music","PlayList","Artists","Albums","Genre"]
    let arr2 = ["Jazz","Hip Hop","Folk","Electro","Rock Beat","Soalful","Pop","Soulful","Trance"]
    
    let arr3 = ["Soalful","Folk","Pop","Electro","Trancet","Soalful","Jazz","Hip Hop","Trance"]
    let arr4 = ["Asid Jazz","BigBand","Cool","Dixieland","GradeJazz","Contemporary","Dixieland"]
    let arr5 = ["Artists From Everywhere","USA","Australia","England","India","Canada","USA","Japan","China"]
    
    
    var  Selected1 = 3
    var  arrSelected2 = [Int]()
    var  arrSelected3 = [Int]()
    var  arrSelected4 = [Int]()
    var  arrSelected5 = [Int]()
     let objAlbumViewModel = AlbumViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()

       
        tblView.delegate = self
        tblView.dataSource = self
        tblView.estimatedRowHeight = 150
        tblView.rowHeight = UITableViewAutomaticDimension
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
        viewLocation.isHidden = true
        SetTblHeader()
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "SideMenuMusicVC")as! SideMenuMusicVC
        self.addChildViewController(vc)
        vc.view.frame = CGRect(x:0, y:0, width:self.viewContainer.frame.size.width, height:self.viewContainer.frame.size.height);
        self.viewContainer.addSubview(vc.view)
        vc.didMove(toParentViewController: self)
        showSideMenu(show:false)
        
        getAlbums()
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
    override func viewDidDisappear(_ animated: Bool) {
        showSideMenu(show:false)
    }
    
    // MARK:- Table Header Adjustment  ///////////////
    
    func SetTblHeader(){
        // Call in ViewDidLoad
        viewRandomColor.backgroundColor = .random
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
    
    //MARK:- APi Hitting work
    func getAlbums(){
        objAlbumViewModel.GetAlbums(vc: self) { (responce) in
            self.tblView.reloadData()
        }
    }
    
    
    
    @IBAction func btnBackAction(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "DashboardViewController")as! DashboardViewController
        self.navigationController?.pushViewController(vc, animated: false)
    }
    @IBAction func btnSearchMoreOptions(_ sender: Any) {
        clickedOnMore()
    }
    @IBAction func btnLocationAction(_ sender: Any) {
        LocationBtnClicked()
        
    }
    @IBAction func btnAlbumMore(_ sender: UIButton) {
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func btnSideMenuAction(_ sender: Any) {
        if  self.viewSideMenuTrailingCons.constant == 270{
            showSideMenu(show:true)
        }else{
            showSideMenu(show:false)
        }
    }
}
extension AlbumsVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblView.dequeueReusableCell(withIdentifier: "cellid")as! AlbumsTblcell
        cell.setVC(vc: self, obj2: objAlbumViewModel)
        tblView.rowHeight = cell.clcViewMain.collectionViewLayout.collectionViewContentSize.height
        return cell
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
        
        return CGFloat(((objAlbumViewModel.AlbumCount()/2) * 195)+195)
    }
    
}

extension AlbumsVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
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
//                cell.viewCellBack.backgroundColor = UIColor.black.withAlphaComponent(0.4)
//                cell.lblTitleProfession.textColor = UIColor.white
          
            }else{
                cell.viewCellBack.backgroundColor = cellbgcolor
                cell.lblTitleProfession.textColor = systemcolor
//                cell.viewCellBack.backgroundColor = UIColor.clear
//                cell.lblTitleProfession.textColor = UIColor.black.withAlphaComponent(0.5)
            }
            cell.lblTitleProfession.text = arr1[indexPath.row]
            
        }else if collectionView == clcView2{
            cell = clcView2.dequeueReusableCell(withReuseIdentifier: "cellid", for: indexPath) as! CategoryCollectionViewCell
            if arrSelected2.contains(indexPath.row) {
                cell.viewCellBack.backgroundColor = UIColor.black.withAlphaComponent(0.4)
                cell.lblTitleProfession.textColor = UIColor.white
            }else{
                cell.viewCellBack.backgroundColor = UIColor.clear
                cell.lblTitleProfession.textColor = UIColor.black.withAlphaComponent(0.5)
            }
            cell.lblTitleProfession.text = arr2[indexPath.row]
        }else if collectionView == clcView3{
            cell = clcView3.dequeueReusableCell(withReuseIdentifier: "cellid", for: indexPath) as! CategoryCollectionViewCell
            if arrSelected3.contains(indexPath.row) {
                cell.viewCellBack.backgroundColor = UIColor.black.withAlphaComponent(0.4)
                cell.lblTitleProfession.textColor = UIColor.white
            }else{
                cell.viewCellBack.backgroundColor = UIColor.clear
                cell.lblTitleProfession.textColor = UIColor.black.withAlphaComponent(0.5)
            }
            cell.lblTitleProfession.text = arr3[indexPath.row]
        }else if collectionView == clcView4{
            cell = clcView4.dequeueReusableCell(withReuseIdentifier: "cellid", for: indexPath) as! CategoryCollectionViewCell
            if arrSelected4.contains(indexPath.row) {
                cell.viewCellBack.backgroundColor = UIColor.black.withAlphaComponent(0.4)
                cell.lblTitleProfession.textColor = UIColor.white
            }else{
                cell.viewCellBack.backgroundColor = UIColor.clear
                cell.lblTitleProfession.textColor = UIColor.black.withAlphaComponent(0.5)
            }
            cell.lblTitleProfession.text = arr4[indexPath.row]
        }else {
            cell = clcView5.dequeueReusableCell(withReuseIdentifier: "cellid", for: indexPath) as! CategoryCollectionViewCell
            if arrSelected5.contains(indexPath.row) {
                cell.viewCellBack.backgroundColor = UIColor.black.withAlphaComponent(0.4)
                cell.lblTitleProfession.textColor = UIColor.white
            }else{
                cell.viewCellBack.backgroundColor = UIColor.clear
                cell.lblTitleProfession.textColor = UIColor.black.withAlphaComponent(0.5)
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
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "Playlist_MainVC")as! Playlist_MainVC
                self.navigationController?.pushViewController(vc, animated: false)
            }else  if indexPath.row == 2{
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "ArtistVC")as! ArtistVC
                self.navigationController?.pushViewController(vc, animated: false)
            }else  if indexPath.row == 3{
//                let vc = self.storyboard?.instantiateViewController(withIdentifier: "AlbumsVC")as! AlbumsVC
//                self.navigationController?.pushViewController(vc, animated: false)
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

// MARK:- Table cell class  Albums
class AlbumsTblcell: UITableViewCell,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var clcViewMain: UICollectionView!
    @IBOutlet weak var heightContrintsClcMain: NSLayoutConstraint!
    let Kheight:CGFloat = 145
    var Controller :UIViewController? = nil
    var obj = AlbumViewModel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // disable scroll because we dont want collectionview to be scrolled inside cell
        clcViewMain.isScrollEnabled = false
        clcViewMain.dataSource = self
        clcViewMain.delegate = self
        heightContrintsClcMain.constant = ((20/3)*Kheight)+Kheight
        self.clcViewMain.layoutIfNeeded()
    }
    
    func setVC(vc:UIViewController,obj2:AlbumViewModel){
       Controller = vc
        self.obj = obj2
        clcViewMain.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return obj.AlbumCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = clcViewMain.dequeueReusableCell(withReuseIdentifier: "cellid", for: indexPath) as! AlbumsClccell
        cell.lblHash.text = "#"+String(indexPath.row+1)
        cell.lbl1.text = "Album"
        cell.lbl2.text = obj.albumName(Index: indexPath.row)
        cell.lbl3.text = obj.SongsCountInAlbum(Index: indexPath.row)
       // cell.imgAlbum
        
        cell.btnMore.tag = indexPath.row
        return cell
    }
     func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard Controller != nil else{
            return
        }
        let vc = Controller?.storyboard?.instantiateViewController(withIdentifier: "AlbumDetailVC")as! AlbumDetailVC
        obj.FillSongsArr(Index: indexPath.row)
        vc.objAlbumViewModel2 = obj
        Controller?.navigationController?.pushViewController(vc, animated: true)
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.size.width/3.4, height: Kheight)
    }
    
}

class AlbumsClccell:UICollectionViewCell{
    
    @IBOutlet weak var lblHash: UILabel!
    @IBOutlet weak var lbl1: UILabel!
    
    @IBOutlet weak var imgAlbum: UIImageView!
    @IBOutlet weak var lbl2: UILabel!
    @IBOutlet weak var lbl3: UILabel!
    
    @IBOutlet weak var btnMore: UIButton!
    
}
