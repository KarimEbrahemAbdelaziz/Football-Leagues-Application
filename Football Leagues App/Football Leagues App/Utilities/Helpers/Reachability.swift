//
//  Reachability.swift
//  Football Leagues App
//
//  Created by Karim Ebrahem on 7/1/18.
//  Copyright © 2018 Karim Ebrahem. All rights reserved.
//

import Foundation
import Alamofire
import SystemConfiguration

class InternetReachability {
    
    //MARK:- Check Internet Connection
    static func connectedToNetwork() -> Bool {
        
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        }) else {
            return false
        }
        
        var flags: SCNetworkReachabilityFlags = []
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
            return false
        }
        
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        
        return (isReachable && !needsConnection)
    }
    
    
    
    //MARK:- Check Internet Connection using Alamofire
    static func checkInternetConnectionUsingAlamofire() -> Bool {
        
        return NetworkReachabilityManager()!.isReachable
        
    }
    
}
