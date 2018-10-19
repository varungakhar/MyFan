//
//  MyFansVC.swift
//  MyFan
//
//  Created by user on 19/09/18.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit

class MyFansVC: UIViewController {

    @IBOutlet weak var tblvVew: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

       
        tblvVew.delegate = self
        tblvVew.dataSource = self
        tblvVew.estimatedRowHeight = 50
        tblvVew.rowHeight = UITableViewAutomaticDimension
    
    }
    @IBAction func btnBackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
extension MyFansVC:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblvVew.dequeueReusableCell(withIdentifier: "cellid")!
        return cell
}
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableViewAutomaticDimension
    }
}
