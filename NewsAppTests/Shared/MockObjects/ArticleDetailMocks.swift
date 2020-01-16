//
//  ArticleDetailMocks.swift
//  NewsAppTests
//
//  Created by Resham gurung on 15/01/2020.
//  Copyright © 2020 HAUDAE.com. All rights reserved.
//

@testable import NewsApp


// MARK: - ArticleViewDisplayLogicMock
class ArticleDetailViewDisplayLogicMock: ArticleDetailViewControllerDisplayLogic {
    
    var displayFetchArticleDetailWasCalled = false
    
    var displayErrorWasCalled = false
    
    var articleViewModel: ArticleDetailModels.ViewModel?
    
    var responseError: ErrorViewModel?
    
    func displayArticle(viewModel: ArticleDetailModels.ViewModel) {
        
        displayFetchArticleDetailWasCalled = true
        
        articleViewModel = viewModel
    }
    
    func displayError(errorViewModel: ErrorViewModel) {
        
        displayErrorWasCalled = true
        
        responseError = errorViewModel
    }
}


// MARK: - ArticleDetailPresenterLogicMock
class ArticleDetailPresenterLogicMock: ArticleDetailPresentationLogic {
    
    var presentArticleWasCalled = false
    
    var presentErrorWasCalled = false
    
    var responseArticle: ArticleDetailModels.Response?
    
    var error: Error?
    
    func presentArticle(response: ArticleDetailModels.Response) {
        
        presentArticleWasCalled = true
        
        responseArticle = response
    }
    
    func presentError(errorResponse: Error) {
        
        presentErrorWasCalled = true
        
        error = errorResponse
    }
}

// MARK: - ArticleDetailPresenterLogicMock
class ArticleDetailVCBussinessLogic: ArticleDetailInteractorBussinessLogic, ArticleDetailDataStore {
    
    var data: Article!
    
    var getArticlesWasCalled = false
    
    func getArticle(request: ArticleDetailModels.Request) {
        
        getArticlesWasCalled = true
    }
}
