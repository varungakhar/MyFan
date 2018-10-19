//
//  SeeAllSingrsVC.swift
//  MyFan
//
//  Created by user on 19/09/18.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit

class SeeAllSingrsVC: UIViewController {

    @IBOutlet weak var tblview: UITableView!
    
    @IBOutlet weak var clcView: UICollectionView!
    
    
    @IBOutlet weak var clcHeightConst: NSLayoutConstraint!
    @IBOutlet weak var viewTblHeader: UIView!
    
       let arr5 = ["Artists From Everywhere","USA","Australia","England","India","Canada","USA","Japan","China"]
    var selectedBtnIndex = 1
    var  Selected1 = 1
     
    override func viewDidLoad() {
        super.viewDidLoad()

        tblview.delegate = self
        tblview.dataSource = self
        tblview.estimatedRowHeight = 50
        tblview.rowHeight = UITableViewAutomaticDimension
        
        clcView.delegate = self
        clcView.dataSource = self
//

        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func btnLocationAction(_ sender: Any) {
        if clcHeightConst.constant == 49{
           clcHeightConst.constant = 0
            viewTblHeader.frame.size.height = 0
        }else{
            clcHeightConst.constant = 49
            viewTblHeader.frame.size.height = 49
        }
        self.view.layoutIfNeeded()
        tblview.reloadData()
    }
    @IBAction func btnBackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func btnHeaderActions(_ sender: UIButton) {
 
        //let sectionToReload = 0
        //        let indexSet: IndexSet = [0,0]
        //        tblViewDashBoard.reloadSections(indexSet, with: .fade)
        selectedBtnIndex = sender.tag
        tblview.reloadData()
    }
    @IBAction func btnSubscribeSingerAction(_ sender: UIButton) {
        
    }
    
    
}

extension SeeAllSingrsVC:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(objMusicViewModel.NearByArtistCount())
        return objMusicViewModel.NearByArtistCount()
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblview.dequeueReusableCell(withIdentifier: "cellid")as! SeeAllSingrstblCell
        cell.imgSinger.kf.indicatorType = .activity
        cell.imgSinger.kf.setImage(with: URL(string: objMusicViewModel.NearByArtistImage(Index: indexPath.row)))
        cell.lblNameSInger.text = objMusicViewModel.NearByArtistfullName(Index: indexPath.row)
        cell.lblAbtSinger.text = objMusicViewModel.NearByArtistAbout(Index: indexPath.row)
        
        
        cell.btnSubscribeSinger.tag = indexPath.row
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableViewAutomaticDimension
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let cell = tblview.dequeueReusableCell(withIdentifier: "cellidHeader")as! DashboardTableViewCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 50
    }
}

extension SeeAllSingrsVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int)->Int{
        return arr5.count
}
func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    var cell =  CategoryCollectionViewCell()
   
        cell = clcView.dequeueReusableCell(withReuseIdentifier: "cellid", for: indexPath) as! CategoryCollectionViewCell
        cell.lblTitleProfession.text = arr5[indexPath.row]
        if Selected1 == indexPath.row{
            cell.viewCellBack.backgroundColor = systemcolor
            cell.lblTitleProfession.textColor = UIColor.white
        }else{
            cell.viewCellBack.backgroundColor = cellbgcolor
            cell.lblTitleProfession.textColor = systemcolor
     }
         return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        Selected1 = indexPath.row
        tblview.reloadData()
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
         let  str = arr5[indexPath.row]
        return CGSize(width: str.widthOfString(), height: collectionView.frame.size.height-5)
}
}
class SeeAllSingrstblCell:UITableViewCell{
    
    @IBOutlet weak var imgSinger: UIImageView!
    
    @IBOutlet weak var lblNameSInger: UILabel!
    
    @IBOutlet weak var lblAbtSinger: UILabel!
    
    @IBOutlet weak var btnSubscribeSinger: ButtonCustom!
}
