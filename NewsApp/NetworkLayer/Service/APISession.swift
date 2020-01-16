//
//  APISession.swift
//  NewsApp
//
//  Created by Resham gurung on 06/01/2020.
//  Copyright © 2020 HAUDAE.com. All rights reserved.
//

import Foundation


// info: http://masilotti.com/testing-nsurlsession-input/

protocol APISessionDataTaskType {
    
    func resume()
}


protocol APIURLSessionType {

    typealias APISessionCompletion = (_ data: Data?,_ response: URLResponse?,_ error: Error?) -> ()

    func dataTask(with request: URLRequest, completion: @escaping APISessionCompletion) -> APISessionDataTaskType

}

protocol APISessionType {
    
    var session: APIURLSessionType { get }
    
    func send( request: URLRequest, callback: @escaping (Result<Data, Error>) -> Void )
}

class APISession: APISessionType {
    
    typealias completeClosure = ( _ data: Data?, _ error: Error?)->Void

    var session: APIURLSessionType

    init(session: APIURLSessionType = URLSession(configuration: .default)) {

        self.session = session
    }

    
    func send( request: URLRequest, callback: @escaping (Result<Data, Error>) -> Void ) {

        let task = session.dataTask(with: request) { (data, response, error) in
            
            // If the dataTask error is occured.
            if let error = error {
                
                callback(.failure(ResponseError.unexpectedResponse(error.localizedDescription)))
                
                return
            }
            
            // Decodable must have data length at least.
            guard let data = data else {
                
                callback(.failure(ResponseError.unexpectedResponse("The response is empty.")))
                
                return
            }
            
            // rawResponse must be HTTPURLResponse
            guard let httpResponse = response as? HTTPURLResponse else {
                
                callback(.failure(ResponseError.unexpectedResponse("The response is not a HTTPURLResponse")))
                
                return
            }
            
            if (200..<300).contains(httpResponse.statusCode)  {
                
                callback(.success(data))
                
            } else {
                
                callback(.failure(ResponseError.unacceptableStatusCode(httpResponse.statusCode)))
            }
            
            
        }

        task.resume()
    }
}
