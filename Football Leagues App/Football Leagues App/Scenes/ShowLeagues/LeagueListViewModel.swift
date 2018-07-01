//
//  LeagueListViewModel.swift
//  Football Leagues App
//
//  Created by Ahmed Shehata on 7/1/18.
//  Copyright © 2018 Karim Ebrahem. All rights reserved.
//

import Foundation
import RxSwift

class LeagueListViewModel {
    
    // MARK: - Inputs
    
    /// Call to open repository page.
    let selectLeague: AnyObserver<LeagueViewModel>
    
    /// Call to reload repositories.
    let reload: AnyObserver<Void>
    
    // MARK: - Outputs
    
    /// Emits a formatted title for a navigation item.
    let title: Observable<String>
    
    /// Emits an array of fetched repositories.
    let leagues: Observable<[LeagueViewModel]>
    
    /// Emits an error messages to be shown.
    let alertMessage: Observable<String>
    
    /// Emits an url of repository page to be shown.
    let showLeagueTeams: Observable<String>
    
    init(leagueRepository: LeaguesRepository = LeaguesRepository()) {
        
        let _reload = PublishSubject<Void>()
        self.reload = _reload.asObserver()
        
        let _alertMessage = PublishSubject<String>()
        self.alertMessage = _alertMessage.asObservable()
        
        self.leagues = Observable.asObservable(_reload)()
            .flatMapLatest { language in
                leagueRepository.getData()
                    .catchError { error in
                        _alertMessage.onNext(error.localizedDescription)
                        return Observable.empty()
                }
            }
            .map { leagues in leagues.map(LeagueViewModel.init) }
        
        let _selectLeague = PublishSubject<LeagueViewModel>()
        self.selectLeague = _selectLeague.asObserver()
        self.showLeagueTeams = _selectLeague.asObservable()
            .map {
                $0.leagueTeamsUrl
        }
        
        self.title = Observable.from(["Football Leagues"])
            .map { "\($0)" }
    }
}
