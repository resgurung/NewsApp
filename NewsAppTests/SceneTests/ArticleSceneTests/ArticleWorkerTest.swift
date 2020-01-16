//
//  ArticleWorkerTest.swift
//  NewsAppTests
//
//  Created by Resham gurung on 14/01/2020.
//  Copyright © 2020 HAUDAE.com. All rights reserved.
//

import XCTest
@testable import NewsApp

class ArticleWorkerTest: XCTestCase {

    var sut: ArticleWorker?
    
    let serviceMock = APIServiceMock()
    
    override func setUp() {
        super.setUp()
        
        let endPoint = MockEndPoint(
            baseURL: URLFactory().make(schema: "https", enviromentURL: "example.com"),
            urlPath: .headlineArticle,
            httpMethod: .get,
            task: .requestWithURLParameters(encoding: .urlEncoding, urlParameters: [:]),
            httpHeaders: [.accept]
        )
        
        sut = ArticleWorker(endPoint: endPoint, service: serviceMock)
    }

    override func tearDown() {
        
        sut = nil
        
        super.tearDown()
    }

    
    func test_fetch_shouldFetchArticle() {
        
        sut?.fetch(ofType: DataContainer<[Article]>.self, completion: { data,error in
            
        })
        
        XCTAssertTrue(serviceMock.fetchWasCalled)
    }

}
