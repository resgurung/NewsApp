//
//  ArticleWorker.swift
//  NewsApp
//
//  Created by Resham gurung on 04/01/2020.
//  Copyright © 2020 HAUDAE.com. All rights reserved.
//

import Foundation


protocol WorkerType {
        
    func fetch<T: Decodable>(ofType: T.Type, completion: @escaping (T?, Error?) -> ())
}

class ArticleWorker: WorkerType {
    
    var endPoint: EndPointType
    
    var service: APIServiceType
    
    init(endPoint: EndPointType = NewsEndPoint(), service: APIServiceType = APIService()) {
        
        self.endPoint = endPoint
        
        self.service = service
        
    }
    
    func fetch<T: Decodable>(ofType: T.Type, completion: @escaping (T?, Error?) -> ()) {
        
        service.fetch(response: T.self, with: endPoint, completion: completion)
    }
}
