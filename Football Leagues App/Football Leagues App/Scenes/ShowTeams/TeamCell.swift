//
//  TeamCell.swift
//  Football Leagues App
//
//  Created by Karim Ebrahem on 7/1/18.
//  Copyright © 2018 Karim Ebrahem. All rights reserved.
//

import UIKit
import SDWebImage

class TeamCell: UITableViewCell {
    
    @IBOutlet weak var teamImage: UIImageView!
    @IBOutlet weak var teamName: UILabel!
    
    func configureCell(team: TeamViewModel) {
        self.teamName.text = team.teamName
        teamImage.sd_setImage(with: URL(string: team.teamLogo), placeholderImage: UIImage(named: "football"))
    }
}
