//
//  EventListViewTests.swift
//  WczasyNadBialymTests
//
//  Created by Marek Hać on 26/08/2019.
//  Copyright © 2019 Marek Hać. All rights reserved.
//

import XCTest
@testable import WczasyNadBialym
class EventListViewTests: XCTestCase {

    var sut: EventListViewController!
    var viewModel: EventsListViewModel!
    
    var cell: EventListCell {
        let indexPath = NSIndexPath(row: 0, section: 0)
        return sut.tableView.dataSource?.tableView(sut.tableView, cellForRowAt: indexPath as IndexPath) as! EventListCell
    }
            
    var eventDate : Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        return formatter.date(from: "2019/12/31 22:34")!
    }
    
    let eventId = 12
    let eventName = "Event name"
    let eventPlace = "Event place"
    
    override func setUp() {
        let storyboard = UIStoryboard(name: "EventStoryboard", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "EventListViewController")
        
        viewModel = EventsListViewModel()
        viewModel.events = [EventModel(id: eventId, name: eventName, place: eventPlace, date: eventDate)]

        sut = viewController as? EventListViewController
        sut.viewModel = viewModel
        
        sut.loadView()
        sut.viewDidLoad()
    }

    override func tearDown() {
    }

    // MARK: - EventListCell

    func test_Cell_hasValidId() {
        XCTAssertEqual(cell.eventId, eventId)
    }
    
    func test_Cell_hasValidName() {
        XCTAssertEqual(cell.name.text, eventName)
    }
    
    func test_Cell_hasValidDate() {
        XCTAssertEqual(cell.date.text, "31.12.2019, godz. 22:34")
    }
    
    // MARK: - Table view Tests
    
    func test_TableView_notNil() {
        XCTAssertNotNil(sut.tableView)
    }
    
    func test_TableView_hasCorrectNumberOfRows() {
        let expectedNumberOfRows = 1
                
        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), expectedNumberOfRows)
    }
        
    func test_TableView_isConnectedToDelegate() {
        XCTAssertNotNil(sut.tableView.delegate, "TableView delegate cannot be nil")
    }
    
    func test_TableView_isConnectedToDatasource() {
        XCTAssertNotNil(sut.tableView.dataSource, "TableView datasource cannot be nil")
    }

    func test_TableView_cellHasReuseIdentifier() {
        let expectedReuseIdentifier = "eventsListCell"
        XCTAssertEqual(cell.reuseIdentifier, expectedReuseIdentifier)
    }
    
}
