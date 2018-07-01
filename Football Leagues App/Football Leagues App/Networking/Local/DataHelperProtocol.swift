//
//  DataHelperProtocol.swift
//  Football Leagues App
//
//  Created by Karim Ebrahem on 6/30/18.
//  Copyright © 2018 Karim Ebrahem. All rights reserved.
//

import Foundation

protocol DataHelperProtocol {
    associatedtype T
    func insert(item: T)
    func findAll() -> [T]
    func drop()
}

enum DataAccessError: Error {
    case Datastore_Connection_Error
    case Insert_Error
    case Delete_Error
    case Search_Error
    case Nil_In_Data
}
