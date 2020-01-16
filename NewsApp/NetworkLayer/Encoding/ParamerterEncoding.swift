//
//  ParamerterEncoding.swift
//  NewsApp
//
//  Created by Resham gurung on 06/01/2020.
//  Copyright © 2020 HAUDAE.com. All rights reserved.
//

import Foundation


typealias Parameters = [String: Any]

protocol ParameterEncoder {
    
    func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws
}

enum ParameterEncoding {
    
    case urlEncoding
    
    case jsonEncoding
    
    case urlAndJsonEncoding
    
    func encode(urlRequest: inout URLRequest, bodyParameters: Parameters?, urlParameters: Parameters?) throws {
        
        do {
            switch self {
                
                case .urlEncoding:
                    
                    guard let urlParameters = urlParameters else { return }
                    
                    try URLParameterEncoder().encode(urlRequest: &urlRequest, with: urlParameters)
                
                case .jsonEncoding:
                    
                    guard let bodyParameters = bodyParameters else { return }
                    
                    try JsonParameterEncoder().encode(urlRequest: &urlRequest, with: bodyParameters)
                
                case .urlAndJsonEncoding:
                    
                    guard let bodyParameters = bodyParameters,
                    let urlParameters = urlParameters else { return }
                    
                    try URLParameterEncoder().encode(urlRequest: &urlRequest, with: urlParameters)
                    
                    try JsonParameterEncoder().encode(urlRequest: &urlRequest, with: bodyParameters)
            }
            
        } catch  {
            
            throw error
        }
    }
}
