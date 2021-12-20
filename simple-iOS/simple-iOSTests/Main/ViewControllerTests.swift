//
//  ViewControllerTests.swift
//  simple-iOSTests
//
//  Created by Tommy on 20/12/21.
//

import XCTest
@testable import simple_iOS

class ViewControllerTests: XCTestCase {

    func test_outlets_shouldBeConnected(){
        let sut = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: String(describing: ViewController.self)) as! ViewController
        sut.loadViewIfNeeded()
        XCTAssertNotNil(sut.searchBar)
        XCTAssertNotNil(sut.hospitalTextField)
        XCTAssertNotNil(sut.hospitalButton)
        XCTAssertNotNil(sut.specializationTextField)
        XCTAssertNotNil(sut.specializationButton)
        XCTAssertNotNil(sut.tableView)
        XCTAssertNotNil(sut.tableView.dataSource)
        XCTAssertNotNil(sut.tableView.delegate)

    }
   
}
