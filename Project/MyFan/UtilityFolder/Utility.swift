//
//  UrlConstant.swift
//  ScanReport
//
//  Created by user on 23/08/18.
//  Copyright © 2018 RVTechnologies Softwares PVT. LTD. All rights reserved.
//

import Foundation
import UIKit
import SystemConfiguration
//Utility Class

let systemcolor = UIColor(red: 52/255.0, green: 133/255.0, blue: 178/255.0, alpha: 1.0)
let cellbgcolor = UIColor(red: 239/255.0, green: 239/255.0, blue: 241/255.0, alpha: 1.0)
class Utility : NSObject{
    
    let topController = UIApplication.topViewController()
    
    func pushViewControl(ViewControl:String){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: ViewControl)
        let topVC = UIApplication.topViewController()
        topVC?.navigationController?.pushViewController(controller, animated: true)
    }
    
    
    //MARK:- Display alert with completion
    
    func displayAlertWithCompletion(title:String,message:String,control:[String],completion:@escaping (String)->()){
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        for str in control{
            
            let alertAction = UIAlertAction(title: str, style: .default, handler: { (action) in
                
                completion(str)
            })
            
            alertController.addAction(alertAction)
        }
        
        
        // let topController = UIApplication.topViewController()
        topController?.present(alertController, animated: true, completion: nil)
        
    }
    
    
    //MARK:- Display alert without completion
    
    func displayAlert(title:String,message:String,control:[String]){
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        for str in control{
            
            let alertAction = UIAlertAction(title: str, style: .default, handler: { (action) in
                
                
            })
            
            alertController.addAction(alertAction)
        }
        
        topController?.present(alertController, animated: true, completion: nil)
        
    }
    
    
    func OpenActionSheet(completion:@escaping (String)->()) {
        let alert = UIAlertController(title: "Choose An Action", message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        let cameraAction = UIAlertAction(title: "Camera", style: UIAlertActionStyle.default,handler: { (action) in
            completion("Camera")
            
        })
        let gallaryAction = UIAlertAction(title: "Photo Library", style: UIAlertActionStyle.default,handler: { (action) in
            completion("Photo Library")
            
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel,handler: { (action) in
            completion("Cancel")
            
        })
        alert.addAction(cameraAction)
        alert.addAction(gallaryAction)
        alert.addAction(cancelAction)
        if UIDevice.current.userInterfaceIdiom == .phone
        {
            topController?.present(alert, animated: true, completion: nil)
        }
        
    }
    func OpenActionSheet2(completion:@escaping (String)->()) {
        let alert = UIAlertController(title: "Choose An Action", message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        let cameraAction = UIAlertAction(title: "Take Video", style: UIAlertActionStyle.default,handler: { (action) in
            completion("Take Video")
            
        })
        let gallaryAction = UIAlertAction(title: "Video Library", style: UIAlertActionStyle.default,handler: { (action) in
            completion("Video Library")
            
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel,handler: { (action) in
            completion("Cancel")
            
        })
        alert.addAction(cameraAction)
        alert.addAction(gallaryAction)
        alert.addAction(cancelAction)
        if UIDevice.current.userInterfaceIdiom == .phone
        {
            topController?.present(alert, animated: true, completion: nil)
        }
        
    }
    //getToken
    func getToken() -> String {
        if let token = UserDefaults.standard.value(forKey: "token")as? String{
            return token
        }
        return "dsf242gsadg25424"
    }
    


func isValidEmail(testStr:String) -> Bool {
    // print("validate calendar: \(testStr)")
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    
    let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    return emailTest.evaluate(with: testStr)
}

func isCodeValid(_ code : String) -> Bool
{
    let characterset = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789")
    if code.rangeOfCharacter(from: characterset.inverted) != nil {
        print("string contains special characters")
        return false
    }
    else{
        return true
    }
}



//phone validation

func myMobileNumberValidate(_ number: String?) -> Bool {
    let numberRegEx = "[0-9]{10}"
    let numberTest = NSPredicate(format: "SELF MATCHES %@", numberRegEx)
    if numberTest.evaluate(with: number) == true {
        return true
    }
    else {
        return false
    }
}



//pincode validation

func isValidPincode(value: String) -> Bool {
    if value.count == 6{
        return true
    }
    else{
        return false
    }
}

//Password Validation

func isPasswordSame(password: String , confirmPassword : String) -> Bool {
    if password == confirmPassword{
        return true
    }else{
        return false
    }
}


//Password length validation

func isPwdLenth(password: String , confirmPassword : String) -> Bool {
    if password.count <= 7 && confirmPassword.count <= 7{
        return true
    }else{
        return false
    }
}

}
// for action sheet icon
extension UIImage {
    
    func imageWithSize(scaledToSize newSize: CGSize) -> UIImage {
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        self.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }
    
}

extension String {
    func widthOfString() -> CGFloat {
        let font = UIFont.systemFont(ofSize: 29)
        let fontAttributes = [NSAttributedStringKey.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.width
    }
}

extension UIApplication {
    class func topViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }
}
//Mark: Check Reachability

protocol Utilities {
}
extension NSObject:Utilities{
    
    
    enum ReachabilityStatus {
        case notReachable
        case reachableViaWWAN
        case reachableViaWiFi
    }
    
    var currentReachabilityStatus: ReachabilityStatus {
        
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        }) else {
            return .notReachable
        }
        
        var flags: SCNetworkReachabilityFlags = []
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
            return .notReachable
        }
        
        if flags.contains(.reachable) == false {
            // The target host is not reachable.
            return .notReachable
        }
        else if flags.contains(.isWWAN) == true {
            // WWAN connections are OK if the calling application is using the CFNetwork APIs.
            return .reachableViaWWAN
        }
        else if flags.contains(.connectionRequired) == false {
            // If the target host is reachable and no connection is required then we'll assume that you're on Wi-Fi...
            return .reachableViaWiFi
        }
        else if (flags.contains(.connectionOnDemand) == true || flags.contains(.connectionOnTraffic) == true) && flags.contains(.interventionRequired) == false {
            // The connection is on-demand (or on-traffic) if the calling application is using the CFSocketStream or higher APIs and no [user] intervention is needed
            return .reachableViaWiFi
        }
        else {
            return .notReachable
        }
    }}

