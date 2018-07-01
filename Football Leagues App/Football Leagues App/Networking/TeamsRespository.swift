//
//  TeamsRespository.swift
//  Football Leagues App
//
//  Created by Karim Ebrahem on 7/1/18.
//  Copyright © 2018 Karim Ebrahem. All rights reserved.
//

import Foundation
import RxSwift

class TeamsRepository: TeamsRepositoryProtocol {
    
    var remoteDS : RemoteLeagueManager
    var localDS : TeamDataHelper
    
    init() {
        remoteDS = RemoteLeagueManager()
        localDS = TeamDataHelper()
    }
    
    func getData(from teamsUrl: String) -> Observable<[Team]> {
        
        if InternetReachability.checkInternetConnectionUsingAlamofire() {
            // Getting data from remote
            return remoteDS.getLeagueTeams(leagueTeamsUrl: teamsUrl)
        } else {
            // Getting data from local
            return Observable.from(optional: localDS.findAll(), scheduler: MainScheduler.instance)
        }
        
    }
    
}
