//
//  APIServiceTest.swift
//  NewsAppTests
//
//  Created by Resham gurung on 09/01/2020.
//  Copyright © 2020 HAUDAE.com. All rights reserved.
//

import XCTest
@testable import NewsApp


// Given When Then
class APIServiceTest: XCTestCase {

    var sut: APIService?
    
    var endPoint: MockEndPoint!
    
    let mockSession  = MockAPISession(session: URLSession.shared)
    
    override func setUp() {
        super.setUp()
        
        endPoint = MockEndPoint(
            baseURL: URLFactory().make(schema: "https", enviromentURL: "example.com"),
            urlPath: .headlineArticle,
            httpMethod: .get,
            task: .requestWithURLParameters(encoding: .urlEncoding, urlParameters: [:]),
            httpHeaders: [.accept]
        )
        
        sut = APIService(apiRequestType: APIRequest(), apiSession: mockSession)
    }

    override func tearDown() {
        
        sut = nil
        
        super.tearDown()
    }
    
    func test_fetch_sendshouldGetCalled() {
        
        sut?.fetch(response: DataContainer<[Article]>.self, with: endPoint, completion: { result, error in
            
        })
        
        XCTAssertTrue(mockSession.sendWasCalled)
    }

    func test_fetchData() {
        
        mockSession.fileName = "Articles"
        
        sut?.fetch(response: DataContainer<[Article]>.self, with: endPoint, completion: { articles, error in
                
            XCTAssertNil(error)
            
            XCTAssertNotNil(articles)
            
            guard let data = articles else {
                
                XCTFail("No data retrived.")
                
                return
            }
            
            XCTAssert(data.articles.count > 0)
        })
    }
    
    func test_fetchError() {
        
        let expectedError: ResponseError = .unexpectedResponse("Simulating network error.")
        
        mockSession.error = .unexpectedResponse("Simulating network error.")
        
        sut?.fetch(response: DataContainer<[Article]>.self, with: endPoint, completion: { articles, error in
                
            XCTAssertNil(articles)
            
            XCTAssertNotNil(error)
            
            guard let returnedError = error as? ResponseError else {
                
                XCTFail("Should return ResponseError.")
                
                return
            }
            
            XCTAssertEqual(expectedError, returnedError )
    
        })
    }

    
    func test_decode() {
       //TODO: Test all Decoding Error when decoded handle do{}catch{} try errors
    }
}
