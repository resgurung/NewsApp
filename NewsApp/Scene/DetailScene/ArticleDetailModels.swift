//
//  ArticleDetailModels.swift
//  NewsApp
//
//  Created by Resham gurung on 13/01/2020.
//  Copyright © 2020 HAUDAE.com. All rights reserved.
//

import Foundation


enum ArticleDetailModels {
    
    struct Request {}
    
    struct Response {
        
        var article: Article
    }
    
    
    struct ViewModel {
        
        struct DisplayedModel {
            
            struct DisplayedSource {
                
                var id:     String
                
                var name:   String
            }
            
            var source:         DisplayedSource
            
            var author:         String
            
            var title:          String
            
            var description:    String
            
            var url:            String
            
            var urlToImage:     String
            
            var publishedAt:    String
            
            var content:        String
        }
        
        var displayedArticle: DisplayedModel
        
    }
}
