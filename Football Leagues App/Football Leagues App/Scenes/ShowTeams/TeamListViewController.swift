//
//  TeamListViewController.swift
//  Football Leagues App
//
//  Created by Ahmed Shehata on 7/1/18.
//  Copyright © 2018 Karim Ebrahem. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class TeamListViewController: UIViewController {

    private enum SegueType: String {
        case teamFixtureList = "showFixture"
    }
    
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet weak var leagueTitle: UILabel!
    @IBOutlet weak var popButton: UIButton!
    
    private let refreshControl = UIRefreshControl()
    private let disposeBag = DisposeBag()
    var viewModel: TeamListViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setupUI()
        setupBindings()
        
        refreshControl.sendActions(for: .valueChanged)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    private func setupUI() {
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120
        tableView.insertSubview(refreshControl, at: 0)
    }
    
    private func setupBindings() {
        popButton.rx.controlEvent(UIControlEvents.touchUpInside).asObservable()
            .subscribe(onNext: { (_) in
                self.navigationController?.popViewController(animated: true)
            }, onError: { (error) in
                print(error)
            }, onCompleted: {
                print("Completed")
            }) {
                print("Disposed")
        }
        .disposed(by: disposeBag)
        
        // View Model outputs to the View Controller
        
        viewModel.teams
            .observeOn(MainScheduler.instance)
            .do(onNext: { [weak self] _ in self?.refreshControl.endRefreshing() })
            .bind(to: tableView.rx.items(cellIdentifier: "TeamCell", cellType: TeamCell.self)) { [weak self] (_, team, cell) in
                self?.setupTeamCell(cell, team: team)
            }
            .disposed(by: disposeBag)
        
        viewModel.alertMessage
            .subscribe(onNext: { [weak self] in self?.presentAlert(message: $0) })
            .disposed(by: disposeBag)
        
        viewModel.showTeamFixtures
            .subscribe({ [weak self] _ in self?.openTeamFixturesList() })
            .disposed(by: disposeBag)
        
        // View Controller UI actions to the View Model
        
        refreshControl.rx.controlEvent(.valueChanged)
            .bind(to: viewModel.reload)
            .disposed(by: disposeBag)
        
        tableView.rx.modelSelected(TeamViewModel.self)
            .bind(to: viewModel.selectTeam)
            .disposed(by: disposeBag)
    }
    
    private func setupTeamCell(_ cell: TeamCell, team: TeamViewModel) {
        cell.selectionStyle = .none
        cell.configureCell(team: team)
    }
    
    private func presentAlert(message: String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true)
    }
    
    // MARK: - Navigation
    
    private func openTeamFixturesList() {
        performSegue(withIdentifier: SegueType.teamFixtureList.rawValue, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var destinationVC: UIViewController? = segue.destination
        
        if let nvc = destinationVC as? UINavigationController {
            destinationVC = nvc.viewControllers.first
        }
        
        if let viewController = destinationVC as? FixtureListViewController, segue.identifier == SegueType.teamFixtureList.rawValue {
            prepareFixtureListViewController(viewController)
        }
    }
    
    /// Setups `FixtureListViewController` befor navigation.
    ///
    /// - Parameter viewController: `FixtureListViewController` to prepare.
    private func prepareFixtureListViewController(_ viewController: FixtureListViewController) {
        
        //        let languageListViewModel = LanguageListViewModel()
        //
        //        let dismiss = Observable.merge([
        //            languageListViewModel.didCancel,
        //            languageListViewModel.didSelectLanguage.map { _ in }
        //            ])
        //
        //        dismiss
        //            .subscribe(onNext: { [weak self] in self?.dismiss(animated: true) })
        //            .disposed(by: viewController.disposeBag)
        //
        //        languageListViewModel.didSelectLanguage
        //            .bind(to: viewModel.setCurrentLanguage)
        //            .disposed(by: viewController.disposeBag)
        //
        //        viewController.viewModel = languageListViewModel
    }

}
