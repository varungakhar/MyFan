//
//  CommonMusicSectionViewModel.swift
//  MyFan
//
//  Created by user on 20/09/18.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit

class CommonMusicSectionViewModel: NSObject {
    private  var clc2show :Bool = false
    private var clc3show :Bool = false
    private  var clc4show :Bool = false
    private  var clc5show :Bool = false
    private  var clc2H :CGFloat = 0
    private var clc3H :CGFloat = 0
    private  var clc4H :CGFloat = 0
    private  var clc5H :CGFloat = 0
    
    func ShowClc2()->CGFloat{
       var h :CGFloat = 0
        if clc2show {
           clc2show = false
            h = 0
        }else{
           clc2show = true
             h = 45
        }
        clc2H = h
        return h
    }
    
    func ShowClc3()->CGFloat{
        var h :CGFloat = 0
        if clc3show {
            clc3show = false
            h = 0
        }else{
            clc3show = true
            h = 45
        }
        clc3H = h
        return h
    }
    
    func ShowClc4()->CGFloat{
        var h :CGFloat = 0
        if clc4show {
            clc4show = false
            h = 0
        }else{
            clc4show = true
            h = 45
        }
        clc4H = h
        return h
    }
    
    func ShowClc5()->CGFloat{
        var h :CGFloat = 0
        if clc5show {
            clc5show = false
            h = 0
        }else{
            clc5show = true
            h = 45
        }
        clc5H = h
        return h
    }
    
    func clc2Height()->CGFloat{
        return clc2H
    }
    func clc3Height()->CGFloat{
        return clc3H
    }
    func clc4Height()->CGFloat{
        return clc4H
    }
    func clc5Height()->CGFloat{
        return clc5H
    }
    
    func CalculateHeaderHeight()->CGFloat{
       
      var  TotalH : CGFloat = 102
        
        if clc2show {
            TotalH += 49
        }
        if clc3show {
            TotalH += 49
        }
        if clc4show {
            TotalH += 49
        }
        if clc5show {
            TotalH += 49
        }
        print(TotalH)
        return TotalH
    }
    
}

   // Random Colour Genereate

extension UIColor {
    static var random: UIColor {
        return UIColor(red: .random, green: .random, blue: .random, alpha: 1.0)
    }
}

extension CGFloat {
    static var random: CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}
