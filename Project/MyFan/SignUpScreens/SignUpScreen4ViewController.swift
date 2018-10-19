//
//  SignUpScreen4ViewController.swift
//  MyFan
//
//  Created by user on 31/08/18.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit

class SignUpScreen4ViewController: UIViewController {

    @IBOutlet weak var clcView: UICollectionView!
//    let arrImg = ["makeup_artist_dummy.jpg","EventNewpicone.png","cake_dummy.jpg","catereers_dummy.jpeg"]
//
//
//    let arrTitle = ["Musician","Ceremony Musicians","Bands","DJ",]
    var SelectedIndex = [Int]()
    var arrSelectesIds = [String]()
    var objSign2 = SignUp2ViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        clcView.delegate = self
        clcView.dataSource = self
        getInterest()
    }
    func getInterest(){
        objSign2.GetIntrest(vc: self) { (responce) in
            self.clcView.reloadData()
        }
    }
    @IBAction func btnNext(_ sender: Any) {
        print(SelectedIndex)
        print(arrSelectesIds)
        
        if SelectedIndex.count != 5{
            Utility().displayAlert(title: "Please select minimum 5 interests", message: "", control: ["ok"])
        }else{
        let strIds = arrSelectesIds.joined(separator: ",")
            print(strIds)
            let param = ["user[category_ids]":strIds]
            objSign2.postSignUpStepData(param: param, dictImg: nil, vc: self) { (responce) in
                
                print(responce)
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "SignUpScreen5ViewController")as! SignUpScreen5ViewController
                vc.objSign2 = self.objSign2
                self.navigationController?.pushViewController(vc, animated: true)
          }
            
       
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
extension SignUpScreen4ViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return objSign2.IntclcCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = clcView.dequeueReusableCell(withReuseIdentifier: "cellid", for: indexPath) as! CategoryCollectionViewCell
        
        cell.lblTitleInterest.text = objSign2.IntcatgryLable(Index: indexPath.row)
        cell.imgViewMainInterest.kf.indicatorType = .activity
        
        cell.imgViewMainInterest.kf.setImage(with: URL(string: objSign2.IntcatgryImg(Index: indexPath.row)))
        cell.layer.cornerRadius = 5
        cell.clipsToBounds = true
        if SelectedIndex.contains(indexPath.row) {
            cell.imgViewTickInterest.isHidden = false
        }else{
            cell.imgViewTickInterest.isHidden = true
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
     
        if SelectedIndex.contains(indexPath.row){
            if let index = SelectedIndex.index(of: indexPath.row){
            SelectedIndex.remove(at: index)
            arrSelectesIds.remove(at: index)
            }
        }else{
            arrSelectesIds.append(objSign2.IntcatgryId(Index:indexPath.row))
            SelectedIndex.append(indexPath.row)
        }
        clcView.reloadData()
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width/3.2, height: 117)
    }
    
}
