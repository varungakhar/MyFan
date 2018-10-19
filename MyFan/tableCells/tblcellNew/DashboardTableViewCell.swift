//
//  DashboardTableViewCell.swift
//  MyFan
//
//  Created by user on 31/08/18.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit
import ActiveLabel
class DashboardTableViewCell: UITableViewCell {

    @IBOutlet weak var imgUserDashBoard: UIImageView!
    @IBOutlet weak var lbl1DashBoard: UILabel!
    @IBOutlet weak var lbl2DashBoard: UILabel!
    @IBOutlet weak var btnSeetingDashBoard: UIImageView!
    @IBOutlet weak var lblDiscriptionDashBoard: UILabel!
   @IBOutlet weak var lblHashTagDashBoard: ActiveLabel!
    
    @IBOutlet weak var lblHashTagOnlyForShow: UILabel!
    
    @IBOutlet weak var viewPostContent: ViewCustom!
     //cellid1
    @IBOutlet weak var img1Cell1: ImageCustom!
    @IBOutlet weak var imgPlay1Cell1: UIImageView!
    
    //
    @IBOutlet weak var imgLike: UIImageView!
    @IBOutlet weak var lblLike: UILabel!
    @IBOutlet weak var btnLike: UIButton!
    
    @IBOutlet weak var imgDislike: UIImageView!
    @IBOutlet weak var lblDislike: UILabel!
    @IBOutlet weak var btDislike: UIButton!
    
    
    @IBOutlet weak var imgComment: UIImageView!
    @IBOutlet weak var lblComment: UILabel!
    @IBOutlet weak var btnComment: UIButton!
    
    @IBOutlet weak var imgShare: UIImageView!
    @IBOutlet weak var lblShare: UILabel!
    @IBOutlet weak var btnShare: UIButton!
    
    @IBOutlet weak var viewMediaContentHeight: NSLayoutConstraint!
    
    //cellid2
    
    @IBOutlet var imgsCell2: [ImageCustom]!
    @IBOutlet var imsPlayCell2: [UIImageView]!
    
     //cellid3
    @IBOutlet var imgsCell3: [ImageCustom]!
    @IBOutlet var imsPlayCell3: [UIImageView]!
    
     //cellid4
    
    @IBOutlet var imgsCell4: [ImageCustom]!
    @IBOutlet var imsPlayCell4: [UIImageView]!
    
    
     //cellid5
    
     @IBOutlet var imgsCell5: [ImageCustom]!
     @IBOutlet var imsPlayCell5: [UIImageView]!
    @IBOutlet weak var lblMoreCell5: LabelCustom!
    

    
    // Header
    @IBOutlet weak var imgTrending: UIImageView!
    @IBOutlet weak var imgRecent: UIImageView!
    @IBOutlet weak var imgSpotLight: UIImageView!
    @IBOutlet weak var imgPopular: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
