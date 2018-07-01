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

class RemoteLeagueManager {
    
    private let leagueDataHelper = LeagueDataHelper()
    private let teamDataHelper = TeamDataHelper()
    
    func getLeagues() -> Observable<[League]>
    {
        return RxAlamofire.requestJSON(LeagueRouter.getLeagues())
            .observeOn(MainScheduler.instance)
            .map { (arg) in
                let (_, responseData) = arg
                let responseJson = JSON(responseData).array
                let leagues = responseJson?.compactMap(League.init)
                _ = leagues?.map({ (league) in
                    self.leagueDataHelper.insert(item: league)
                })
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
                _ = teams?.map({ (team) in
                    self.teamDataHelper.insert(item: team)
                })
                return teams!
        }
    }
    
    func getTeamFixtures(teamFixturesUrl: String) -> Observable<[Match]>
    {
        return RxAlamofire.requestJSON(LeagueRouter.getTeamFixtures(teamFixturesUrl: teamFixturesUrl))
            .observeOn(MainScheduler.instance)
            .map { (arg) in
                let (_, responseData) = arg
                let responseJson = JSON(responseData)["fixtures"].array
                let matchs = responseJson?.compactMap(Match.init)
                return matchs!
        }
    }
    
    func getTeamInformation(teamInformationUrl: String) -> Observable<Team>
    {
        return RxAlamofire.requestJSON(LeagueRouter.getTeamInformation(teamInformationUrl: teamInformationUrl))
            .observeOn(MainScheduler.instance)
            .map { (arg) in
                let (_, responseData) = arg
                let responseJson = JSON(responseData)
                let team = Team.init(from: responseJson)
                return team!
        }
    }
    
}
