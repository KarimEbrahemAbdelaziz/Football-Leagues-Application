//
//  LeagueListViewModel.swift
//  Football Leagues App
//
//  Created by Karim Ebrahem on 7/1/18.
//  Copyright © 2018 Karim Ebrahem. All rights reserved.
//

import Foundation
import RxSwift

class LeagueListViewModel {
    
    // MARK: - Inputs
    
    let selectLeague: AnyObserver<LeagueViewModel>
    
    let reload: AnyObserver<Void>
    
    // MARK: - Outputs
    
    let title: Observable<String>
    
    let leagues: Observable<[LeagueViewModel]>
    
    let alertMessage: Observable<String>
    
    let showLeagueTeams: Observable<LeagueViewModel>
    
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
                $0
        }
        
        self.title = Observable.from(["Football Leagues"])
            .map { "\($0)" }
    }
}
