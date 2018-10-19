//
//  Connectivity.swift
//  CityTack
//
//  Created by webastral on 26/12/17.
//  Copyright © 2017 webastral. All rights reserved.
//

import Foundation
import Alamofire
class Connectivity {
    class func isConnectedToInternet() ->Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}




