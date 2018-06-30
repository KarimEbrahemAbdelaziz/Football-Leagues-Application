//
//  TeamDataHelper.swift
//  Football Leagues App
//
//  Created by Ahmed Shehata on 6/30/18.
//  Copyright © 2018 Karim Ebrahem. All rights reserved.
//

import Foundation
import SQLite

class TeamDataHelper: DataHelperProtocol {
    static let TABLE_NAME = "Teams"
    
    static let table = Table(TABLE_NAME)
    static let teamFixturesUrl = Expression<String>("teamFixturesUrl")
    static let teamName = Expression<String>("teamName")
    static let teamLogo = Expression<String>("teamLogo")
    
    typealias T = Team
    
    static func createTable() {
        guard let DB = LocalLeagueManager.sharedInstance.dbConnection else {
            return
        }
        do {
            let _ = try DB.run( table.create(ifNotExists: true) { table in
                table.column(teamFixturesUrl)
                table.column(teamName, unique: true)
                table.column(teamLogo)
            })
            
        } catch _ {
            // Error throw if table already exists
        }
    }
    
    static func insert(item: T) {
        guard let DB = LocalLeagueManager.sharedInstance.dbConnection else {
            return
        }
        let insert = table.insert(or: .replace, teamFixturesUrl <- item.teamFixturesUrl,
                                  teamName <- item.teamName,
                                  teamLogo <- item.teamLogo)
        do {
            let rowId = try DB.run(insert)
            guard rowId > 0 else {
                throw DataAccessError.Insert_Error
            }
        } catch _ {
        }
    }
    
    static func findAll() -> [T] {
        guard let DB = LocalLeagueManager.sharedInstance.dbConnection else {
            return []
        }
        var leagues = [T]()
        let items = try! DB.prepare(table)
        for item in items {
            leagues.append(Team(teamFixturesUrl: item[teamFixturesUrl],
                                teamName: item[teamName],
                                teamLogo: item[teamLogo]))
        }
        
        return leagues
    }
    
    static func drop() {
        guard let DB = LocalLeagueManager.sharedInstance.dbConnection else {
            return
        }
        do {
            try DB.run(table.drop(ifExists: true))
        } catch _ {
        }
    }
}
