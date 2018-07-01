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
    
    /// Call to open repository page.
    let selectTeam: AnyObserver<TeamViewModel>
    
    /// Call to reload repositories.
    let reload: AnyObserver<Void>
    
    // MARK: - Outputs
    
    /// Emits an array of fetched repositories.
    let teams: Observable<[TeamViewModel]>
    
    /// Emits an error messages to be shown.
    let alertMessage: Observable<String>
    
    /// Emits an url of repository page to be shown.
    let showTeamFixtures: Observable<String>
    
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
                $0.teamFixturesUrl
        }
        
    }
}
