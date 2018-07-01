//
//  LeagueViewModel.swift
//  Football Leagues App
//
//  Created by Ahmed Shehata on 7/1/18.
//  Copyright © 2018 Karim Ebrahem. All rights reserved.
//

import Foundation

class LeagueViewModel {
    let leagueTeamsUrl: String
    let leagueName: String
    let leagueNumberOfGames: String
    let leagueNumberOfTeams: String
    
    init(league: League) {
        self.leagueTeamsUrl = league.leagueTeamsUrl
        self.leagueName = league.caption
        self.leagueNumberOfGames = "\(league.numberOfGames)"
        self.leagueNumberOfTeams = "\(league.numberOfTeams)"
    }
}
