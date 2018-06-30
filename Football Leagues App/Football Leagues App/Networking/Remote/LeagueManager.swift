//
//  LeagueManager.swift
//  Football Leagues App
//
//  Created by Ahmed Shehata on 6/30/18.
//  Copyright © 2018 Karim Ebrahem. All rights reserved.
//

import Foundation
import RxAlamofire
import RxSwift
import SwiftyJSON

class LeagueManager {
    
    func getLeagues() -> Observable<[League]>
    {
        return RxAlamofire.requestJSON(LeagueRouter.getLeagues())
            .observeOn(MainScheduler.instance)
            .map { (arg) in
                let (_, responseData) = arg
                let responseJson = JSON(responseData).array
                let leagues = responseJson?.compactMap(League.init)
                return leagues!
            }
    }
    
}
