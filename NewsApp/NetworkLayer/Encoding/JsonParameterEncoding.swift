//
//  JsonParameterEncoding.swift
//  NewsApp
//
//  Created by Resham gurung on 06/01/2020.
//  Copyright © 2020 HAUDAE.com. All rights reserved.
//

import Foundation


struct JsonParameterEncoder: ParameterEncoder {
    
    func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws {
        
        guard JSONSerialization.isValidJSONObject(parameters) else {
            
            throw EncodingError.notSerializable
        }
        
        urlRequest.httpBody = try serialize(parameters)
        
    }
    
    func serialize(_ parameters: Parameters) throws  -> Data {
        
        do {
            
            return try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            
        }catch {
            
            throw EncodingError.encodingFail
        }
    }
}
