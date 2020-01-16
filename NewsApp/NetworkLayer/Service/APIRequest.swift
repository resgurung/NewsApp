//
//  RequestBuilder.swift
//  NewsApp
//
//  Created by Resham gurung on 06/01/2020.
//  Copyright © 2020 HAUDAE.com. All rights reserved.
//

import Foundation


protocol APIRequestType {
    
    func build(endPoint: EndPointType) throws -> URLRequest
}


class APIRequest: APIRequestType {
    
    func build(endPoint: EndPointType) throws -> URLRequest{
        
        var urlRequest = URLRequest(url: endPoint.baseURL.appendingPathComponent(endPoint.urlPath.path), cachePolicy: .useProtocolCachePolicy, timeoutInterval: 60.0)
        
        urlRequest.httpMethod = endPoint.httpMethod.rawValue
        
        endPoint.httpHeaders.forEach {
            
            urlRequest.addValue($0.header.1 , forHTTPHeaderField: $0.header.0)
        }
        
        
        switch endPoint.task {
            
        case .requestWithURLParameters(let encoding, let urlParameters):
            
            try self.configureParameters(encoding, nil, urlParameters, &urlRequest)
            
        case .requestWithBodyParameters(let encoding, let bodyParameters):
            
            try self.configureParameters(encoding, bodyParameters, nil, &urlRequest)
        
        case .requestWithURLAndBodyParameters(let encoding, let urlParameters, let bodyParameters):
            
            try self.configureParameters(encoding, bodyParameters, urlParameters, &urlRequest)

        }
        
        return urlRequest
    }
    
    
    fileprivate func configureParameters(_ encoding: ParameterEncoding,_ bodyParameters: Parameters?,_ urlParameters: Parameters?,_ request: inout URLRequest) throws {
        
        do {
            
            try encoding.encode(urlRequest: &request, bodyParameters: bodyParameters, urlParameters: urlParameters)
            
        } catch {
            
            throw error
        }
    }
}
