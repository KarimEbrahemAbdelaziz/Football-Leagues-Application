//
//  LocalLeagueManager.swift
//  Football Leagues App
//
//  Created by Ahmed Shehata on 6/30/18.
//  Copyright © 2018 Karim Ebrahem. All rights reserved.
//

import Foundation
import SQLite

class LocalLeagueManager {

    static let sharedInstance = LocalLeagueManager()
    let dbConnection: Connection?
    
    private init() {
        var path = "LeagueDatabase.sqlite"
        let dirs = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory,
                                                       FileManager.SearchPathDomainMask.allDomainsMask, true) as [NSString]
        let dir = dirs[0]
        path = dir.appendingPathComponent("LeagueDatabase.sqlite")
        
        
        do {
            dbConnection = try Connection(path)
        } catch _ {
            dbConnection = nil
        }
    }

}
