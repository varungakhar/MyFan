//
//  SendReceiveMoneyVC.swift
//  MyFan
//
//  Created by user on 06/10/18.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit

class SendReceiveMoneyVC: UIViewController {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var txtSearch: UITextField!
    @IBOutlet weak var tblView: UITableView!
    var strTitle = String()
    override func viewDidLoad() {
        super.viewDidLoad()

       lblTitle.text = strTitle
        tblView.delegate = self
        tblView.dataSource = self
    }
    
    
    @IBAction func btnBackAction(_ sender: Any) {
         self.navigationController?.popViewController(animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}


extension SendReceiveMoneyVC:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tblView.dequeueReusableCell(withIdentifier: "cellid")as! SendReceiveMoneyTblCell
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       
            return 75
        
    }
 
}



class SendReceiveMoneyTblCell: UITableViewCell {
    @IBOutlet weak var imgUser: ImageCustom!
    
    @IBOutlet weak var lbl2: UILabel!
    
    @IBOutlet weak var lbl3: UILabel!
    
}
