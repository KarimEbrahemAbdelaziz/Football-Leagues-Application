//
//  League.swift
//  Football Leagues App
//
//  Created by Karim Ebrahem on 6/30/18.
//  Copyright © 2018 Karim Ebrahem. All rights reserved.
//

import Foundation
import SwiftyJSON

struct League {
    let leagueTeamsUrl: String
    let caption: String
    let league: String
    let numberOfTeams: Int
    let numberOfGames: Int
}

extension League {
    init?(from json: JSON) {
        guard
            let leagueTeamsUrl = json["_links"]["teams"]["href"].string,
            let caption = json["caption"].string,
            let league = json["league"].string,
            let numberOfTeams = json["numberOfTeams"].int,
            let numberOfGames = json["numberOfGames"].int
            else { return nil }
        
        self.init(leagueTeamsUrl: leagueTeamsUrl, caption: caption, league: league, numberOfTeams: numberOfTeams, numberOfGames: numberOfGames)
    }
}
