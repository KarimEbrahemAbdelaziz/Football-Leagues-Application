//
//  TeamListCoordinator.swift
//  Football Leagues App
//
//  Created by Ahmed Shehata on 7/1/18.
//  Copyright © 2018 Karim Ebrahem. All rights reserved.
//

import UIKit
import RxSwift

class TeamListCoordinator: BaseCoordinator<Void> {
    
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    override func start() -> Observable<Void> {
        let viewController = TeamListViewController.initFromStoryboard(name: "Main")
//        let navigationController = UINavigationController(rootViewController: viewController)
        
//        let viewModel = LanguageListViewModel()
//        viewController.viewModel = viewModel
        
//        rootViewController.present(navigationController, animated: true)
        self.navigationController.pushViewController(viewController, animated: true)
        
        return Observable.never()
    }
}
