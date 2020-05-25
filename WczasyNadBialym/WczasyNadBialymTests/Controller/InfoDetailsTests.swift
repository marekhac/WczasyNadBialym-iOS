//
//  InfoDetailsTests.swift
//  WczasyNadBialymTests
//
//  Created by Marek Hać on 07/08/2019.
//  Copyright © 2019 Marek Hać. All rights reserved.
//

import XCTest

@testable import WczasyNadBialym
class InfoDetailsTests: XCTestCase {

    var sut: InfoDetailsViewController!
    
    override func setUp() {
        
        super.setUp()
        
        let storyboard = UIStoryboard(name: "InfoStoryboard", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "InfoDetailsViewController")
        sut = viewController as? InfoDetailsViewController
        
        sut.loadViewIfNeeded()

    }

    override func tearDown() {

    }

    func test_NavigationItem_Contact_HasTitle() {
        sut.category = .contact
        sut.beginAppearanceTransition(true, animated: true)
        
        XCTAssertEqual(sut.navigationItem.title!, "Kontakt z nami")
    
        sut.endAppearanceTransition()
    }
    
    func test_NavigationItem_Lake_HasTitle() {
        
        sut.category = .lake
        sut.beginAppearanceTransition(true, animated: true)
        
        XCTAssertEqual(sut.navigationItem.title!, "O Jeziorze Białym")
        
        sut.endAppearanceTransition()
    }
    
    func test_NavigationItem_Essentials_HasTitle() {
        
        sut.category = .essentials
        sut.beginAppearanceTransition(true, animated: true)
        
        XCTAssertEqual(sut.navigationItem.title!, "Warto wiedzieć")
        
        sut.endAppearanceTransition()
    }
    
    func test_URL_Lake_hasValidUrl() {
       
        sut.category = .lake
        
        let url = API.Info.url[sut.category]
        
        XCTAssertEqual(url, "../mobile/lake.html")
    }
    
    func test_URL_Essentials_hasValidUrl() {
        
        sut.category = .essentials
        
        let url = API.Info.url[sut.category]
        
        XCTAssertEqual(url, "../mobile/essentials.html")
    }
    
    func test_URL_Contact_hasValidUrl() {
        
        sut.category = .contact
        
        let url = API.Info.url[sut.category]
        
        XCTAssertEqual(url, "../mobile/contact.html")
    }
    
//    func downloadHTMLContent (_ completionHandler: @escaping (_ results: Bool) -> Void) {
//        let promise = expectation(description: "Content Available")
//        sut.beginAppearanceTransition(true, animated: true)
//
//        DispatchQueue.main.async() {
//            promise.fulfill()
//
//            completionHandler(!self.sut.htmlContent.isEmpty)
//
//        }
//
//        waitForExpectations(timeout: 3)
//
//        sut.endAppearanceTransition()
//    }
    
}
