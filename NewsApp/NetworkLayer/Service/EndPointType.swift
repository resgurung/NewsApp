//
//  EndPointType.swift
//  NewsApp
//
//  Created by Resham gurung on 06/01/2020.
//  Copyright © 2020 HAUDAE.com. All rights reserved.
//

import Foundation

protocol EndPointType {
    
    var baseURL: URL { get }
    
    var urlPath: Path { get }
    
    var httpMethod: HTTPMethod { get }
    
    var task: HTTPTask { get }
    
    var httpHeaders: [ HTTPHeader ] { get }
}

struct EndPoint: EndPointType {
    
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

