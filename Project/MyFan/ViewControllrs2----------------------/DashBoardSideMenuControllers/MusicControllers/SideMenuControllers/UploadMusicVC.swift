//
//  UploadMusicVC.swift
//  MyFan
//
//  Created by user on 19/09/18.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit

class UploadMusicVC: UIViewController {

    @IBOutlet weak var txtTrackTitle: UITextField!
    
    @IBOutlet weak var txtAlbumName: UITextField!
    
    @IBOutlet weak var txtArtistName: UITextField!
    
    @IBOutlet weak var lblMusicType: UILabel!
    
    @IBOutlet weak var viewTblSuggesion: ViewCustom!
    
    @IBOutlet weak var tblViewSuggesion: UITableView!
    
    @IBOutlet weak var btnSelectetSongImg: UIButton!
    
    
    @IBOutlet weak var viewTblVerticalConst: NSLayoutConstraint!
    
    
     var imgPicker = UIImagePickerController()
    override func viewDidLoad() {
        super.viewDidLoad()

        txtTrackTitle.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControlEvents.editingChanged)
        txtAlbumName.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControlEvents.editingChanged)
        txtArtistName.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControlEvents.editingChanged)
        
        txtTrackTitle.delegate = self
        txtAlbumName.delegate = self
        txtArtistName.delegate = self

         viewTblSuggesion.isHidden = true
    }
    
    @IBAction func btnMusicTypeAction(_ sender: Any) {
    }
    
    @IBAction func btnChooseMusicAction(_ sender: Any) {
    }
    
    @IBAction func btnSelectetSongImgAction(_ sender: UIButton) {
        self.imgPicker.delegate = self
        self.imgPicker.sourceType = .photoLibrary
        self.imgPicker.allowsEditing = true
        self.present(self.imgPicker, animated: true, completion: nil)
    }
    
    @IBAction func btnSubmitAtion(_ sender: Any) {
    }
    
    
    
    
    @IBAction func btnBackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    @objc func textFieldDidChange(_ textField:UITextField) {
         viewTblSuggesion.isHidden = false
         if  textField == txtAlbumName{
             viewTblVerticalConst.constant = 2
            
        }else if  textField == txtArtistName{
             viewTblVerticalConst.constant = 100
        }
        
        viewTblSuggesion.layoutIfNeeded()
        self.view.layoutIfNeeded()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
extension UploadMusicVC:UITextFieldDelegate{
    func textFieldDidEndEditing(_ textField: UITextField) {
        viewTblSuggesion.isHidden = true
    }
}

extension UploadMusicVC:UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        self.imgPicker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        print(info)
        let PickerImg = info["UIImagePickerControllerEditedImage"]as! UIImage
        btnSelectetSongImg.setImage(PickerImg, for: .normal)
        
        self.dismiss(animated: true, completion: nil)
    }
    
}
