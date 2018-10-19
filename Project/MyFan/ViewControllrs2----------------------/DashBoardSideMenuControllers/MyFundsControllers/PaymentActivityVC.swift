//
//  PaymentActivityVC.swift
//  MyFan
//
//  Created by user on 06/10/18.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit

class PaymentActivityVC: UIViewController {

    @IBOutlet var BtnUpper: [UIButton]!
    @IBOutlet weak var lblLine: UILabel!
    
    @IBOutlet weak var scrollview: UIScrollView!
    @IBOutlet weak var tblViewAll: UITableView!
    @IBOutlet weak var tblUnpaid: UITableView!
    @IBOutlet weak var tblMoneyOut: UITableView!
    
    @IBOutlet weak var lblLineLeadingConst: NSLayoutConstraint!
    var selectedBtnIndex = 0
    override func viewDidLoad() {
        super.viewDidLoad()

        scrollview.delegate = self
        tblViewAll.delegate = self
        tblViewAll.dataSource = self
        tblUnpaid.delegate = self
        tblUnpaid.dataSource = self
        tblMoneyOut.delegate = self
        tblMoneyOut.dataSource = self
     setPage(Tab:0)
        
    }
    
    @IBAction func BtnUpperAction(_ sender: UIButton) {
        setPage(Tab:sender.tag)
    }
    
    @IBAction func btnBackAction(_ sender: Any) {
         self.navigationController?.popViewController(animated: true)
    }
    
    func setPage(Tab:Int){
        selectedBtnIndex = Tab
        
        scrollview.contentOffset.x = CGFloat(selectedBtnIndex) * UIScreen.main.bounds.width
        lblLineLeadingConst.constant = (UIScreen.main.bounds.width/3)*CGFloat(selectedBtnIndex)
        lblLine.layoutIfNeeded()
        for i in 0 ..< BtnUpper.count{
            if i == selectedBtnIndex{
                BtnUpper[i].setTitleColor(UIColor.black.withAlphaComponent(1.0), for: .normal)
            }else{
                BtnUpper[i].setTitleColor(UIColor.black.withAlphaComponent(0.3), for: .normal)
            }
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}


extension PaymentActivityVC:UIScrollViewDelegate{
    
    // MARK:- Scroll view delegates
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView != tblViewAll && scrollView != tblUnpaid && scrollView != tblMoneyOut {
        lblLine.frame.origin = CGPoint(x: scrollView.contentOffset.x/3, y: lblLine.frame.origin.y)
        
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        //  sdsdsdsdsd
    }
    
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
         if scrollView != tblViewAll && scrollView != tblUnpaid && scrollView != tblMoneyOut {
        let page = Int(round(scrollView.contentOffset.x/scrollView.frame.width))
        setPage(Tab: page)
        }
    }
}

extension PaymentActivityVC:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == tblViewAll{
            return 5
        }else if  tableView == tblUnpaid{
            return 5
        }else if  tableView == tblMoneyOut{
            return 5
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell :UITableViewCell = PaymentActivityTblCell()
        if tableView == tblViewAll{
            cell = tblViewAll.dequeueReusableCell(withIdentifier: "cellid")as! PaymentActivityTblCell
        }else if  tableView == tblUnpaid{
            cell = tblUnpaid.dequeueReusableCell(withIdentifier: "cellid")as! PaymentActivityTblCell
        }else if  tableView == tblMoneyOut{
            cell = tblUnpaid.dequeueReusableCell(withIdentifier: "cellid")as! PaymentActivityTblCell
        }
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       
            return 75
     
    }

}




class PaymentActivityTblCell:UITableViewCell{
    
    @IBOutlet weak var imgUser: ImageCustom!
    @IBOutlet weak var lbl1: UILabel!
    @IBOutlet weak var lbl2: UILabel!
    @IBOutlet weak var lblAmount: UILabel!
}
