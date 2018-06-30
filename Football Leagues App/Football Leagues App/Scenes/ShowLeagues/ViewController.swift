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
        let leagueManager = LeagueManager()
        leagueManager.getLeagues().subscribe(onNext: { (value) in
            print(value.count)
            print(value.first!)
        }, onError: { (error) in
            print(error)
        }, onCompleted: {
            print("completed")
        }) {
            print("Disposed")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

