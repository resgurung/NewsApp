//
//  URL+Extensions.swift
//  NewsApp
//
//  Created by Resham gurung on 06/01/2020.
//  Copyright © 2020 HAUDAE.com. All rights reserved.
//

import Foundation


protocol URLFactoryType {
    
    func make(schema: String, enviromentURL: String) -> URL
}


class URLFactory: URLFactoryType {
    
//    func make(schema: String, enviromentURL: String) -> URL {
//
//        guard let url = URL(string: "\(schema)/\(enviromentURL)") else {
//
//            fatalError("BaseURL could not be configured from: \(schema)/\(enviromentURL).")
//        }
//
//        return url
//    }
    
    func make(schema: String, enviromentURL: String) -> URL {
        
        var component = URLComponents()
        
        component.scheme = schema
        
        component.host = enviromentURL
        
        guard let url = component.url else {
            
            fatalError("BaseURL could not be configured from: \(schema)/\(enviromentURL).")
        }
        return url
    }
}
