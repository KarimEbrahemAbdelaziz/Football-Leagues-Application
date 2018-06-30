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
    
    func getLeagueTeams(leagueTeamsUrl: String) -> Observable<[Team]>
    {
        return RxAlamofire.requestJSON(LeagueRouter.getLeagueTeams(leagueTeamsUrl: leagueTeamsUrl))
            .observeOn(MainScheduler.instance)
            .map { (arg) in
                let (_, responseData) = arg
                let responseJson = JSON(responseData)["teams"].array
                let teams = responseJson?.compactMap(Team.init)
                return teams!
        }
    }
    
}
