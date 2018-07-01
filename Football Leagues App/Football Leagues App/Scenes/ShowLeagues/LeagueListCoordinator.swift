//
//  LeagueListCoordinator.swift
//  Football Leagues App
//
//  Created by Ahmed Shehata on 7/1/18.
//  Copyright © 2018 Karim Ebrahem. All rights reserved.
//

import UIKit
import RxSwift
import SafariServices

class LeagueListCoordinator: BaseCoordinator<Void> {
    
    private let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    override func start() -> Observable<Void> {
        let viewModel = LeagueListViewModel()
        let viewController = LeagueListViewController.initFromStoryboard(name: "Main")
        let navigationController = UINavigationController(rootViewController: viewController)
        
        viewController.viewModel = viewModel
        
        viewModel.showLeagueTeams
            .subscribe({ [weak self] in self?.showLeagueTeams(by: $0.element!, in: navigationController) })
            .disposed(by: disposeBag)
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        return Observable.never()
    }
    
    private func showLeagueTeams(by url: String, in navigationController: UINavigationController) -> Observable<Void> {
        let teamListCoordinator = TeamListCoordinator(navigationController: navigationController)
        return coordinate(to: teamListCoordinator)
    }

}
