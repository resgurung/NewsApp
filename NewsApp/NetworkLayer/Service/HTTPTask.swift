//
//  HTTPTask.swift
//  NewsApp
//
//  Created by Resham gurung on 06/01/2020.
//  Copyright © 2020 HAUDAE.com. All rights reserved.
//

import Foundation



enum HTTPTask {
    
    case requestWithURLParameters(encoding: ParameterEncoding, urlParameters: Parameters?)
    
    case requestWithBodyParameters(encoding: ParameterEncoding, bodyParameters: Parameters?)
    
    case requestWithURLAndBodyParameters(encoding: ParameterEncoding, urlParameters: Parameters?, bodyParameters: Parameters?)
}


enum Path: String {
    
    case headlineArticle
    
    var path: String {
        
        switch self {
            
        case .headlineArticle:
            
            return AppConstant.API.TOP_HEADLINE_PATH
        }
    }
}

typealias HTTPHeaderKey     = String
typealias HTTPHeaderValue   = String

enum HTTPHeader {
    
    case accept
    
    case contentType
    
    case contentTypeURLFormEncoded
    
    case tokenAuthorization( HTTPHeaderValue )
    
    case bearerAuthorization( HTTPHeaderValue )
    
    case custom( HTTPHeaderKey, HTTPHeaderValue )
    
    var header: ( HTTPHeaderKey , HTTPHeaderValue ) {
        
        switch self {
            
        case .accept:
            
            return ( "Accept" , "application/json; charset=utf-8" )
            
        case .contentType:
            
            return ( "Content-Type" , "application/json; charset=utf-8" )
            
        case .contentTypeURLFormEncoded:
            
            return ( "Content-Type" , "application/x-www-form-urlencoded" )
            
        case .tokenAuthorization( let token):
            
            return ( "Authorization" , "Token \(token)" )
            
        case .bearerAuthorization( let bearer ):
            
            return ( "Authorization" , "Bearer \(bearer)" )
            
        case .custom( let key, let value ):
            
            return ( key , value )
        }
    }
    
}
