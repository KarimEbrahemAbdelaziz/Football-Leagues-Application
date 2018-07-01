//
//  LeagueRepository.swift
//  Football Leagues App
//
//  Created by Ahmed Shehata on 7/1/18.
//  Copyright © 2018 Karim Ebrahem. All rights reserved.
//

import Foundation
import RxSwift

class LeaguesRepository: LeagueRepositoryProtocol {
    
    var remoteDS : RemoteLeagueManager
    var localDS : LeagueDataHelper
    
    init() {
        remoteDS = RemoteLeagueManager()
        localDS = LeagueDataHelper()
    }
    
    func getData() -> Observable<[League]> {
        
        if InternetReachability.checkInternetConnectionUsingAlamofire() {
            // Getting data from remote
            return remoteDS.getLeagues()
        } else {
            // Getting data from local
            return Observable.from(optional: localDS.findAll(), scheduler: MainScheduler.instance)
        }
        
    }
    
}
