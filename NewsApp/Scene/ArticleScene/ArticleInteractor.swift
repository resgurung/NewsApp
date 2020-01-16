//
//  ArticleInteractor.swift
//  NewsApp
//
//  Created by Resham gurung on 04/01/2020.
//  Copyright © 2020 HAUDAE.com. All rights reserved.
//

import Foundation



protocol ArticleBussinessLogic {
    
    func getArticles(request: ArticleModels.Request)
}


protocol ArticleDataStore {
    
    var responseData: ArticleModels.Response? { get }
}


class ArticleInteractor: ArticleDataStore, ArticleBussinessLogic {
    
    var presenter: ArticlePresentationLogic
    
    var responseData: ArticleModels.Response?
    
    var worker: WorkerType
    
    init(presenter: ArticlePresentationLogic, worker: WorkerType = ArticleWorker()) {
        
        self.presenter = presenter
        
        self.worker = worker
    }
    
    
    func getArticles(request: ArticleModels.Request) {
        
        worker.fetch(ofType: ArticleModels.Response.self) { [ weak self ] (response, error) in
            
            guard let response = response else {
                
                self?.presenter.presentError(responseError: error ?? NetworkError.unknown)
                
                return
            }
            
            self?.responseData = response
            
            self?.presenter.presentFetchArticles(response: response)
        }
    }
}
