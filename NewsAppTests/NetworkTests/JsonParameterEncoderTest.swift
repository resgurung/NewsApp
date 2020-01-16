//
//  JsonParameterEncoderTest.swift
//  NewsAppTests
//
//  Created by Resham gurung on 09/01/2020.
//  Copyright © 2020 HAUDAE.com. All rights reserved.
//

import XCTest
@testable import NewsApp


// Given When Then
class JsonParameterEncoderTest: XCTestCase {

    var sut: JsonParameterEncoder?
    
    override func setUp() {
        super.setUp()
        
        sut = JsonParameterEncoder()
    }

    override func tearDown() {
        
        sut = nil
        
        super.tearDown()
    }
    
    func test_JsonParameterEncoder_throws() {
        
        guard let url = URL(string: mockURLString) else {

            XCTFail("URL cannot be empty.")
            
            return
        }
        
        var urlRequest = URLRequest(url: url)
        
        let invalidUnicodeString = String(bytes: [0xD8, 0x00] as [UInt8], encoding: String.Encoding.utf16BigEndian)
        
        guard let bogusString = invalidUnicodeString else {
            
            XCTFail("Please supply a bogus string.")
            
            return
        }
        
        let para: Parameters = [ "title": bogusString ]
        
        let expectedError: EncodingError = .notSerializable
        
        XCTAssertThrowsError(try sut?.encode(urlRequest: &urlRequest, with: para)) { error in

            XCTAssertNotNil(error)
            
            guard let thrownError = error as? EncodingError else {
                
                XCTFail("Error should be EncodingError")
                
                return
            }
            
            XCTAssertEqual(expectedError, thrownError)
        }
    }
    
    func test_serialize() {
        
        let invalidUnicodeString = String(bytes: [0xD8, 0x00] as [UInt8], encoding: String.Encoding.utf16BigEndian)
        
        guard let bogusString = invalidUnicodeString else {
            
            XCTFail("Please supply a bogus string.")
            
            return
        }
        
        let para: Parameters = [ "title": bogusString ]
        
        let expectedError: EncodingError = .encodingFail
        
        XCTAssertThrowsError(try sut?.serialize(para)) { error in

            XCTAssertNotNil(error)
            
            guard let thrownError = error as? EncodingError else {
                
                XCTFail("Error should be EncodingError")
                
                return
            }
            
            XCTAssertEqual(expectedError, thrownError)
        }
    }
    
    func test_serializeFunctionReturnsData() {
        
        let country = MockCountry(name: "Nepal")
        
        let returnedData = try? sut?.serialize(country.getDict())
        
        XCTAssert( (returnedData as Any) is Data)
    }
    
    func test_encodeParametersToURLRequest() {
        
        guard let url = URL(string: mockURLString) else {

            XCTFail("URL cannot be empty.")
            
            return
        }
        
        var urlRequest = URLRequest(url: url)
        
        let country = MockCountry(name: "Nepal")
        
        try? sut?.encode(urlRequest: &urlRequest, with: country.getDict())
        
        let decoder = JSONDecoder()
        
        let urlHTTPBody = urlRequest.httpBody
        
        guard let unwrappedBody = urlHTTPBody else {
            
            XCTFail("Should have a httpbody.")
            
            return
        }
        
        let expectedCountry = try? decoder.decode(MockCountry.self, from: unwrappedBody)
        
        XCTAssertNotNil(expectedCountry)
        
        guard let unwrappedExpectedCountry = expectedCountry else {
            
            XCTFail("Should have a Country obj.")
            
            return
        }
        
        XCTAssertEqual(country.name, unwrappedExpectedCountry.name)
        
    }

}
