//
//  NvActivityIndicator.swift
//  Dyot
//
//  Created by webastral on 2/16/18.
//  Copyright © 2018 webastral. All rights reserved.
//

import Foundation
import UIKit
import NVActivityIndicatorView


class Indicator:UIViewController,NVActivityIndicatorViewable{
      let size = CGSize(width:50, height: 50)
    
    
    class func shared() -> Indicator {
        
        struct Static {
         
            static let manager = Indicator()
        }
    
        return Static.manager
    }
    
    func start()
    {
        startAnimating(size, type: NVActivityIndicatorType.circleStrokeSpin, color: systemcolor, backgroundColor: UIColor.black.withAlphaComponent(0.1) )
 // startAnimating(size,message:"Loading...",type:NVActivityIndicatorType.circleStrokeSpin)
    }
    
    func start(msg:String)
    {
        startAnimating(size,message:msg,type:NVActivityIndicatorType.circleStrokeSpin)
    }
    
    func stop()
    {
        stopAnimating()
    }
    
}
