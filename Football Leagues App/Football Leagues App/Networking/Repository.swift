//
//  Repository.swift
//  Football Leagues App
//
//  Created by Ahmed Shehata on 7/1/18.
//  Copyright © 2018 Karim Ebrahem. All rights reserved.
//

import Foundation
import RxSwift

protocol LeagueRepositoryProtocol {
    func getData() -> Observable<[League]>
}
