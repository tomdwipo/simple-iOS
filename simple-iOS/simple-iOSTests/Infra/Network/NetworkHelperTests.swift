//
//  NetworkHelperTests.swift
//
//  Created by Tommy on 03/12/21.
//

import XCTest
@testable import simple_iOS

class NetworkHelperTests: XCTestCase {
    private var spyURLSession: SpyURLSession!
    
    override func setUp() {
        super.setUp()
        spyURLSession = SpyURLSession()
        
    }
    
    override func tearDown() {
        spyURLSession = nil
        super.tearDown()
    }

    
    func test_networkHelper_withStatusCodeNot200_shouldResultNil(){
        let sut = NetworkHelper<HomeResponse>()
        sut.session = spyURLSession
        let errorResponseCall = expectation(description: "errorResponseCall called")
        sut.performDataTask(url: "https://Dummy", httpMethod: .post, body: nil) { AppError in
            errorResponseCall.fulfill()
        } successResponse: { response in
        }
        
        spyURLSession.dataTaskArgsCompletionHandler.first?(nil, response(statusCode: 422), nil)
        
        waitForExpectations(timeout: 0.01)
        
        XCTAssertNil(sut.result)
    }
    
    func test_networkHelper_withNilHandler_shouldResultNil(){
        let sut = NetworkHelper<HomeResponse>()
        sut.session = spyURLSession
        let errorResponseCall = expectation(description: "errorResponseCall called")
        sut.performDataTask(url: "https://Dummy", httpMethod: .post, body: nil) { AppError in
            errorResponseCall.fulfill()
        } successResponse: { response in
        }
        
        spyURLSession.dataTaskArgsCompletionHandler.first?(nil, nil, nil)
        
        waitForExpectations(timeout: 0.01)
        
        XCTAssertNil(sut.result)
    }
    

    
    func test_networkHelper_withError_shouldResultNil(){
        let sut = NetworkHelper<HomeResponse>()
        sut.session = spyURLSession
        let errorResponseCall = expectation(description: "errorResponseCall called")
        sut.performDataTask(url: "https://Dummy", httpMethod: .post, body: nil) { AppError in
            errorResponseCall.fulfill()
        } successResponse: { response in
        }
        
        spyURLSession.dataTaskArgsCompletionHandler.first?(nil, nil, Error.self as? Error)
        
        waitForExpectations(timeout: 0.5)
        
        XCTAssertNil(sut.result)
    }
    
  
    
    private func response(statusCode: Int) -> HTTPURLResponse? {
        HTTPURLResponse(url: URL(string: "https://DUMMY")!, statusCode: statusCode, httpVersion: nil, headerFields: nil)
        
    }
}
