//
//  SignUpScreen2ViewController.swift
//  MyFan
//
//  Created by user on 31/08/18.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit
import Kingfisher
class SignUpScreen2ViewController: UIViewController {

    @IBOutlet weak var clcView: UICollectionView!
    
//    let arrImg = ["image_dummy.jpg","bartender_dummy.jpg","officiants_dummy.jpg","music_dummy.jpeg"]
//    
//    
//    let arrTitle = ["Photographer","Bartender","Officiants","Music",]
    let objSignup2 = SignUp2ViewModel()
    
var SelectedIndex = -1
    override func viewDidLoad() {
        super.viewDidLoad()

        clcView.delegate = self
        clcView.dataSource = self
        
        getCategories()
    }

    func getCategories(){
        objSignup2.GetCatgories(vc: self) { (responce) in
        
            self.clcView.reloadData()
           
        }
    }
    
    @IBAction func btnNext(_ sender: Any) {
       let  Catid = objSignup2.SelectedCatgryId(Index: SelectedIndex)
        
        let param = ["user[professional_category_id]":Catid]
            
        
                objSignup2.postSignUpStepData(param: param, dictImg: nil, vc: self) { (responce) in
        
                    print(responce)
                    if  self.objSignup2.SubclcCount() != 0{
                    
                            let vc = self.storyboard?.instantiateViewController(withIdentifier: "SingUpScreen3ViewController")as! SingUpScreen3ViewController
                             vc.objSign2 = self.objSignup2
                                self.navigationController?.pushViewController(vc, animated: true)
                            }else{
                    
                              Utility().pushViewControl(ViewControl: "SignUpScreen4ViewController")
                            }
        
                }
        
        
      
//        if  objSignup2.SubclcCount() != 0{
//       
//            let vc = self.storyboard?.instantiateViewController(withIdentifier: "SingUpScreen3ViewController")as! SingUpScreen3ViewController
//            vc.objSign2 = objSignup2
//            self.navigationController?.pushViewController(vc, animated: true)
//        }else{
//            
//          Utility().pushViewControl(ViewControl: "SignUpScreen4ViewController")
//        }
    }
    @IBAction func btnBAck(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    



}
extension SignUpScreen2ViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return objSignup2.clcCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = clcView.dequeueReusableCell(withReuseIdentifier: "cellid", for: indexPath) as! CategoryCollectionViewCell
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
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        SelectedIndex = indexPath.row
        objSignup2.SelectedCatgory(Index: indexPath.row)
        clcView.reloadData()
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width/3.2, height: 117)
    }
    
}
