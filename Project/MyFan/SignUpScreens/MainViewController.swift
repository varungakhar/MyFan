//
//  MainViewController.swift
//  MyFan
//
//  Created by user on 31/08/18.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    @IBOutlet weak var tblView: UITableView!
    
    @IBOutlet weak var txtSearch: UITextField!
    
    @IBOutlet weak var clcViewCat1: UICollectionView!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    @IBOutlet weak var clcViewCat2: UICollectionView!
    
    var SelectedIndex = -1
    let objMainViewModel = MainViewViewModel()
    let objSignup2 = SignUp2ViewModel()
    let objLogin = LoginViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        
       self.navigationController?.isNavigationBarHidden = true
        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotification(notification:)), name: Notification.Name("tblReload"), object: nil)
        tblView.delegate = self
        tblView.dataSource = self
        
        clcViewCat1.delegate = self
        clcViewCat1.dataSource = self
        clcViewCat2.dataSource = self
        clcViewCat2.delegate = self
        let flowLayout = clcViewCat2.collectionViewLayout as! UICollectionViewFlowLayout
        
        // this breaks
        flowLayout.estimatedItemSize = CGSize(width: 147, height: 40)
        flowLayout.itemSize = UICollectionViewFlowLayoutAutomaticSize
        getCatgrys()
    }
    @objc func methodOfReceivedNotification(notification: Notification){
        tblView.reloadData()
    }
    func getCatgrys(){
        objSignup2.GetCatgories(vc: self) { (responce) in
            self.clcViewCat2.reloadData()
            self.clcViewCat1.reloadData()
            self.objMainViewModel.GetTrendigs(vc: self)
        }
    }
    
    @IBAction func btnForgetPassword(_ sender: Any) {
   
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController")as!LoginViewController
        vc.showForgetView = true
    self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnRegister(_ sender: Any) {
        Utility().pushViewControl(ViewControl: "SignUpViewController")
    }
    
    @IBAction func btnLogin(_ sender: Any) {
        if txtEmail.text == ""{
            Utility().displayAlert(title: "", message: "Please enter your email", control: ["ok"])
        }else if !Utility().isValidEmail(testStr: txtEmail.text!){
            
            Utility().displayAlert(title: "", message: "Please enter valid email", control: ["ok"])
        }
        else if txtPassword.text == ""{
            Utility().displayAlert(title: "", message: "Please enter password", control: ["ok"])
        }else{
            let param = ["user":["email":txtEmail.text!,"password":txtPassword.text!]]
            
            objLogin.login(parameter: param, vc: self) { (responce) in
                if responce!{
                    Utility().pushViewControl(ViewControl: "DashboardViewController")
                    
                }else{
                    Utility().displayAlert(title: "", message: "Invalid credentials", control: ["ok"])
                }
            }
        }
    }
    
    
    
    
    @IBAction func btnSIdeMenuAction(_ sender: Any) {
        Utility().pushViewControl(ViewControl: "LoginViewController")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
extension MainViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objMainViewModel.tbleCellCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblView.dequeueReusableCell(withIdentifier: "cellid")as! MainTableViewCell
        
        cell.imgUser.kf.indicatorType = .activity
        cell.imgUser.kf.setImage(with: URL(string: objMainViewModel.featureUserImg(Index: indexPath.row)))
        cell.lblUserFullName.text = objMainViewModel.featureFullName(Index: indexPath.row)
        cell.lblUserName.text = objMainViewModel.featureUserName(Index: indexPath.row)
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 280
    }
}
extension MainViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
        return objSignup2.clcCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == clcViewCat1{
        let cell = clcViewCat1.dequeueReusableCell(withReuseIdentifier: "cellid", for: indexPath) as! CategoryCollectionViewCell
        cell.layer.cornerRadius = 5
        cell.clipsToBounds = true
        
        cell.lblTitleProfession.text = objSignup2.catgryLable(Index: indexPath.row)
        cell.imgViewProfession.kf.indicatorType = .activity
        cell.imgViewProfession.kf.setImage(with: URL(string: objSignup2.catgryImg(Index: indexPath.row)))
        
        if SelectedIndex == indexPath.row{
            cell.imgViewTickProfession.isHidden = false
        }else{
            cell.imgViewTickProfession.isHidden = true
        }
        
        return cell
        }else{
            let cell = clcViewCat2.dequeueReusableCell(withReuseIdentifier: "cellid2", for: indexPath) as! CategoryCollectionViewCell
           
            
            cell.lblTitleProfession.text = objSignup2.catgryLable(Index: indexPath.row)
            cell.imgViewProfession.kf.indicatorType = .activity
            cell.imgViewProfession.kf.setImage(with: URL(string: objSignup2.catgryImg(Index: indexPath.row)))
 return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == clcViewCat1{
        SelectedIndex = indexPath.row
        objSignup2.SelectedCatgory(Index: indexPath.row)
        clcViewCat1.reloadData()
        }else{
            
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
      
        if collectionView == clcViewCat1{
              return CGSize(width: collectionView.frame.size.width/3.2, height: 117)
        }else{
             return CGSize(width: 100, height: collectionView.frame.size.height)
           // return UICollectionViewFlowLayoutAutomaticSize
        }
    }
    
}
