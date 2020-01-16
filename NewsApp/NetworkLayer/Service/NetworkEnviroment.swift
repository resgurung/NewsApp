//
//  Enviroment.swift
//  NewsApp
//
//  Created by Resham gurung on 06/01/2020.
//  Copyright © 2020 HAUDAE.com. All rights reserved.
//

import Foundation

enum NetworkEnviroment {
    
    case qa
    
    case staging
    
    case production
    
    var enviroment: String {
        
        switch self {
            
        case .qa: return AppConstant.API.QA
            
        case .staging: return AppConstant.API.STAGING
            
        case .production: return AppConstant.API.PRODUCTION
        }
    }
}
