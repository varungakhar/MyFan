//
//  PaymentsScreenVC.swift
//  MyFan
//
//  Created by user on 06/10/18.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit

class PaymentsScreenVC: UIViewController {

    @IBOutlet var btnUppers: [UIButton]!
    @IBOutlet weak var lblLine: UILabel!
    @IBOutlet weak var lblAvailableBalence: UILabel!
    @IBOutlet weak var tblAll: UITableView!
    @IBOutlet weak var tblUnpaid: UITableView!
    @IBOutlet weak var tblPending: UITableView!
    @IBOutlet weak var tblPayments: UITableView!
    
    @IBOutlet weak var lblLineLeadingConst: NSLayoutConstraint!
    @IBOutlet weak var scrllView: UIScrollView!
    var selectedBtnIndex = 0
    override func viewDidLoad() {
        super.viewDidLoad()

        scrllView.delegate = self
        tblAll.delegate = self
        tblAll.dataSource = self
        tblUnpaid.delegate = self
        tblUnpaid.dataSource = self
        tblPending.delegate = self
        tblPending.dataSource = self
        tblPayments.delegate = self
        tblPayments.dataSource = self
        setPage(Tab:0)
        
    }

    @IBAction func btnSectionAll(_ sender: UIButton) {
    }
    
    @IBAction func btnUppersAction(_ sender: UIButton) {
      
       setPage(Tab:sender.tag)
    }
    
    
    func setPage(Tab:Int){
        selectedBtnIndex = Tab
        
        scrllView.contentOffset.x = CGFloat(selectedBtnIndex) * UIScreen.main.bounds.width
        lblLineLeadingConst.constant = (UIScreen.main.bounds.width/4)*CGFloat(selectedBtnIndex)
        lblLine.layoutIfNeeded()
        for i in 0 ..< btnUppers.count{
            if i == selectedBtnIndex{
                btnUppers[i].setTitleColor(UIColor.black.withAlphaComponent(1.0), for: .normal)
            }else{
                btnUppers[i].setTitleColor(UIColor.black.withAlphaComponent(0.3), for: .normal)
            }
        }
    }
    
    @IBAction func btnMoneyInAction(_ sender: UIButton) {
    }
    @IBAction func btnMoneyOutAction(_ sender: UIButton) {
    }
    
    @IBAction func btnBackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

  

}

extension PaymentsScreenVC:UIScrollViewDelegate{
    
    // MARK:- Scroll view delegates
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
         if scrollView != tblAll && scrollView != tblUnpaid && scrollView != tblPending && scrollView != tblPayments {
        lblLine.frame.origin = CGPoint(x: scrollView.contentOffset.x/4, y: lblLine.frame.origin.y)
        
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        //  sdsdsdsdsd
    }
    
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView != tblAll && scrollView != tblUnpaid && scrollView != tblPending && scrollView != tblPayments {
        let page = Int(round(scrollView.contentOffset.x/scrollView.frame.width))
        setPage(Tab: page)
        }
    }
}

extension PaymentsScreenVC:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == tblAll{
            return 5
        }else if  tableView == tblUnpaid{
            return 5
        }else if  tableView == tblPending{
            return 5
        }else if  tableView == tblPayments{
            return 5
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell :UITableViewCell = PaymentsScreenTblCell()
        if tableView == tblAll{
            cell = tblAll.dequeueReusableCell(withIdentifier: "cellid")as! PaymentsScreenTblCell
        }else if  tableView == tblUnpaid{
            cell = tblUnpaid.dequeueReusableCell(withIdentifier: "cellid")as! PaymentsScreenTblCell
        }else if  tableView == tblPending{
            cell = tblPending.dequeueReusableCell(withIdentifier: "cellid")as! PaymentsScreenTblCell
        }else if  tableView == tblPayments{
            cell = tblPayments.dequeueReusableCell(withIdentifier: "cellid")as! PaymentsScreenTblCell
        }
        return cell
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
       
        if tableView == tblAll{
           let cell = tblAll.dequeueReusableCell(withIdentifier: "cellHeader")as! PaymentsScreenHeaderTblCell
             return cell
        }else if  tableView == tblUnpaid{
           let cell = tblUnpaid.dequeueReusableCell(withIdentifier: "cellHeader")as! PaymentsScreenHeaderTblCell
             return cell
        }else if  tableView == tblPending{
           let cell = tblPending.dequeueReusableCell(withIdentifier: "cellHeader")as! PaymentsScreenHeaderTblCell
             return cell
        }else {
           let cell = tblPayments.dequeueReusableCell(withIdentifier: "cellHeader")as! PaymentsScreenHeader2TblCell
             return cell
        }
       
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if  tableView != tblPayments {
            
            return 85
        }else{
            return 75
        }
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if  tableView != tblPayments {

            return 40
        }else{
            return 55
        }
    }
}




class PaymentsScreenTblCell:UITableViewCell{
    
    @IBOutlet weak var imgUser: ImageCustom!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDetail: UILabel!
    @IBOutlet weak var lblPhotos: UILabel!
    @IBOutlet weak var lblAmount: UILabel!
    
}

class PaymentsScreenHeaderTblCell:UITableViewCell{
    
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var imgArrow: UIImageView!
    @IBOutlet weak var btnSection: UIButton!
}

class PaymentsScreenHeader2TblCell:UITableViewCell{
    
    @IBOutlet weak var btnMoneyIn: ButtonCustom!
    @IBOutlet weak var btnMoneyOut: ButtonCustom!
}


