//
//  ScheduledGameCell.swift
//  Football Leagues App
//
//  Created by Ahmed Shehata on 7/1/18.
//  Copyright © 2018 Karim Ebrahem. All rights reserved.
//

import UIKit

class ScheduledGameCell: UITableViewCell {

    @IBOutlet weak var date: UILabel!
    
    func configureCell(match: Match) {
        date.text = match.matchDate
    }
}
