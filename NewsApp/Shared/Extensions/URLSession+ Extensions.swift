//
//  URLSession+ Extensions.swift
//  NewsApp
//
//  Created by Resham gurung on 07/01/2020.
//  Copyright © 2020 HAUDAE.com. All rights reserved.
//

import Foundation


extension URLSessionDataTask: APISessionDataTaskType {}


extension URLSession: APIURLSessionType {
    
    func dataTask(with request: URLRequest, completion: @escaping APIURLSessionType.APISessionCompletion) -> APISessionDataTaskType {
        
        return dataTask(with: request, completionHandler: completion) as URLSessionDataTask
    }
    
}
