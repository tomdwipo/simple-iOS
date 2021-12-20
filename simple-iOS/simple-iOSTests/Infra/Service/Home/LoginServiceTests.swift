//
//  LoginServiceTests.swift
//
//  Created by Tommy on 04/12/21.
//

import Foundation
@testable import simple_iOS
import XCTest

class HomeServiceTests: XCTestCase {
    private var messages: String!
    private var sut: HomeService!
    private var mockNetworkHelper = MockNetworkHome()
   
    override func setUp() {
        super.setUp()
        messages = ""
        sut = LoginServiceImpl(network: mockNetworkHelper)
    }
    
    override func tearDown() {
        sut = nil
        messages = nil
        super.tearDown()
    }
}
