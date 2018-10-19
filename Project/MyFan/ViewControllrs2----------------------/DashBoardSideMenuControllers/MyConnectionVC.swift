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
    
  private  lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
            #selector(MyConnectionVC.handleRefresh(_:)),
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
        GetData(tab: selectedBtnIndex, Referesh: true)
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
        GetData(tab: selectedBtnIndex, Referesh: false)
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
 
        // refresh
    }
    
    func GetData(tab:Int,Referesh:Bool){

       
                    if tab == 1{
                        objConnection.GetMyNetworkData(Refresh: Referesh, vc: self, completion: { (responce, msg) in
                           self.tblNtwrk.reloadData()
                        })
                       
                    }else if tab == 2{
                        objConnection.GetMyFanData(Refresh: Referesh, vc: self, completion: { (responce, msg) in
                            self.tblMyFans.reloadData()
                        })
                        
                    }else if tab == 3{
                        objConnection.GetConnection_SuggestionsData(Refresh: Referesh, vc: self, completion: { (responce, msg) in
                            self.tblConnect.reloadData()
                        })
                        
                       
                    }else if tab == 4{
                        objConnection.GetReceivedRequestsData(Refresh: Referesh, vc: self, completion: { (responce, msg) in
                             self.tblRequests.reloadData()
                        })
                        
                       
            
                    }
        
        
    }
    // cell 1
    
    @IBAction func btnMessageAction(_ sender: UIButton) {
        
    }
    
     // cell 3
    @IBAction func btnConnectAction(_ sender: UIButton) {
    }
    // cell 2
    @IBAction func btnMessageConnectAction(_ sender: UIButton) {
    }
     // cell 4
    @IBAction func btnPendingAction(_ sender: UIButton) {
    }
    
    @IBAction func btnBackAction(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "DashboardViewController")as! DashboardViewController
        self.navigationController?.pushViewController(vc, animated: false)
    }
}

extension MyConnectionVC:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == tblNtwrk{
           return objConnection.myNetworkCount()
        }else if  tableView == tblMyFans{
           return objConnection.MyFansCount()
        }else if  tableView == tblConnect{
            return objConnection.Connection_SuggestionsCount()
        }else if  tableView == tblRequests{
             return objConnection.ReceivedRequestsCount()
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = CommonMyConnectionTblCell()
        if tableView == tblNtwrk{
            cell = tblNtwrk.dequeueReusableCell(withIdentifier: "cellid")as! CommonMyConnectionTblCell
            
            cell.imgUser.kf.indicatorType = .activity
            cell.imgUser.kf.setImage(with: URL(string: objConnection.profile_image_url_MyNetwork(Index:indexPath.row)))
            cell.lblName.text = objConnection.userNameMyNetwork(Index:indexPath.row)
            cell.lblDetail.text = objConnection.professional_text_lineMyNetwork(Index:indexPath.row)
            cell.lblMutualConnections.text = objConnection.mutualConnectionsMyNetwork(Index:indexPath.row)

//            fullNameMyConnections
//
//
            
        }else if  tableView == tblMyFans{
           cell = tblMyFans.dequeueReusableCell(withIdentifier: "cellid")as! CommonMyConnectionTblCell
            cell.imgUser.kf.indicatorType = .activity
            cell.imgUser.kf.setImage(with: URL(string: objConnection.profile_image_url_MyFans(Index:indexPath.row)))
            
            cell.lblName.text = objConnection.userNameMyFans(Index:indexPath.row)
            
            cell.lblDetail.text = objConnection.professional_text_lineMyFans(Index:indexPath.row)
            
            cell.lblMutualConnections.text = objConnection.mutualConnectionsMyFans(Index:indexPath.row)
            
        }else if  tableView == tblConnect{
            cell = tblConnect.dequeueReusableCell(withIdentifier: "cellid")as! CommonMyConnectionTblCell
            cell.imgUser.kf.indicatorType = .activity
            cell.imgUser.kf.setImage(with: URL(string: objConnection.profile_image_url_Connection_Suggestions(Index:indexPath.row)))
            cell.lblName.text = objConnection.userNameConnection_Suggestions(Index:indexPath.row)
            cell.lblDetail.text = objConnection.professional_text_lineConnection_Suggestions(Index:indexPath.row)
            cell.lblMutualConnections.text = objConnection.mutualConnectionsConnection_Suggestions(Index:indexPath.row)
        }else if  tableView == tblRequests{
           cell = tblRequests.dequeueReusableCell(withIdentifier: "cellid")as! CommonMyConnectionTblCell
            cell.imgUser.kf.indicatorType = .activity
            cell.imgUser.kf.setImage(with: URL(string: objConnection.profile_image_url_ReceivedRequests(Index:indexPath.row)))
            
            cell.lblName.text = objConnection.userNameReceivedRequests(Index:indexPath.row)
            
            cell.lblDetail.text = objConnection.professional_text_lineReceivedRequests(Index:indexPath.row)
            
            cell.lblMutualConnections.text = objConnection.mutualConnectionsReceivedRequests(Index:indexPath.row)
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
    
    
    @IBOutlet weak var imgUser: ImageCustom!
    
    @IBOutlet weak var lblName: UILabel!
    
    @IBOutlet weak var lblDetail: UILabel!
    
    @IBOutlet weak var lblMutualConnections: UILabel!
    // cell 1
    @IBOutlet weak var btnMessage: ButtonCustom!
    // cell 2
    @IBOutlet weak var btnMessageConnect: ButtonCustom!
     // cell 3
    @IBOutlet weak var btnConnect: ButtonCustom!
    
    // cell 4
    @IBOutlet weak var btnPending: ButtonCustom!
}
