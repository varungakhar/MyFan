//
//  SideMenuMusicVC.swift
//  MyFan
//
//  Created by user on 19/09/18.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit

class SideMenuMusicVC: UIViewController {

    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lbl1: UILabel!
    @IBOutlet weak var lbl2: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tblView.delegate = self
        tblView.dataSource = self
        
        self.imgView.kf.indicatorType = .activity
        self.imgView.kf.setImage(with: URL(string: objLoginData.profile_image_url!))
        self.lbl1.text = objLoginData.full_name!
        self.lbl2.text = "@"+objLoginData.user_name!
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
extension SideMenuMusicVC:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblView.dequeueReusableCell(withIdentifier: "cellid"+String(indexPath.row))!
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0{
            
        }else if indexPath.row == 1{
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "MyFansVC")as! MyFansVC
            self.navigationController?.pushViewController(vc, animated: true)
        }else if indexPath.row == 2{
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "MySongsVC")as! MySongsVC
            self.navigationController?.pushViewController(vc, animated: true)
        }else if indexPath.row == 3{
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "MyAlbumVC")as! MyAlbumVC
            self.navigationController?.pushViewController(vc, animated: true)
        }else if indexPath.row == 4{
//            let vc = self.storyboard?.instantiateViewController(withIdentifier: "MyFansVC")as! MyFansVC
//            self.navigationController?.pushViewController(vc, animated: true)
        }else if indexPath.row == 5{
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "UploadMusicVC")as! UploadMusicVC
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
