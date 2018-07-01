//
//  LeagueDataHelper.swift
//  Football Leagues App
//
//  Created by Ahmed Shehata on 6/30/18.
//  Copyright © 2018 Karim Ebrahem. All rights reserved.
//

import Foundation
import SQLite

class LeagueDataHelper: DataHelperProtocol {
    
    private let table = Table("Leagues")
    private let leagueTeamsUrl = Expression<String>("leagueTeamsUrl")
    private let caption = Expression<String>("caption")
    private let leagueShort = Expression<String>("league")
    private let numberOfTeams = Expression<Int>("numberOfTeams")
    private let numberOfGames = Expression<Int>("numberOfGames")
    
    typealias T = League
    
    init() {
        createTable()
    }
    
    private func createTable() {
        guard let DB = LocalLeagueManager.sharedInstance.dbConnection else {
            return
        }
        do {
            let _ = try DB.run( table.create(ifNotExists: true) { table in
                table.column(leagueTeamsUrl)
                table.column(caption, unique: true)
                table.column(leagueShort)
                table.column(numberOfTeams)
                table.column(numberOfGames)
            })
            
        } catch _ {
            // Error throw if table already exists
        }
    }
    
    func insert(item: T) {
        guard let DB = LocalLeagueManager.sharedInstance.dbConnection else {
            return
        }
        let insert = table.insert(or: .replace, leagueTeamsUrl <- item.leagueTeamsUrl,
                                  caption <- item.caption,
                                  leagueShort <- item.league,
                                  numberOfTeams <- item.numberOfTeams,
                                  numberOfGames <- item.numberOfGames)
        do {
            let rowId = try DB.run(insert)
            guard rowId > 0 else {
                throw DataAccessError.Insert_Error
            }
        } catch _ {
        }
    }
    
    func findAll() -> [T] {
        guard let DB = LocalLeagueManager.sharedInstance.dbConnection else {
            return []
        }
        var leagues = [T]()
        let items = try! DB.prepare(table)
        for item in items {
            leagues.append(League(leagueTeamsUrl: item[leagueTeamsUrl],
                                   caption: item[caption],
                                   league: item[leagueShort],
                                   numberOfTeams: item[numberOfTeams],
                                   numberOfGames: item[numberOfGames]))
        }
        
        return leagues
    }
    
    func drop() {
        guard let DB = LocalLeagueManager.sharedInstance.dbConnection else {
            return
        }
        do {
            try DB.run(table.drop(ifExists: true))
        } catch _ {
        }
    }
}
