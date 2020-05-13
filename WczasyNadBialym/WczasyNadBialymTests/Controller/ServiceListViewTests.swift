//
//  ServiceListViewTests.swift
//  WczasyNadBialymTests
//
//  Created by Marek Hać on 13/05/2020.
//  Copyright © 2020 Marek Hać. All rights reserved.
//

import XCTest
@testable import WczasyNadBialym

class ServiceListViewTests: XCTestCase {

    var sut: ServiceListViewController!
    
    override func setUp() {

        sut = (UIStoryboard(name: "ServiceStoryboard", bundle: nil).instantiateViewController(withIdentifier: "ServiceListViewController") as! ServiceListViewController)
        
        _ = sut.view
    }

    // MARK: Nil Checks
    
    func testServiceList_TableViewShouldNotBeNil() {
        XCTAssertNotNil(sut.tableView)
    }
    
    // MARK: Data Source
    
    func testDataSource_ViewDidLoad_SetsTableViewDataSource() {
        XCTAssertNotNil(sut.tableView.dataSource)
        XCTAssertTrue(sut.tableView.dataSource is ServiceListViewModel)
    }
    
    // MARK: Delegate
    
    func testDelegate_ViewDidLoad_SetsTableViewDelegate() {
        XCTAssertNotNil(sut.tableView.delegate)
        XCTAssertTrue(sut.tableView.delegate is ServiceListViewModel)
    }
    
    // MARK: Data Service Assumptions
    func testDataService_ViewDidLoad_SingleDataServiceObject() {
        XCTAssertEqual(sut.tableView.dataSource as! ServiceListViewModel, sut.tableView.delegate as! ServiceListViewModel)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

}
