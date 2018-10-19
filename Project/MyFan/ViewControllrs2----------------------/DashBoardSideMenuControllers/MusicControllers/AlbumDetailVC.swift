//
//  AlbumDetailVC.swift
//  MyFan
//
//  Created by user on 20/09/18.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit

class AlbumDetailVC: UIViewController {

    @IBOutlet weak var imgAlbum: UIImageView!
    @IBOutlet weak var lblSongsCount: UILabel!
    @IBOutlet weak var lblAlbumName: UILabel!
    @IBOutlet weak var tblView: UITableView!
    var objAlbumViewModel2 = AlbumViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tblView.delegate = self
        tblView.dataSource = self
        tblView.estimatedRowHeight = 50
        tblView.rowHeight = UITableViewAutomaticDimension
        
      //  imgAlbum
        lblSongsCount.text = String(objAlbumViewModel2.albumSongCount()) + " Tracks"
        lblAlbumName.text = objAlbumViewModel2.SelectedAlbumName()
    }
    
    @IBAction func btnMoreAction(_ sender: Any) {
    }
    
    @IBAction func btnBackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func bottomBtnActions(_ sender: UIButton) {
       if sender.tag == 101{
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SongPlayerScreenVC")as! SongPlayerScreenVC
        self.present(vc, animated: true, completion: nil)
       }else if sender.tag == 102{
        
       }else if sender.tag == 103{
        
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
extension AlbumDetailVC:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objAlbumViewModel2.albumSongCount()
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblView.dequeueReusableCell(withIdentifier: "cellid")as! AlbumDetailTblCell
        cell.imgview.kf.indicatorType = .activity
        cell.imgview.kf.setImage(with: URL(string: objAlbumViewModel2.albumSongImageUrl(Index: indexPath.row)))
        
        cell.lbl1.text = ""
        cell.lbl2.text = objAlbumViewModel2.songArtistName(Index: indexPath.row)
        cell.lbl3.text = "Rank "+objAlbumViewModel2.albumSongRank(Index: indexPath.row)
       
        
      //  cell.imgPlayPause.image =
        cell.lblSongTime.text = "5:20"
        cell.btnMore.tag = indexPath.row
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableViewAutomaticDimension
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 70
    }
}
class AlbumDetailTblCell: UITableViewCell {
    @IBOutlet weak var imgview: ImageCustom!
    @IBOutlet weak var lbl1: UILabel!
    @IBOutlet weak var lbl2: UILabel!
    @IBOutlet weak var lbl3: UILabel!
    @IBOutlet weak var imgPlayPause: UIImageView!
    @IBOutlet weak var lblSongTime: UILabel!
    @IBOutlet weak var btnMore: UIButton!
    
}
