//
//  MyBuzzScreenVC.swift
//  MyFan
//
//  Created by user on 06/10/18.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit

class MyBuzzScreenVC: UIViewController {
    @IBOutlet weak var txtSearch: UITextField!
    @IBOutlet weak var tblView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        tblView.delegate = self
        tblView.dataSource = self
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




extension MyBuzzScreenVC:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tblView.dequeueReusableCell(withIdentifier: "cellid")as! MyBuzzScreenTblCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
         let cell = tblView.dequeueReusableCell(withIdentifier: "cellHeader")as! MyBuzzScreenHeaderCell
            return cell
    
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 135
        
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
         return 50
    }
}


class MyBuzzScreenTblCell:UITableViewCell{
    
}
class MyBuzzScreenHeaderCell:UITableViewCell{
    
    
    
    
}
