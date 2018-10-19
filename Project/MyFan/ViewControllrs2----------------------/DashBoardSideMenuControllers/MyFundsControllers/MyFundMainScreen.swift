//
//  MyFundMainScreen.swift
//  MyFan
//
//  Created by user on 06/10/18.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit

class MyFundMainScreen: UIViewController {

    @IBOutlet weak var lblAmount: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    @IBAction func botomBtnsAction(_ sender: UIButton) {
        if sender.tag == 101{
            // send money
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "SendReceiveMoneyVC")as! SendReceiveMoneyVC
            vc.strTitle = "Send Money"
            self.navigationController?.pushViewController(vc, animated: true)
        }else if sender.tag == 102{
            // receive money
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "SendReceiveMoneyVC")as! SendReceiveMoneyVC
            vc.strTitle = "Rquest Money"
            self.navigationController?.pushViewController(vc, animated: true)
        }else if sender.tag == 103{
            // others
        }else if sender.tag == 104{
            // scan to send money
            
        }else if sender.tag == 105{
            //tip
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "TipScreenVC")as! TipScreenVC
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
    
    @IBAction func btnViewPayment(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "PaymentsScreenVC")as! PaymentsScreenVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func btnPaymentActivity(_ sender: Any) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "PaymentActivityVC")as! PaymentActivityVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func btnBackAction(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "DashboardViewController")as! DashboardViewController
        self.navigationController?.pushViewController(vc, animated: false)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
