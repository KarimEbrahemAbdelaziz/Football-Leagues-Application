//
//  ViewController.swift
//  Football Leagues App
//
//  Created by Ahmed Shehata on 6/30/18.
//  Copyright © 2018 Karim Ebrahem. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class LeagueListViewController: UIViewController, StoryboardInitializable {

    @IBOutlet private weak var tableView: UITableView!
    
    private let refreshControl = UIRefreshControl()
    private let disposeBag = DisposeBag()
    
    var viewModel: LeagueListViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupBindings()
        
        refreshControl.sendActions(for: .valueChanged)
    }

    private func setupUI() {
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120
        tableView.insertSubview(refreshControl, at: 0)
    }
    
    private func setupBindings() {
        
        // View Model outputs to the View Controller
        
        viewModel.leagues
            .observeOn(MainScheduler.instance)
            .do(onNext: { [weak self] _ in self?.refreshControl.endRefreshing() })
            .bind(to: tableView.rx.items(cellIdentifier: "LeagueCell", cellType: LeagueCell.self)) { [weak self] (_, league, cell) in
                self?.setupLeagueCell(cell, league: league)
            }
            .disposed(by: disposeBag)
        
        viewModel.alertMessage
            .subscribe(onNext: { [weak self] in self?.presentAlert(message: $0) })
            .disposed(by: disposeBag)
        
        viewModel.title
            .bind(to: navigationItem.rx.title)
            .disposed(by: disposeBag)
        
        // View Controller UI actions to the View Model
        
        refreshControl.rx.controlEvent(.valueChanged)
            .bind(to: viewModel.reload)
            .disposed(by: disposeBag)
        
        tableView.rx.modelSelected(LeagueViewModel.self)
            .bind(to: viewModel.selectLeague)
            .disposed(by: disposeBag)
        
    }
    
    private func setupLeagueCell(_ cell: LeagueCell, league: LeagueViewModel) {
        cell.selectionStyle = .none
        cell.configureCell(with: league)
    }
    
    private func presentAlert(message: String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true)
    }


}

