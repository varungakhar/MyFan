//
//  MyAlbumVC.swift
//  MyFan
//
//  Created by user on 19/09/18.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit

class MyAlbumVC: UIViewController {

    @IBOutlet weak var clcView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

       clcView.delegate = self
        clcView.dataSource = self
       
clcView.register(SupView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader , withReuseIdentifier: "cellidSupp")
    }
    @IBAction func btnBackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

// MARK:- Collection view delegate and datasource
extension MyAlbumVC: UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = clcView.dequeueReusableCell(withReuseIdentifier: "cellid", for: indexPath)
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let reusableView = clcView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "cellidSupp", for: indexPath) as! SupView
        
        return reusableView
        
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
       return CGSize(width: collectionView.frame.size.width/3.4, height: 145)
    }
    
}



//MARK:- Supplymentry Kind of View
class SupView: UICollectionReusableView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.myCustomInit()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self.myCustomInit()
    }
    func myCustomInit() {
        print("hello there from SupView")
    }
    
}
