//
//  Team.swift
//  Football Leagues App
//
//  Created by Karim Ebrahem on 6/30/18.
//  Copyright © 2018 Karim Ebrahem. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Team {
    let teamFixturesUrl: String
    let teamName: String
    let teamLogo: String
}

extension Team {
    init?(from json: JSON) {
        guard
            let teamFixturesUrl = json["_links"]["fixtures"]["href"].string,
            let teamName = json["name"].string
        else { return nil }
        
        let teamLogo = json["crestUrl"].string ?? ""
        
        self.init(teamFixturesUrl: teamFixturesUrl, teamName: teamName, teamLogo: teamLogo)
    }
}
