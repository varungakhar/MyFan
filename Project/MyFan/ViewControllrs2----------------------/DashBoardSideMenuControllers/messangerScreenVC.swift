//
//  messangerScreenVC.swift
//  MyFan
//
//  Created by user on 05/10/18.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit

class messangerScreenVC: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var txtSearch: UITextField!
    @IBOutlet weak var tblMessage: UITableView!
    @IBOutlet weak var tblActive: UITableView!
  @IBOutlet weak var ClcGroups: UICollectionView!
    @IBOutlet weak var tblRequests: UITableView!
    @IBOutlet weak var lblLine: UILabel!
    @IBOutlet weak var lblLineLeadingConst: NSLayoutConstraint!
    
    @IBOutlet var btnsHeader: [UIButton]!
    
    
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
    let objConnection = MyConnectionViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()

        scrollView.delegate = self
        tblMessage.delegate = self
        tblMessage.dataSource = self
        tblActive.delegate = self
        tblActive.dataSource = self
        ClcGroups.delegate = self
        ClcGroups.dataSource = self
        tblRequests.delegate = self
        tblRequests.dataSource = self
        
        
        tblMessage.addSubview(refreshControl)
        tblActive.addSubview(refreshControl)
        ClcGroups.addSubview(refreshControl)
        tblRequests.addSubview(refreshControl)
        setPage(tab: 0)
    }

    
    
    @IBAction func btnActions(_ sender: UIButton) {
        
        setPage(tab: selectedBtnIndex)
       
    }
    
    func setPage(tab:Int){
        selectedBtnIndex = tab
        
        scrollView.contentOffset.x = CGFloat(selectedBtnIndex) * UIScreen.main.bounds.width
        lblLineLeadingConst.constant = (UIScreen.main.bounds.width/4)*CGFloat(selectedBtnIndex)
        lblLine.layoutIfNeeded()
        for i in 0 ..< btnsHeader.count{
            if i == selectedBtnIndex{
                btnsHeader[i].setTitleColor(UIColor.black.withAlphaComponent(1.0), for: .normal)
            }else{
                btnsHeader[i].setTitleColor(UIColor.black.withAlphaComponent(0.3), for: .normal)
            }
        }
        
        // MARK:- Api Calling
         GetData(tab: selectedBtnIndex, Referesh: true)
    }
    
    func GetData(tab:Int,Referesh:Bool){
                if tab == 1{
        
                }else if tab == 2{
        
                }else if tab == 3{
        
                }else if tab == 4{
        
        
                }
        
    }
    @IBAction func btnBackAction(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "DashboardViewController")as! DashboardViewController
        self.navigationController?.pushViewController(vc, animated: false)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
extension messangerScreenVC:UIScrollViewDelegate{
    
    // MARK:- Scroll view delegates
    
        func scrollViewDidScroll(_ scrollView: UIScrollView) {
      if scrollView != tblMessage && scrollView != tblActive && scrollView != ClcGroups && scrollView != tblRequests {
            lblLine.frame.origin = CGPoint(x: scrollView.contentOffset.x/4, y: lblLine.frame.origin.y)
    
        }
     
    }
        func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
          //  sdsdsdsdsd
        }
    
    
        func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
             if scrollView != tblMessage && scrollView != tblActive && scrollView != ClcGroups && scrollView != tblRequests {
            let page = Int(round(scrollView.contentOffset.x/scrollView.frame.width))
    
          selectedBtnIndex = page
            
          setPage(tab: selectedBtnIndex)
        }
    }
}



extension messangerScreenVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    // MARK:- collection view delegates and datasource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       
            return 6
        
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
            let  cell = ClcGroups.dequeueReusableCell(withReuseIdentifier: "cellid", for: indexPath)as! MessangerScreenClcCell
    
            return cell
  
       }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
      
            return CGSize(width: collectionView.frame.size.width/2.4, height: 210)
        
    }
    
    
}


extension messangerScreenVC:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == tblMessage{
            return 5
        }else if  tableView == tblActive{
            return 5
        }else if  tableView == tblRequests{
            return 5
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell :UITableViewCell = CommonMyConnectionTblCell()
        if tableView == tblMessage{
            cell = tblMessage.dequeueReusableCell(withIdentifier: "cellid")as! CommonMessangerScreenTblCell
        }else if  tableView == tblActive{
            cell = tblActive.dequeueReusableCell(withIdentifier: "cellid")as! CommonMessangerScreenTblCell
        }else if  tableView == tblRequests{
            cell = tblRequests.dequeueReusableCell(withIdentifier: "cellid")as! CommonMessangerScreenTblCell
        }
        return cell
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var headerCell :UITableViewCell = CommonMyConnectionTblCell()
        if  tableView == tblMessage {
            headerCell = tblMessage.dequeueReusableCell(withIdentifier: "cellHeader")as! CommonMessangerHeaderTblCell
            
        }
        return headerCell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if  tableView == tblMessage {
            
            return 40
        }else{
            return 0
        }
    }
}
class CommonMessangerScreenTblCell:UITableViewCell{
    
    @IBOutlet weak var imgUser: ImageCustom!
    @IBOutlet weak var lblname: UILabel!
    @IBOutlet weak var lbldetail: UILabel!
    @IBOutlet weak var lbltime: UILabel!
    
    @IBOutlet weak var imgGreenDot: UIImageView!
    
    @IBOutlet weak var btnReject: ButtonCustom!
    
}
class CommonMessangerHeaderTblCell:UITableViewCell{
    
}
class MessangerScreenClcCell:UICollectionViewCell{
    @IBOutlet weak var lbl1: UILabel!
    @IBOutlet weak var imgUser: ImageCustom!
    @IBOutlet weak var lbl2: UILabel!
    @IBOutlet weak var lbl3: UILabel!
    
}








