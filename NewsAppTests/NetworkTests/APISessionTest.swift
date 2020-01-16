//
//  APISessionClientTest.swift
//  NewsAppTests
//
//  Created by Resham gurung on 07/01/2020.
//  Copyright © 2020 HAUDAE.com. All rights reserved.
//

import XCTest
@testable import NewsApp


// Given When Then
class APISessionTest: XCTestCase {

    var apiClient:  APISession?
    
    var session     = MockAPISessionType()
    
    
    override func setUp() {
        super.setUp()
        
        apiClient = APISession(session: session)
    }
    
    
    // It is called after each test method completes
    // for global call override class func tearDown()
    override func tearDown() {
        
        apiClient = nil
        
        super.tearDown()
    }
    
    
    func test_sendRequestWithURLRequest() {
        
        guard let url = URL(string: mockURLString) else {

            XCTFail("URL cannot be empty.")
            
            return
        }
        
        let urlRequest = URLRequest(url: url)
        
        apiClient?.send(request: urlRequest) { result in
            // data returned
        }
        
        if let sessionURL = session.urlRequest?.url {
            
            XCTAssert(sessionURL == url)
            
        } else {
            
            XCTFail()
        }
        
    }
    
    
    func test_resumeCalled() {
        
        let dataTask                = MockAPISessionDataTaskType()
        
        session.apiSessionDataTask  = dataTask
        
        guard let url = URL(string: mockURLString) else {

            XCTFail("URL cannot be empty.")
            
            return
        }
        
        let urlRequest = URLRequest(url: url)
        
        apiClient?.send(request: urlRequest) { result in
            // data returned
        }
        
        XCTAssert(dataTask.resumeWasCalled)
    }
    
    
    func test_sendFunctionShouldReturnData() {
        
        guard let url = URL(string: mockURLString) else {

            XCTFail("URL cannot be empty.")
            
            return
        }
        
        let urlRequest = URLRequest(url: url)
        
        let expectedData = "{}".data(using: .utf8)
        
        session.data = expectedData
        
        let successfulResponse = HTTPURLResponse(url: url, statusCode: 200, httpVersion: "HTTP/1.1", headerFields: nil)
        
        session.response = successfulResponse
        
        var actualData: Data?
        
                
        apiClient?.send(request: urlRequest) { result in
            // data returned
            //actualData = data
            switch result {
                case .failure(_):
                    
                    XCTFail()
                
                case .success(let data):
                    
                    actualData = data
            }
        }
        
        XCTAssertNotNil(actualData)
        
    }
    
    
    func test_sendFunctionShouldReturnError () {
        
        let error = ResponseError.unexpectedResponse("The response is empty.")
        
        guard let url = URL(string: mockURLString) else {

            XCTFail("URL cannot be empty.")
            
            return
        }
        
        let errorResponse       = HTTPURLResponse(url: url, statusCode: 301, httpVersion: "HTTP/1.1", headerFields: nil)

        session.response        = errorResponse
        
        let urlRequest          = URLRequest(url: url)
        
        var expectedError:      ResponseError?
        
        apiClient?.send(request: urlRequest) { result in
            // error returned
            switch result {
                
                case .failure(let error):
                    
                    expectedError = error as? ResponseError
                
                case .success(_):
                    
                    XCTFail()
            }
        }
        
        XCTAssertNotNil(expectedError)
        
        XCTAssert(expectedError == error)
        
    }
}
