//
//  ArticleModels.swift
//  NewsApp
//
//  Created by Resham gurung on 04/01/2020.
//  Copyright © 2020 HAUDAE.com. All rights reserved.
//

import Foundation


enum ArticleModels {
    
    // MARK: Use Cases
    struct Request {
        
    }
    
    
    struct Response: Decodable {
        
        var status:         String
        
        var totalResults:    Int
        
        var articles:        [Article]
    }
    
    
    struct ViewModel {
        
        struct DisplayArticle {
            
            var title:          String
            
            var description:    String
            
            var publishedAt:    String
            
            var urlToImage:     String
        }
        
        var articles: [DisplayArticle]
    }
}
