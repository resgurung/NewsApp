//
//  NetworkError.swift
//  NewsApp
//
//  Created by Resham gurung on 04/01/2020.
//  Copyright © 2020 HAUDAE.com. All rights reserved.
//

import Foundation


// Error uses Equatable to use that in tesing

enum NetworkError: String, Error, Equatable {
    
    case parametersNil  = "Parameters are nil"
    
    case unknown        = "Unknown"
    
    case networkError   = "Network Error"
}


enum EncodingError: String, Error, Equatable {
    
    case missingURL         = "Missing URL"
    
    case encodingFail       = "Parameters encoding fails"
    
    case notSerializable    = "Parameters cannot be serialize."
}


enum ResponseError: Error, Equatable {
    
    case unacceptableStatusCode(Int)
    
    case unexpectedResponse(String)
    
    
    // used more in the unit testing
    static func == (lhs: ResponseError, rhs: ResponseError) -> Bool {
        
        switch (lhs, rhs){
            
            case (.unacceptableStatusCode(let l), .unacceptableStatusCode(let r)) :
                
                return l == r
            
            case (.unexpectedResponse(let l), .unexpectedResponse(let r)):
                
                return l == r
            
            default:
                
                return false
        }
    }

}
