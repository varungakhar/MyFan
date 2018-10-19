//
//  SearchHashTagVC.swift
//  MyFan
//
//  Created by user on 08/09/18.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit
import WSTagsField
import TagCellLayout
protocol selectedTagsDelegate {
    func selectedTags(tagsText:[String],tagsId:[String])
}

class SearchHashTagVC: UIViewController {

    @IBOutlet weak var tgScrollView: UIScrollView!
    @IBOutlet fileprivate weak var tagsView: UIView!
    @IBOutlet weak var clcView: UICollectionView!
    fileprivate let tagsField = WSTagsField()
    
    let objSearchTag = PostNewCreateViewModel()
    var objselectedTag : selectedTagsDelegate? = nil
    var arrSelected = [String]()
     var arrSelectedIds = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()

        tagsField.frame = tagsView.bounds
        tgScrollView.addSubview(tagsField)
         tagsField.cornerRadius = 10.0
         tagsField.borderWidth = 1.0
         tagsField.spaceBetweenTags = 9
        tagsField.tintColor = systemcolor
        tagsField.layoutMargins = UIEdgeInsets(top: 2, left: 6, bottom: 2, right: 6)
    
        tagsField.placeholder = "Add Tags"
        tagsField.backgroundColor = UIColor.clear
        tagsField.returnKeyType = .done
        tagsField.delimiter = ""
        
        textFieldEvents()
        
        clcView.delegate = self
        clcView.dataSource = self
        let tagLayout = TagCellLayout(alignment: .center, delegate: self)
        clcView.collectionViewLayout = tagLayout
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tagsField.beginEditing()
    }
    
    func searchTags(text:String){
        print(text)
        objSearchTag.getTags(text: text, vc: self) { (responce) in
            
            self.clcView.reloadData()
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tagsField.frame = tagsView.bounds
    }
    @IBAction func btnCancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func btnOk(_ sender: Any) {
        if  objselectedTag != nil{
            objselectedTag?.selectedTags(tagsText:arrSelected , tagsId: arrSelectedIds)
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

extension SearchHashTagVC:UITextFieldDelegate {
    
    fileprivate func textFieldEvents() {
        tagsField.onDidAddTag = { txtfld, tag in
            print(txtfld.text!)
            print(tag.text)
            if !self.arrSelected.contains(tag.text){
                self.arrSelected.append(tag.text)
            
            }
            print(self.arrSelected)
            self.tgScrollView.contentSize = CGSize(width: self.tgScrollView.frame.size.width, height: self.tagsField.frame.size.height+20)
            self.tagsField.becomeFirstResponder()
        }
        
        tagsField.onDidRemoveTag = { _, tag in
            print("onDidRemoveTag")
            if self.arrSelected.contains(tag.text){
                if let index = self.arrSelected.index(of: tag.text){
                    self.arrSelected.remove(at: index)
                    self.arrSelectedIds.remove(at: index)
                }
            }
            print(self.arrSelected)
        }
        
        tagsField.onDidChangeText = { _, text in
         
            self.searchTags(text: text!)
        }
        
        tagsField.onDidChangeHeightTo = { _, height in
            print("HeightTo \(height)")
        }
        
        tagsField.onDidSelectTagView = { _, tagView in
            print("Select \(tagView)")
        }
        
        tagsField.onDidUnselectTagView = { _, tagView in
            print("Unselect \(tagView)")
        }
    }
    
}
extension SearchHashTagVC:UICollectionViewDelegate,UICollectionViewDataSource,TagCellLayoutDelegate{
    
    func tagCellLayoutTagSize(layout: TagCellLayout, atIndex index: Int) -> CGSize {
        let cnt = objSearchTag.tagName(Index: index).count
        if cnt < 7{
           return CGSize(width: CGFloat(cnt*19), height: 54)

        }else{
          return CGSize(width: CGFloat((cnt*15)-(cnt*2)), height: 54)
        }
     
    }

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return objSearchTag.tagsCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
            let cell = clcView.dequeueReusableCell(withReuseIdentifier: "cellid", for: indexPath) as! SearchHashTagClcCell

             cell.lblTags.text = objSearchTag.tagName(Index: indexPath.row)
             cell.lblTags.textColor = systemcolor
             cell.lblTags.layer.cornerRadius = (cell.lblTags.frame.size.height)/2
             cell.lblTags.clipsToBounds = true
             cell.lblTags.layer.borderWidth = 1.0
             cell.lblTags.layer.borderColor = systemcolor.cgColor
             cell.backgroundColor = UIColor.brown
        
   
            return cell
     
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedTag = objSearchTag.tagName(Index: indexPath.row)
        print(selectedTag)
        tagsField.addTag(selectedTag)
        self.arrSelectedIds.append(objSearchTag.tagID(Index: indexPath.row))

    }

    
}

class SearchHashTagClcCell: UICollectionViewCell {
    @IBOutlet weak var lblTags: UILabel!
    
}

