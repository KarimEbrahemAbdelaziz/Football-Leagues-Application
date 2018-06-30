//
//  DataHelperProtocol.swift
//  Football Leagues App
//
//  Created by Ahmed Shehata on 6/30/18.
//  Copyright © 2018 Karim Ebrahem. All rights reserved.
//

import Foundation

protocol DataHelperProtocol {
    associatedtype T
    static func createTable()
    static func insert(item: T)
    static func findAll() -> [T]
}

enum DataAccessError: Error {
    case Datastore_Connection_Error
    case Insert_Error
    case Delete_Error
    case Search_Error
    case Nil_In_Data
}
