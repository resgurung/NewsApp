//
//  ArticleDetailRouter.swift
//  NewsApp
//
//  Created by Resham gurung on 13/01/2020.
//  Copyright © 2020 HAUDAE.com. All rights reserved.
//

import Foundation


protocol ArticleDetailRouting {
    
    var viewController: ArticleDetailViewController? { get }
    //func routeToAnywhere()
}

protocol ArticleDetailDataPassing {
    
    var dataStore: ArticleDetailDataStore? { get }
}


class ArticleDetailRouter: NSObject, ArticleDetailRouting, ArticleDetailDataPassing {
    
    var dataStore: ArticleDetailDataStore?
    
    weak var viewController: ArticleDetailViewController?
    
    init(viewController: ArticleDetailViewController) {
        
        self.viewController = viewController
    }
}
