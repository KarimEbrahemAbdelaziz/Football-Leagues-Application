//
//  LeagueCell.swift
//  Football Leagues App
//
//  Created by Ahmed Shehata on 7/1/18.
//  Copyright © 2018 Karim Ebrahem. All rights reserved.
//

import UIKit

class LeagueCell: UITableViewCell {
    
    @IBOutlet weak var leagueName: UILabel!
    @IBOutlet weak var leagueNumberOfGames: UILabel!
    @IBOutlet weak var leagueNumberOfTeams: UILabel!

    func configureCell(with league: LeagueViewModel) {
        setLeagueName(league.leagueName)
        setNumberOfGames(league.leagueNumberOfGames)
        setNumberOfTeams(league.leagueNumberOfTeams)
    }
    
    private func setLeagueName(_ name: String) {
        self.leagueName.text = name
    }
    
    private func setNumberOfGames(_ numberOfGames: String) {
        self.leagueNumberOfGames.text = numberOfGames
    }
    
    private func setNumberOfTeams(_ numberOfTeams: String) {
        self.leagueNumberOfTeams.text = numberOfTeams
    }

}
