//
//  ArticleDetailInteractor.swift
//  NewsApp
//
//  Created by Resham gurung on 13/01/2020.
//  Copyright © 2020 HAUDAE.com. All rights reserved.
//

import Foundation


protocol ArticleDetailInteractorBussinessLogic {

    func getArticle(request: ArticleDetailModels.Request)
}

protocol ArticleDetailDataStore {
    
    // ! because it will be set by Article scene
    var data: Article! { get set }
}
class ArticleDetailInteractor: ArticleDetailDataStore {
    
    var data: Article!
    
    var presenter: ArticleDetailPresentationLogic
    
    init(presenter: ArticleDetailPresentationLogic) {
        
        self.presenter = presenter
    }
}

extension ArticleDetailInteractor: ArticleDetailInteractorBussinessLogic {
    
    func getArticle(request: ArticleDetailModels.Request) {
        
        guard let article = data else {
            // data not set
            presenter.presentError(errorResponse: ResponseError.unexpectedResponse("Data not set."))
            return
        }
        
        let response = ArticleDetailModels.Response(article: article)
        
        presenter.presentArticle(response: response)
    }
}
