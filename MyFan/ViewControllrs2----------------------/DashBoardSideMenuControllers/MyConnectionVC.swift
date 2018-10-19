//
//  MyConnectionVC.swift
//  MyFan
//
//  Created by user on 14/09/18.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit

class MyConnectionVC: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var tblNtwrk: UITableView!
    @IBOutlet weak var tblMyFans: UITableView!
    @IBOutlet weak var tblConnect: UITableView!
    @IBOutlet weak var tblRequests: UITableView!
    
    @IBOutlet weak var lblLine: UILabel!
    @IBOutlet weak var lblLineLeadingConst: NSLayoutConstraint!
    
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

       tblNtwrk.delegate = self
        tblNtwrk.dataSource = self
        tblMyFans.delegate = self
        tblMyFans.dataSource = self
        tblConnect.delegate = self
        tblConnect.dataSource = self
        tblRequests.delegate = self
        tblRequests.dataSource = self
        
        
        tblNtwrk.addSubview(refreshControl)
        tblMyFans.addSubview(refreshControl)
        tblConnect.addSubview(refreshControl)
        tblRequests.addSubview(refreshControl)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnActions(_ sender: UIButton) {
       
        if sender.tag == 101{
           selectedBtnIndex = 1
        }else if sender.tag == 102{
            selectedBtnIndex = 2
        }else if sender.tag == 103{
             selectedBtnIndex = 3
        }else if sender.tag == 104{
             selectedBtnIndex = 4
        }
         scrollView.contentOffset.x = CGFloat(selectedBtnIndex-1) * UIScreen.main.bounds.width
        lblLineLeadingConst.constant = (UIScreen.main.bounds.width/4)*CGFloat(selectedBtnIndex-1)
        self.view.layoutIfNeeded()
        GetData(tab: selectedBtnIndex, Referesh: true)
    }
    
    
    func GetData(tab:Int,Referesh:Bool){
//        if tab == 1{
//
//        }else if tab == 2{
//
//        }else if tab == 3{
//
//        }else if tab == 4{
//
//
//        }
        objConnection.GetConnectionData(tab: tab, Refresh: Referesh, vc: self) { (responce, msg) in
                    if tab == 1{
                        self.tblNtwrk.reloadData()
                    }else if tab == 2{
                        self.tblMyFans.reloadData()
                    }else if tab == 3{
                        self.tblConnect.reloadData()
                    }else if tab == 4{
                        self.tblRequests.reloadData()
            
                    }
        }
        
    }
    
    
    
    @IBAction func btnBackAction(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "DashboardViewController")as! DashboardViewController
        self.navigationController?.pushViewController(vc, animated: false)
    }
}

extension MyConnectionVC:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == tblNtwrk{
           return 5
        }else if  tableView == tblMyFans{
           return 5
        }else if  tableView == tblConnect{
           return 5
        }else if  tableView == tblRequests{
            return 5
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell :UITableViewCell = CommonMyConnectionTblCell()
        if tableView == tblNtwrk{
            cell = tblNtwrk.dequeueReusableCell(withIdentifier: "cellid")as! CommonMyConnectionTblCell
        }else if  tableView == tblMyFans{
           cell = tblMyFans.dequeueReusableCell(withIdentifier: "cellid")as! CommonMyConnectionTblCell
        }else if  tableView == tblConnect{
            cell = tblConnect.dequeueReusableCell(withIdentifier: "cellid")as! CommonMyConnectionTblCell
        }else if  tableView == tblRequests{
           cell = tblRequests.dequeueReusableCell(withIdentifier: "cellid")as! CommonMyConnectionTblCell
        }
        return cell
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
         var headerCell :UITableViewCell = CommonMyConnectionTblCell()
        if  tableView == tblConnect || tableView ==  tblNtwrk{
         headerCell = tableView.dequeueReusableCell(withIdentifier: "cellHeader")as! CommonMyConnectionTblCell
      
        }
          return headerCell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if  tableView == tblConnect || tableView ==  tblNtwrk{
            
            return 40
        }else{
           return 0
        }
    }
}
class CommonMyConnectionTblCell:UITableViewCell{
    
}
