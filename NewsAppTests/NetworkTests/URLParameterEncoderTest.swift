//
//  URLParameterEncoderTest.swift
//  NewsAppTests
//
//  Created by Resham gurung on 09/01/2020.
//  Copyright © 2020 HAUDAE.com. All rights reserved.
//

import XCTest
@testable import NewsApp


// Given When Then
class URLParameterEncoderTest: XCTestCase {
    
    var urLParameterEncoder: URLParameterEncoder?

    override func setUp() {
        super.setUp()
        
        urLParameterEncoder = URLParameterEncoder()
    }

    override func tearDown() {
        
        urLParameterEncoder = nil
        
        super.tearDown()
    }
    
    func test_URLParameterEncoder_throws() {
        
        guard let url = URL(string: mockURLString) else {

            XCTFail("URL cannot be empty.")
            
            return
        }
        
        var urlRequest = URLRequest(url: url)
        
        urlRequest.url = nil
        
        let expectedError: EncodingError = .missingURL
        
        XCTAssertThrowsError(try urLParameterEncoder?.encode(urlRequest: &urlRequest, with: [:])) { error in

            XCTAssertNotNil(error)
            
            guard let thrownError = error as? EncodingError else {
                
                XCTFail("Error should be EncodingError")
                
                return
            }
            
            XCTAssertEqual(expectedError, thrownError)
        }
        
    }
    
    func test_URLParameterEncoderEncodes() {
        
        let expectedURL = URL(string: "\(mockURLString)?name=Nepal")
        
        guard let url = URL(string: mockURLString) else {

            XCTFail("URL cannot be empty.")
            
            return
        }
        
        var urlRequest = URLRequest(url: url)
        
        let expectedCountry = MockCountry(name: "Nepal")
        
        try? urLParameterEncoder?.encode(urlRequest: &urlRequest, with: expectedCountry.getDict())
        
        XCTAssertNotNil(urlRequest.url)
        
        guard let returnedURL = urlRequest.url else {
            
            XCTFail("URL cannot be empty.")
            
            return
        }
        
        XCTAssertEqual(returnedURL, expectedURL)
    }

}
