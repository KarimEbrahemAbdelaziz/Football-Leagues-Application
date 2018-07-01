//
//  TeamViewModel.swift
//  Football Leagues App
//
//  Created by Ahmed Shehata on 7/1/18.
//  Copyright © 2018 Karim Ebrahem. All rights reserved.
//

import Foundation

class TeamViewModel {
    let teamFixturesUrl: String
    let teamName: String
    let teamLogo: String
    
    init(team: Team) {
        self.teamFixturesUrl = team.teamFixturesUrl
        self.teamName = team.teamName
        self.teamLogo = team.teamLogo
    }
}
