//
//  ArticleDetailPresenter.swift
//  NewsApp
//
//  Created by Resham gurung on 13/01/2020.
//  Copyright © 2020 HAUDAE.com. All rights reserved.
//

import Foundation


protocol ArticleDetailPresentationLogic {
    
    func presentArticle(response: ArticleDetailModels.Response)
    
    func presentError(errorResponse: Error)
}


class ArticleDetailPresenter {
    
    private(set) weak var viewController: ArticleDetailViewControllerDisplayLogic?
    
    init(viewController: ArticleDetailViewControllerDisplayLogic) {
        
        self.viewController = viewController
    }
}

extension ArticleDetailPresenter: ArticleDetailPresentationLogic {
    
    func presentArticle(response: ArticleDetailModels.Response) {
        
        let article = response.article
        
        let source = ArticleDetailModels.ViewModel.DisplayedModel.DisplayedSource(id: article.source.id ?? "", name: article.source.name ?? "")
        
        let displayedArticle = ArticleDetailModels.ViewModel.DisplayedModel(source: source, author: article.author ?? "", title: article.title ?? "", description: article.description ?? "", url: article.url ?? "", urlToImage: article.urlToImage ?? "", publishedAt: article.publishedAt ?? "", content: article.content ?? "")
        
        let viewModel = ArticleDetailModels.ViewModel(displayedArticle: displayedArticle)
        
        DispatchQueue.main.async {
            
            self.viewController?.displayArticle(viewModel: viewModel)
        }
    }
    
    func presentError(errorResponse: Error) {
        
        let errorViewModel = ErrorViewModel(title: AppStrings.Error.genericTitle, description: errorResponse.localizedDescription, buttonTitles: [AppStrings.Error.okButtonTitle])
        
        DispatchQueue.main.async {
            
            self.viewController?.displayError(errorViewModel: errorViewModel)
        }
        
    }
    
    
}
