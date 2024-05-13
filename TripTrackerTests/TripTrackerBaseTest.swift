//
//  TripTrackerBaseTest.swift
//  TripTrackerTests
//
//  Created by javier pineda on 13/05/24.
//

import XCTest
import RealmSwift
@testable import TripTracker

class TripTrackerBaseTest: XCTest {
    let apiClient = ApiClient()
    let storageContext = StorageContextImplementation(realmDB: try! Realm())
}
