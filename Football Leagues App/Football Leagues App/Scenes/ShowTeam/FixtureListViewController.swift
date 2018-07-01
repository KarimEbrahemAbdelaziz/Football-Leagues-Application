//
//  FixtureListViewController.swift
//  Football Leagues App
//
//  Created by Ahmed Shehata on 7/1/18.
//  Copyright © 2018 Karim Ebrahem. All rights reserved.
//

import UIKit
import RxSwift

class FixtureListViewController: UIViewController {

    @IBOutlet weak var titleName: UILabel!
    @IBOutlet weak var teamName: UILabel!
    @IBOutlet weak var teamImage: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    private let disposebag = DisposeBag()
    private let remoteDS = RemoteLeagueManager()
    private var matches = [Match]()
    var teamInformation: TeamViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
        getData()
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
        titleName.text = teamInformation.teamName
        teamName.text = teamInformation.teamName
        teamImage.sd_setImage(with: URL(string: teamInformation.teamLogo), placeholderImage: UIImage(named: "football"))
    }
    
    private func getData() {
        remoteDS.getTeamFixtures(teamFixturesUrl: teamInformation.teamFixturesUrl)
            .subscribe(onNext: { [weak self] (matches) in
                self?.matches = matches
                self?.tableView.reloadData()
            }, onError: { (error) in
                self.presentAlert(message: error.localizedDescription)
            }, onCompleted: nil, onDisposed: nil)
            .disposed(by: disposebag)
    }

    private func presentAlert(message: String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true)
    }
    
    @IBAction func popView(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}

// MARK:- UITableViewDataSource and UITableViewDelegate
extension FixtureListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return matches.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if matches[indexPath.row].matchStatus == "FINISHED" {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FinishedGameCell", for: indexPath) as! FinishedGameCell
            cell.configureCell(match: matches[indexPath.row])
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ScheduledGameCell", for: indexPath) as! ScheduledGameCell
            cell.configureCell(match: matches[indexPath.row])
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if matches[indexPath.row].matchStatus == "FINISHED" {
            return 140
        } else {
            return 120
        }
    }
}
