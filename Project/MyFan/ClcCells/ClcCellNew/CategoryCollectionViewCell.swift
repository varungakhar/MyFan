//
//  CategoryCollectionViewCell.swift
//  MyFan
//
//  Created by user on 31/08/18.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var viewCellBack: ViewCustom!
    
    //Profession
 @IBOutlet weak var imgViewProfession: UIImageView!
    @IBOutlet weak var imgViewTickProfession: UIImageView!
    
    @IBOutlet weak var lblTitleProfession: UILabel!
    
    //SubProfession
    @IBOutlet weak var imgViewMainSubProfession: UIImageView!
    
    @IBOutlet weak var imgViewTickSubProfession: UIImageView!
    
    @IBOutlet weak var lblTitleSubProfession: UILabel!
    
    
    
    //Interest
    
    @IBOutlet weak var imgViewMainInterest: UIImageView!
    
    @IBOutlet weak var imgViewTickInterest: UIImageView!
    
    @IBOutlet weak var lblTitleInterest: UILabel!
    
    
   // careateNewPost
    @IBOutlet weak var imgBack: ImageCustom!
    
    @IBOutlet weak var imgFront: UIImageView!
    
    
}
