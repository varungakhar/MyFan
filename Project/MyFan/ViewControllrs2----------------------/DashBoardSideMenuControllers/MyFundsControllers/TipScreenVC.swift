//
//  TipScreenVC.swift
//  MyFan
//
//  Created by user on 06/10/18.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit

class TipScreenVC: UIViewController {
    

    @IBOutlet weak var txtSearch: UITextField!
    @IBOutlet var btnUpper: [UIButton]!
    @IBOutlet weak var lblLine: UILabel!
    @IBOutlet weak var scrollview: UIScrollView!
    
    @IBOutlet weak var tblViewPayments: UITableView!
    @IBOutlet weak var tblViewConnections: UITableView!
    @IBOutlet weak var tblViewPublic: UITableView!
    
    @IBOutlet weak var lblLineLeadingConst: NSLayoutConstraint!
     var selectedBtnIndex = 0
    override func viewDidLoad() {
        super.viewDidLoad()

        scrollview.delegate = self
        tblViewPayments.delegate = self
        tblViewPayments.dataSource = self
        tblViewConnections.delegate = self
        tblViewConnections.dataSource = self
        tblViewPublic.delegate = self
        tblViewPublic.dataSource = self
        
        setPage(Tab:0)
    }

    @IBAction func upperbtnActions(_ sender: UIButton) {
        //101
        setPage(Tab:sender.tag)
    }
    func setPage(Tab:Int){
        selectedBtnIndex = Tab
        
        scrollview.contentOffset.x = CGFloat(selectedBtnIndex) * UIScreen.main.bounds.width
        lblLineLeadingConst.constant = (UIScreen.main.bounds.width/3)*CGFloat(selectedBtnIndex)
        lblLine.layoutIfNeeded()
        for i in 0 ..< btnUpper.count{
            if i == selectedBtnIndex{
                btnUpper[i].setTitleColor(UIColor.black.withAlphaComponent(1.0), for: .normal)
            }else{
                btnUpper[i].setTitleColor(UIColor.black.withAlphaComponent(0.3), for: .normal)
            }
        }
    }
    @IBAction func btnLikeAction(_ sender: UIButton) {
    }
    
    @IBAction func btnDisLikeAction(_ sender: UIButton) {
    }
    
    @IBAction func btnCommentAction(_ sender: UIButton) {
    }
    

    @IBAction func btnBackAction(_ sender: Any) {
         self.navigationController?.popViewController(animated: true)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}

extension TipScreenVC:UIScrollViewDelegate{
    
    // MARK:- Scroll view delegates
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
         if scrollView != tblViewPayments && scrollView != tblViewConnections && scrollView != tblViewPublic {
        lblLine.frame.origin = CGPoint(x: scrollView.contentOffset.x/3, y: lblLine.frame.origin.y)
        
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        //  sdsdsdsdsd
    }
    
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
          if scrollView != tblViewPayments && scrollView != tblViewConnections && scrollView != tblViewPublic {
        let page = Int(round(scrollView.contentOffset.x/scrollView.frame.width))
        setPage(Tab: page)
        
    }
    }
}

extension TipScreenVC:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == tblViewPayments{
            return 5
        }else if  tableView == tblViewConnections{
            return 5
        }else if  tableView == tblViewPublic{
            return 5
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell :UITableViewCell = TipScreenTblCell()
        if tableView == tblViewPayments{
            cell = tblViewPayments.dequeueReusableCell(withIdentifier: "cellid")as! TipScreenTblCell
        }else if  tableView == tblViewConnections{
            cell = tblViewConnections.dequeueReusableCell(withIdentifier: "cellid")as! TipScreenTblCell
        }else if  tableView == tblViewPublic{
            cell = tblViewPublic.dequeueReusableCell(withIdentifier: "cellid")as! TipScreenTblCell
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 140
        
    }
    
}


class TipScreenTblCell:UITableViewCell{
  
    @IBOutlet weak var imgUser: ImageCustom!
    @IBOutlet weak var lbl1: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblAmount: UILabel!
    @IBOutlet weak var imgEarth: UIImageView!
    @IBOutlet weak var lblDetail: UILabel!
    
    @IBOutlet weak var imgLike: UIImageView!
    @IBOutlet weak var lblLike: UILabel!
    @IBOutlet weak var btnLike: UIButton!
    
    @IBOutlet weak var imgDisLike: UIImageView!
    @IBOutlet weak var lblDisLike: UILabel!
    @IBOutlet weak var btnDisLike: UIButton!
    
    @IBOutlet weak var imgComment: UIImageView!
    @IBOutlet weak var lblComment: UILabel!
    @IBOutlet weak var btnComment: UIButton!
}







