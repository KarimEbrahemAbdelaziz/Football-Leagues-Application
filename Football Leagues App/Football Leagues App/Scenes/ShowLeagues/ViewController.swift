//
//  ViewController.swift
//  Football Leagues App
//
//  Created by Ahmed Shehata on 6/30/18.
//  Copyright © 2018 Karim Ebrahem. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let leagueManager = RemoteLeagueManager()
        let localDatabase = LocalLeagueManager.sharedInstance
        localDatabase.createTables()
        
        _ = leagueManager.getLeagues().subscribe(onNext: { (leagues) in
            _ = leagues.map({ (league) in
                LeagueDataHelper.insert(item: league)
            })
        }, onError: { (error) in
            print("Error OnError")
        }, onCompleted: {
            print("Completed")
            let leagues = LeagueDataHelper.findAll().map { (league) in
                print("\(league.league) \(league.caption)")
            }
        }) {
            print("Disposed")
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

