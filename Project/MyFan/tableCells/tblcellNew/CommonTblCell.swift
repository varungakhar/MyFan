//
//  CommonTblCell.swift
//  Legalex
//
//  Created by user on 23/08/18.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit

class CommonTblCell: UITableViewCell {

    //SettingsVC
    
    @IBOutlet weak var imgSettings: UIImageView!
    
    @IBOutlet weak var lblSettings: UILabel!
    
    @IBOutlet weak var lblBadge: LabelCustom!
    @IBOutlet weak var lblVersion: UILabel!
    
    // HashTagInTable
    
    @IBOutlet weak var lblHashTag: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
