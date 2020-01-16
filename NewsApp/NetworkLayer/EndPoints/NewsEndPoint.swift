//
//  NewsEndPoint.swift
//  NewsApp
//
//  Created by Resham gurung on 06/01/2020.
//  Copyright © 2020 HAUDAE.com. All rights reserved.
//

import Foundation


struct NewsEndPoint: EndPointType {
    
    var baseURL: URL {
        
        return URLFactory().make(schema: AppConstant.API.SCHEMA, enviromentURL: AppConfig.networkEnviroment.enviroment)
    }

    var urlPath: Path {
        
        return .headlineArticle
    }

    var httpMethod: HTTPMethod {
        
        return .get
    }

    var task: HTTPTask {
        
        return .requestWithURLParameters(encoding: .urlEncoding, urlParameters: [
            "apiKey"    : AppConstant.Key.NEWS_API_KEY,
            "country"   : "gb"
        ])
    }

    var httpHeaders: [ HTTPHeader ] {
        
        return [
            .accept,
            .contentType
        ]
    }


}
