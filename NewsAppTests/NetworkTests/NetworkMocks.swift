//
//  Mocks.swift
//  NewsAppTests
//
//  Created by Resham gurung on 09/01/2020.
//  Copyright © 2020 HAUDAE.com. All rights reserved.
//

import XCTest
@testable import NewsApp


    //MARK: Mock URL String
let mockURLString = "https://example.com"

    //MARK: MockCountry
struct MockCountry: Codable {
    
    var name: String
       
    
    func getDict() -> [String: String] {
        
        return ["name": name]
    }
}

    //MARK: Mock APISessionType
class MockAPISessionType: APIURLSessionType {
    
    var apiSessionDataTask  = MockAPISessionDataTaskType()
    
    var data:               Data?
    
    var response:           URLResponse?
    
    var error:              Error?
    
    private (set) var urlRequest: URLRequest?
    
    
    func dataTask(with request: URLRequest, completion: @escaping APISessionCompletion) -> APISessionDataTaskType {
        
        urlRequest = request
        
        completion(data,response, error)
        
        return apiSessionDataTask
    }
}

    //MARK: Mock APISessionDataTaskType
class MockAPISessionDataTaskType: APISessionDataTaskType {
    
    private (set) var resumeWasCalled = false
    
    
    func resume() {
        
        resumeWasCalled = true
    }
}

// MARK: Mock EndPointType

struct MockEndPoint: EndPointType {
    
    var baseURL: URL
    
    var urlPath: Path
    
    var httpMethod: HTTPMethod
    
    var task: HTTPTask
    
    var httpHeaders: [HTTPHeader]
    
    
    init(baseURL: URL, urlPath: Path, httpMethod: HTTPMethod, task: HTTPTask, httpHeaders: [HTTPHeader]) {
        
        self.baseURL = baseURL
        
        self.urlPath = urlPath
        
        self.httpMethod = httpMethod
        
        self.task = task
        
        self.httpHeaders = httpHeaders
    }
}

class MockAPISession: APISessionType {
    
    var sendWasCalled = false
    
    var fileName: String?
    
    var error: ResponseError?
    
    var session: APIURLSessionType
    
    init(session: APIURLSessionType) {
        
        self.session = session
    }
    
    
    func send(request: URLRequest, callback: @escaping (Result<Data, Error>) -> Void) {
        
        sendWasCalled = true
        
        guard let name = fileName,
            let path = Bundle(for: type(of: self)).path(forResource: name, ofType: "json") else {
            
                // file path is nil but we are sending mock network error
            callback(.failure(error ?? ResponseError.unexpectedResponse("Simulating network error.")))
            
            return
        }
        
        do {
            
            let data = try Data(contentsOf: URL(fileURLWithPath: path))
            
            callback(.success(data))
            
        } catch  {
            
            callback(.failure(ResponseError.unexpectedResponse("Cannot convert filepath to data")))
        }
        
    }
}
