//
//  FinishedGameCell.swift
//  Football Leagues App
//
//  Created by Karim Ebrahem on 7/1/18.
//  Copyright © 2018 Karim Ebrahem. All rights reserved.
//

import UIKit

class FinishedGameCell: UITableViewCell {

    @IBOutlet weak var results: UILabel!
    @IBOutlet weak var date: UILabel!
    
    func configureCell(match: Match) {
        results.text = "\(match.matchResuslt!.goalsAwayTeam) : \(match.matchResuslt!.goalsHomeTeam)"
        date.text = match.matchDate
    }

}
