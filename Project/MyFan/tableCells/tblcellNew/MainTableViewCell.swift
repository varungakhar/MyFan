//
//  MainTableViewCell.swift
//  MyFan
//
//  Created by user on 31/08/18.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit

class MainTableViewCell: UITableViewCell {

    @IBOutlet weak var lblMain: UILabel!
    
    @IBOutlet weak var imgFeature: ImageCustom!
    
    @IBOutlet weak var imgUser: ImageCustom!
    
    @IBOutlet weak var lblUserFullName: UILabel!
    
    @IBOutlet weak var lblVisibility: UILabel!
    
    @IBOutlet weak var lblUserName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
