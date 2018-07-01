//
//  LoadingHud.swift
//  Football Leagues App
//
//  Created by Ahmed Shehata on 7/1/18.
//  Copyright © 2018 Karim Ebrahem. All rights reserved.
//

import Foundation
import JGProgressHUD

class LaodingHud {
    
    static let loadingHud = LaodingHud()
    
    private var indicator: JGProgressHUD!
    
    private init() {
        indicator = JGProgressHUD(style: .dark)
        indicator?.textLabel.text = "Loading..."
    }
    
}
