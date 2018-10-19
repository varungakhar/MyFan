//
//  SingUpScreen3ViewController.swift
//  MyFan
//
//  Created by user on 31/08/18.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit

class SingUpScreen3ViewController: UIViewController {
    @IBOutlet weak var clcView: UICollectionView!
//    let arrImg = ["makeup_artist_dummy.jpg","EventNewpicone.png","cake_dummy.jpg","catereers_dummy.jpeg"]
//
//
//    let arrTitle = ["Musician","Ceremony Musicians","Bands","DJ"]
    
var SelectedIndex = -1
    var objSign2 = SignUp2ViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()

        clcView.delegate = self
        clcView.dataSource = self
    }
    @IBAction func btnNext(_ sender: Any) {

//        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SignUpScreen4ViewController")as! SignUpScreen4ViewController
//        vc.objSign2 = objSign2
//        self.navigationController?.pushViewController(vc, animated: true)
        
      let subCarName = objSign2.SubcatgryLable(Index: SelectedIndex)
        let param = ["user[professional_sub_category_name]":subCarName]
        
        objSign2.postSignUpStepData(param: param, dictImg: nil, vc: self) { (responce) in
            
            print(responce)
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "SignUpScreen4ViewController")as! SignUpScreen4ViewController
                    vc.objSign2 = self.objSign2
                    self.navigationController?.pushViewController(vc, animated: true)
            
        }
        
        
    }
    @IBAction func btnBAck(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
extension SingUpScreen3ViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return objSign2.SubclcCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = clcView.dequeueReusableCell(withReuseIdentifier: "cellid", for: indexPath) as! CategoryCollectionViewCell
        
        cell.lblTitleSubProfession.text = objSign2.SubcatgryLable(Index: indexPath.row)
        
        cell.imgViewMainSubProfession.kf.indicatorType = .activity
        cell.imgViewMainSubProfession.kf.setImage(with: URL(string: objSign2.SubcatgryImg(Index: indexPath.row)))
        cell.layer.cornerRadius = 5
        cell.clipsToBounds = true
        if SelectedIndex == indexPath.row{
            cell.imgViewTickSubProfession.isHidden = false
        }else{
            cell.imgViewTickSubProfession.isHidden = true
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        SelectedIndex = indexPath.row
        clcView.reloadData()
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width/3.2, height: 117)
    }
    
}
