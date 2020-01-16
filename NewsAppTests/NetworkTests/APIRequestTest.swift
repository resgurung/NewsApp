//
//  APIRequestTest.swift
//  NewsAppTests
//
//  Created by Resham gurung on 08/01/2020.
//  Copyright © 2020 HAUDAE.com. All rights reserved.
//

import XCTest
@testable import NewsApp


// Given When Then
class APIRequestTest: XCTestCase {

    var sut: APIRequest?
    
    
    
    override func setUp() {
        super.setUp()
        
        sut = APIRequest()
    }

    override func tearDown() {
        
        sut = nil
        
        super.tearDown()
    }
    
    
    func test_buildURLRequest() {
        
        let endPoint = MockEndPoint(
            baseURL: URLFactory().make(schema: AppConstant.API.SCHEMA, enviromentURL: AppConfig.networkEnviroment.enviroment),
            urlPath: .headlineArticle,
            httpMethod: .get,
            task: .requestWithURLParameters(encoding: .urlEncoding, urlParameters: [
                "country"   : "GB",
                "apiKey"    : AppConstant.Key.NEWS_API_KEY,
                "page"      : 1,
                "count"     : 10
            ]),
            httpHeaders: [
                .accept,
                .contentType
            ])
        
        let request = try? sut?.build(endPoint: endPoint)
        
        XCTAssertNotNil(request)
    }
    
    func test_URLPath() {
        
        let endPoint = MockEndPoint(
            baseURL: URLFactory().make(schema: "https", enviromentURL: "example.com"),
            urlPath: .headlineArticle,
            httpMethod: .get,
            task: .requestWithURLParameters(encoding: .urlEncoding, urlParameters: [:]),
            httpHeaders: []
        )
        
        let expectedURL = URL(string: "https://example.com/")
        
        let request = try? sut?.build(endPoint: endPoint)
        
        XCTAssertNotNil(request?.url)
        
        if let url = request?.url {
            
            XCTAssertEqual(url, expectedURL)
            
        } else {
            
            XCTFail("URL not set.")
        }
    }

    
    func test_HTTPMethod() {
        
        let endPoint = MockEndPoint(
            baseURL: URLFactory().make(schema: "https", enviromentURL: "example.com"),
            urlPath: .headlineArticle,
            httpMethod: .get,
            task: .requestWithURLParameters(encoding: .urlEncoding, urlParameters: [:]),
            httpHeaders: []
        )
        
        let request = try? sut?.build(endPoint: endPoint)
        
        let expectedHTTPMethod: HTTPMethod  = .get
        
        XCTAssertNotNil(request?.httpMethod)
        
        if let method = request?.httpMethod {
            
            XCTAssertEqual(method, expectedHTTPMethod.rawValue)
            
        } else {
            
            XCTFail("HTTPMethod not set.")
        }
    }
    
    func test_Task() {
        //TODO: Write task
        
    }
    
    func test_HTTPHeaders() {
        
        let endPoint = MockEndPoint(
            baseURL: URLFactory().make(schema: "https", enviromentURL: "example.com"),
            urlPath: .headlineArticle,
            httpMethod: .get,
            task: .requestWithURLParameters(encoding: .urlEncoding, urlParameters: [:]),
            httpHeaders: [.accept]
        )
        
        let request = try? sut?.build(endPoint: endPoint)
        
        let expectedHeaders = "application/json; charset=utf-8"
        
        XCTAssertNotNil(request?.allHTTPHeaderFields)
        
        if let headers = request?.allHTTPHeaderFields {
            
            XCTAssertEqual(headers["Accept"], expectedHeaders)
            
        } else {
            XCTFail("Headers not set.")
        }
    }
}
