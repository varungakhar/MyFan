//
//  NotificationScreenVC.swift
//  MyFan
//
//  Created by user on 06/10/18.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit

class NotificationScreenVC: UIViewController {
  @IBOutlet weak var tblView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
      
        tblView.delegate = self
        tblView.dataSource = self
        tblView.estimatedRowHeight = 60
        tblView.rowHeight = UITableViewAutomaticDimension
    }

    @IBAction func btnMoreAction(_ sender: UIButton) {
        
        
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



extension NotificationScreenVC:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tblView.dequeueReusableCell(withIdentifier: "cellid")as! NotificationScreenTblCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableViewAutomaticDimension
        
    }
    
}
class NotificationScreenTblCell:UITableViewCell{
    
    @IBOutlet weak var imgUser: ImageCustom!
    @IBOutlet weak var lbl1: UILabel!
    @IBOutlet weak var lbl2: UILabel!
    @IBOutlet weak var imgMore: UIImageView!
    @IBOutlet weak var btnMore: UIButton!
}
