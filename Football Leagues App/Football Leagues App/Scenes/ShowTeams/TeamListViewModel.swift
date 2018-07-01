//
//  TeamListViewModel.swift
//  Football Leagues App
//
//  Created by Ahmed Shehata on 7/1/18.
//  Copyright © 2018 Karim Ebrahem. All rights reserved.
//

import Foundation
import RxSwift

class TeamListViewModel {
    
    // MARK: - Inputs
    
    let selectTeam: AnyObserver<TeamViewModel>
    
    let reload: AnyObserver<Void>
    
    // MARK: - Outputs
    
    let teams: Observable<[TeamViewModel]>
    
    let alertMessage: Observable<String>
    
    let showTeamFixtures: Observable<TeamViewModel>
    
    init(teamsUrl: String, teamsRepository: TeamsRepository = TeamsRepository()) {
        
        let _reload = PublishSubject<Void>()
        self.reload = _reload.asObserver()
        
        let _alertMessage = PublishSubject<String>()
        self.alertMessage = _alertMessage.asObservable()
        
        self.teams = Observable.asObservable(_reload)()
            .flatMapLatest { language in
                teamsRepository.getData(from: teamsUrl)
                    .catchError { error in
                        _alertMessage.onNext(error.localizedDescription)
                        return Observable.empty()
                }
            }
            .map { teams in teams.map(TeamViewModel.init) }
        
        let _selectTeam = PublishSubject<TeamViewModel>()
        self.selectTeam = _selectTeam.asObserver()
        self.showTeamFixtures = _selectTeam.asObservable()
            .map {
                $0
        }
        
    }
}
