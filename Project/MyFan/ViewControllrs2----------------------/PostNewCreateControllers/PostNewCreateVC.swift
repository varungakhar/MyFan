//
//  PostNewCreateVC.swift
//  MyFan
//
//  Created by user on 08/09/18.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit
import WSTagsField
import MobileCoreServices
import MediaPlayer
import Photos
class PostNewCreateVC: UIViewController {
    enum ExportError: Error {
        case unableToCreateExporter
    }
    @IBOutlet weak var profilePic: ImageCustom!
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblName2: UILabel!
    @IBOutlet weak var lblPublic: UILabel!
    @IBOutlet weak var viewtags: UIView!
    @IBOutlet weak var viewAddTag: UIView!
    @IBOutlet weak var scrllViewTag: UIScrollView!
    @IBOutlet weak var txtView: UITextView!
    
    @IBOutlet weak var viewPublicPrivate: UIView!
    @IBOutlet weak var btnPublic: UIButton!
    @IBOutlet weak var btnPrivate: UIButton!
    @IBOutlet weak var imgEarth: UIImageView!
    @IBOutlet weak var imgLock: UIImageView!
    
    @IBOutlet weak var viewRytDrawr: ViewCustom!
    @IBOutlet weak var viewRytDrawrTrailing: NSLayoutConstraint!
    @IBOutlet weak var clcView: UICollectionView!
    var arrSelected = [String]()
     fileprivate let tagsField = WSTagsField()
    
    var imgPicker = UIImagePickerController()
    var btnTapped = String()
    let objPostNewCreate = PostNewCreateViewModel()
    var strVisibility = "public"
    
    var selectedTgsIds = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()

        profilePic.kf.indicatorType = .activity
        profilePic.kf.setImage(with: URL(string: objLoginData.profile_image_url!))
        lblName.text = objLoginData.full_name!
        lblName2.text = "@"+objLoginData.user_name!
        
     
        tagsField.frame = viewtags.bounds
        scrllViewTag.addSubview(tagsField)
        tagsField.cornerRadius = 10.0
        tagsField.borderWidth = 1.0
        tagsField.spaceBetweenTags = 9
        tagsField.tintColor = systemcolor
        tagsField.layoutMargins = UIEdgeInsets(top: 2, left: 6, bottom: 2, right: 6)
        

        tagsField.backgroundColor = UIColor.clear
        tagsField.returnKeyType = .done
        tagsField.delimiter = ""
        textFieldEvents()
         viewAddTag.isHidden = false
        
        txtView.text = "Share with my fans"
        txtView.textColor = UIColor.lightGray
        txtView.delegate = self
        
        imgPicker.delegate = self
        clcView.delegate = self
        clcView.dataSource = self
        
    }
    override func viewWillAppear(_ animated: Bool) {
        viewPublicPrivate.isHidden = true
        viewPublicPrivate.alpha = 0.0
        viewRytDrawrTrailing.constant = 90
        viewRytDrawr.layoutIfNeeded()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tagsField.frame = viewtags.bounds
    }
    
    @IBAction func btnPublicPrivate(_ sender: Any) {
      CreateAnimation(view: "1")
    }
    
    @IBAction func btnBack(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "DashboardViewController")as! DashboardViewController
        self.navigationController?.pushViewController(vc, animated: false)
    }
    @IBAction func btnAddTags(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SearchHashTagVC")as! SearchHashTagVC
        vc.objselectedTag = self
        self.present(vc, animated: true, completion: nil)
    }
    @IBAction func btnPrivacy(_ sender: UIButton) {
        if sender.tag == 1{
            //public
            strVisibility = "public"
        }else if sender.tag == 2{
           //private
            strVisibility = "private"
        }
    }
    
    @IBAction func btnBottomActions(_ sender: UIButton) {
        if sender.tag == 1{
            
        }else if sender.tag == 2{
            
        }else if sender.tag == 3{
            CreateAnimation(view: "2")
        }
        else if sender.tag == 4{
            // share
           PostData()
        }
       
    }
    func PostData(){
        if txtView.text! == "Share with my fans"{
             Utility().displayAlert(title: "please enter post body", message: "", control: ["ok"])
        }else if  selectedTgsIds.count == 0{
            Utility().displayAlert(title: "please select tag", message: "", control: ["ok"])
        }else{
        let strTagIds = selectedTgsIds.joined(separator: ",")
            let srtimage_ids = objPostNewCreate.UploadImgsIds().joined(separator: ",")
            let srtvideo_ids = objPostNewCreate.UploadVideoIds().joined(separator: ",")
            let srtaudio_ids = objPostNewCreate.UploadAudioIds().joined(separator: ",")
            
            let dictDataPost = ["post":["visibility":strVisibility,"body":txtView.text!,"topic_ids": strTagIds,"image_ids":srtimage_ids,"video_ids":srtvideo_ids,"audio_ids":srtaudio_ids]]
           
            print(dictDataPost)
            objPostNewCreate.ShareMyPost(param: dictDataPost, vc: self) { (responce, msg) in
                if responce!{
                    Utility().displayAlertWithCompletion(title: msg, message: "", control: ["ok"], completion: { (str) in
                        if str == "ok"{
                            self.arrSelected.removeAll()
                            self.selectedTgsIds.removeAll()
                            self.tagsField.removeTags()
                        }
                    })
                }else{
                    Utility().displayAlert(title: msg, message: "", control: ["ok"])
                }
            }
            
        }
    }
  
    
    @IBAction func btnRightActions(_ sender: UIButton) {
        if sender.tag == 1{
            // audio
            presentPicker()
        }else if sender.tag == 2{
            // video
            openVideo()
        }else if sender.tag == 3{
          // location
        }
        else if sender.tag == 4{
       // photo
        openPhoto()
        }
        else if sender.tag == 5{
            // gif
            btnTapped = "camera"
            self.imgPicker.sourceType = .photoLibrary
            self.imgPicker.mediaTypes = [kUTTypeImage as String]
            self.imgPicker.allowsEditing = false
            self.present(self.imgPicker, animated: true, completion: nil)
        }
        
    }
    func openPhoto(){
        btnTapped = "camera"

        Utility().OpenActionSheet { (responce) in
            if responce == "Camera"{
                
                self.imgPicker.sourceType = .camera
                self.imgPicker.mediaTypes = [kUTTypeImage as String]
                self.imgPicker.allowsEditing = false
                self.present(self.imgPicker, animated: true, completion: nil)
            }else if responce == "Photo Library"{
                self.imgPicker.sourceType = .photoLibrary
                self.imgPicker.mediaTypes = [kUTTypeImage as String]
                self.imgPicker.allowsEditing = false
                self.present(self.imgPicker, animated: true, completion: nil)
            }else{
                
            }
        }
    }
    func openVideo(){
        btnTapped = "video"
        Utility().OpenActionSheet2 { (responce) in
            if responce == "Take Video"{
                
                self.imgPicker.sourceType = .camera
                self.imgPicker.mediaTypes = [kUTTypeMovie as String]
                self.present(self.imgPicker, animated: true, completion: nil)
            }else if responce == "Video Library"{
                self.imgPicker.sourceType = .savedPhotosAlbum
                self.imgPicker.mediaTypes = [kUTTypeMovie as String]
              
                self.present(self.imgPicker, animated: true, completion: nil)
            }else{
                
            }
        }
        
    }
    func presentPicker() {
         btnTapped = "audio"
      let  mediaPicker = MPMediaPickerController(mediaTypes: .anyAudio)
            mediaPicker.delegate = self
            mediaPicker.allowsPickingMultipleItems = false
            mediaPicker.showsCloudItems = false
            mediaPicker.prompt = "Please Pick a Audio"
            present(mediaPicker, animated: true, completion: nil)
        
    }
    func CreateAnimation(view:String){
        UIView.animate(withDuration: 0.3, delay: 0.0, options: [], animations: {
            if view == "2"{
            if  self.viewRytDrawrTrailing.constant == 0{
                self.viewRytDrawrTrailing.constant = 90
                 self.view.layoutIfNeeded()
            }else{
                self.viewRytDrawrTrailing.constant = 0
                 self.view.layoutIfNeeded()
            }
            }else{
            if self.viewPublicPrivate.isHidden == true{
                self.viewPublicPrivate.alpha = 1.0
                self.viewPublicPrivate.isHidden = false
                
            }else{
                self.viewPublicPrivate.alpha = 0.0
            }
            }
        }, completion: { (finished: Bool) in
        if self.viewPublicPrivate.alpha == 0.0{
             self.viewPublicPrivate.isHidden = true
            }
           
        })
    }
    
    func postMultimediaData(Filedata:Data,TempAddress:String){
        var param = [String:String]()
        var Mdata = [String:Data]()
        if btnTapped == "camera"{
            param = ["upload_type":"image"]
             Mdata  = [TempAddress:Filedata]
        }else if btnTapped == "video"{
              param = ["upload_type":"video"]
            Mdata  = [TempAddress:Filedata]
        }else if btnTapped == "audio"{
              param = ["upload_type":"audio"]
            Mdata  = [TempAddress:Filedata]
        }else{
            print(btnTapped)
        }

 print(param)
        print(Mdata)
        objPostNewCreate.postMultimediaData(param: param, dictImg: Mdata, vc: self) { (responce) in
           // print(responce)
            if responce!{
            self.clcView.reloadData()
            }else{
                Utility().displayAlert(title: "Error!", message: "Try again later", control: ["ok"])
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
extension PostNewCreateVC:selectedTagsDelegate{
    func selectedTags(tagsText: [String], tagsId: [String]) {

        if tagsText.count != 0{
            selectedTgsIds = tagsId
            tagsField.addTags(tagsText)
            viewAddTag.isHidden = true
        }else{
            viewAddTag.isHidden = false
        }
    }
    
}


    // MARK:- Textfield Delegate TextView Delegate
extension PostNewCreateVC:UITextFieldDelegate,UITextViewDelegate {
    
    fileprivate func textFieldEvents() {
        tagsField.onDidAddTag = { txtfld, tag in
         
            if !self.arrSelected.contains(tag.text){
                self.arrSelected.append(tag.text)
                
            }
            print(self.arrSelected)
            self.scrllViewTag.contentSize = CGSize(width: self.scrllViewTag.frame.size.width, height: self.tagsField.frame.size.height+20)
          
        }
        
        tagsField.onDidRemoveTag = { _, tag in
            print("onDidRemoveTag")
            if self.arrSelected.contains(tag.text){
                if let index = self.arrSelected.index(of: tag.text){
                    self.arrSelected.remove(at: index)
                }
            }
            if self.arrSelected.count == 0{
                self.viewAddTag.isHidden = false
            }
            
        }
        
        tagsField.onDidChangeText = { _, text in
            
           
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
    
    
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        if txtView.textColor == UIColor.lightGray {
            txtView.text = ""
            txtView.textColor = UIColor.black
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        
        if txtView.text == "" {
            
            txtView.text = "Share with my fans"
            txtView.textColor = UIColor.lightGray
        }else{
            
            // dictparameter.setValue(txtViewReport.text!, forKey: "suggestion")
        }
    }
}
extension PostNewCreateVC:UIImagePickerControllerDelegate,UINavigationControllerDelegate,MPMediaPickerControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if  btnTapped == "camera"{

            print(info)

                    if  let  fileUrl = info[UIImagePickerControllerImageURL] as? URL{
                        if  let imageData = try? Data(contentsOf: fileUrl){
                            print(imageData)
                           self.postMultimediaData(Filedata: imageData, TempAddress: "\(fileUrl)")
                        }
                   
                    }
        
        }else if btnTapped == "video"{
            
            if let videoURL = info[UIImagePickerControllerMediaURL] as? NSURL {
                print(videoURL)
                let videoData = try? Data(contentsOf: videoURL as URL)as Data
                guard videoData != nil else{
                    return
                }
                self.postMultimediaData(Filedata: videoData!, TempAddress: "\(videoURL)")
            }
        }
        dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // media picker
    
    public func mediaPicker(_ mediaPicker: MPMediaPickerController, didPickMediaItems mediaItemCollection: MPMediaItemCollection){
        print(mediaItemCollection)
        if  let  songItem =  mediaItemCollection.items.first{
            getAudioData(with: songItem) { (Adata,fileUrl)  in
                if Adata != nil{
                    print(Adata!)
                    self.postMultimediaData(Filedata: Adata!, TempAddress: "\(fileUrl!)" )
                    self.dismiss(animated: true, completion: nil)
                }else{
                    self.dismiss(animated: true, completion: nil)
                  Utility().displayAlert(title: "Error", message: "", control: ["ok"])
                }
            }
        }else{
            self.dismiss(animated: true, completion: nil)
          Utility().displayAlert(title: "Error", message: "", control: ["ok"])
        }
    }
    
    public func mediaPickerDidCancel(_ mediaPicker: MPMediaPickerController){
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    ////////////
    func export(_ assetURL: URL, completionHandler: @escaping (_ fileURL: URL?, _ error: Error?) -> ()) {
        let asset = AVURLAsset(url: assetURL)
        guard let exporter = AVAssetExportSession(asset: asset, presetName: AVAssetExportPresetAppleM4A) else {
            completionHandler(nil, ExportError.unableToCreateExporter)
              Utility().displayAlert(title: "Error", message: ExportError.unableToCreateExporter.localizedDescription, control: ["ok"])
            return
        }
        
        let fileURL = URL(fileURLWithPath: NSTemporaryDirectory())
            .appendingPathComponent(NSUUID().uuidString)
            .appendingPathExtension("m4a")
        
        exporter.outputURL = fileURL
        exporter.outputFileType = AVFileType(rawValue: "com.apple.m4a-audio")
        
        exporter.exportAsynchronously {
            if exporter.status == .completed {
                completionHandler(fileURL, nil)
            } else {
                completionHandler(nil, exporter.error)
            }
        }
        
        
    }
    
    
    func getAudioData(with mediaItem: MPMediaItem,completion:@escaping(Data?,URL?)->()){
        var KAudioData :Data? = nil
        if let assetURL = mediaItem.assetURL {
            export(assetURL) { fileURL1, error in
                guard let fileURL = fileURL1, error == nil else {
                    Utility().displayAlert(title: "Error", message: "", control: ["ok"])
                    completion(KAudioData, nil)
                    return
                }
                
                // use fileURL of temporary file here
                print("\(fileURL)")
                do {
                    let AudioData = try Data(contentsOf: fileURL as URL)
                   print(AudioData)
                    KAudioData = AudioData
                    completion(KAudioData, fileURL)
                    return
                } catch {
                    print("Unable to load data: \(error)")
                    Utility().displayAlert(title: "Error", message: error.localizedDescription, control: ["ok"])
                    completion(KAudioData, nil)
                    return
                }
            }
        }
       
    }
    
    
    func getFileName(info: [String : Any]) -> String {
        print(info)
        if let Kurl = info[UIImagePickerControllerImageURL] as? URL {
         let str = "\(Kurl)"
            if str.contains(".png"){
                print("Png")
            }else if str.contains(".jpg"){
                print("jpg")
            }else if str.contains(".jpeg"){
                print("jpeg")
            }else if str.contains(".gif"){
                print("gif")
            }
            
           // print(assetResources.first!.originalFilename)
        
        }
        
//        if let assetPath = info[UIImagePickerControllerReferenceURL] as? URL {
//           let result = PHAsset.fetchAssets(withALAssetURLs: [assetPath], options: nil)
//          print(result)
//            let asset = result.firstObject
//            let fileName = asset?.value(forKey: "filename")
//            let fileUrl = URL(string: fileName as! String)
//            if let name = fileUrl?.deletingPathExtension().lastPathComponent {
//                print(name)
//                //let assetPath = info[UIImagePickerControllerReferenceURL] as! NSURL
//                if (assetPath.absoluteString.hasSuffix("JPG")) {
//                    print("JPG")
//                }
//                else if (assetPath.absoluteString.hasSuffix("PNG")) {
//                print("PNG")
//                }
//                else if (assetPath.absoluteString.hasSuffix("GIF")) {
//                    print("GIF")
//                }
//                else {
//                    print("Unknown")
//                }
//
//                return name
//            }
//        }
        return ""
        
    }
}


extension PostNewCreateVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(objPostNewCreate.ItemCount())
        return objPostNewCreate.ItemCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = clcView.dequeueReusableCell(withReuseIdentifier: "cellid", for: indexPath) as! CategoryCollectionViewCell
        cell.imgBack.kf.indicatorType = .activity
        cell.imgBack.kf.setImage(with: URL(string: objPostNewCreate.itemImgUrl(Index: indexPath.row)))
        if objPostNewCreate.uploadType(Index: indexPath.row) == "image"{
             cell.imgFront.isHidden = true
        }else{
            cell.imgFront.isHidden = false
        }
    
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
     
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width/3.4, height: 100)
}
}








