//
//  Match.swift
//  Football Leagues App
//
//  Created by Ahmed Shehata on 6/30/18.
//  Copyright © 2018 Karim Ebrahem. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Match {
    let homeTeamInformationUrl: String
    let awayTeamInformationUrl: String
    let matchDate: String
    let matchStatus: String
    let homeTeamName: String
    let awayTeamName: String
    let matchResuslt: MatchResult?
}

extension Match {
    init?(from json: JSON) {
        guard
            let homeTeamInformationUrl = json["_links"]["homeTeam"]["href"].string,
            let awayTeamInformationUrl = json["_links"]["awayTeam"]["href"].string,
            let matchDate = json["date"].string,
            let matchStatus = json["status"].string,
            let homeTeamName = json["homeTeamName"].string,
            let awayTeamName = json["awayTeamName"].string
            else { return nil }
        
        var matchResultData: MatchResult? = nil
        if let goalsHome = json["result"]["goalsHomeTeam"].int, let goalsAway = json["result"]["goalsAwayTeam"].int {
            let matchResult = MatchResult(goalsHomeTeam: goalsHome, goalsAwayTeam: goalsAway)
            matchResultData = matchResult
        }
        
        self.init(homeTeamInformationUrl: homeTeamInformationUrl, awayTeamInformationUrl: awayTeamInformationUrl, matchDate: matchDate, matchStatus: matchStatus, homeTeamName: homeTeamName, awayTeamName: awayTeamName, matchResuslt: matchResultData)
    }
}

struct MatchResult {
    let goalsHomeTeam: Int
    let goalsAwayTeam: Int
}

