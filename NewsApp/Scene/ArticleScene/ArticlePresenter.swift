//
//  ArticlePresenter.swift
//  NewsApp
//
//  Created by Resham gurung on 04/01/2020.
//  Copyright © 2020 HAUDAE.com. All rights reserved.
//

// MVP ( clean swift )
//
//   ViewController(displays logic) >---(Request)---->  Interactor (Bussiness logic) >----(Response)---> Presenter (Presentation logic) >---(ViewModel)--> ViewController (displays logic)
//
//
//





import Foundation


protocol ArticlePresentationLogic {
    
    func presentFetchArticles(response: ArticleModels.Response)
    
    func presentError(responseError: Error)
}


class ArticlePresenter: ArticlePresentationLogic  {

    /// presenter holds weak reference to view
    private(set) weak var viewController: ArticleTableViewControllerDisplayLogic?
    
    // date formatter
    let dateFormatter: DateFormatter = {
      let dateFormatter = DateFormatter()
      dateFormatter.dateStyle = .short
      dateFormatter.timeStyle = .none
      return dateFormatter
    }()
    
    init(viewController: ArticleTableViewControllerDisplayLogic) {
        
        self.viewController = viewController
    }
    
    
    func presentFetchArticles(response: ArticleModels.Response) {
        
        var displayedArticles: [ArticleModels.ViewModel.DisplayArticle] = []
        
        // stringify response data into what the view understands
        for article in response.articles {
            
            // convert any data that need to be converted into string for display
            let displayedArticle = ArticleModels.ViewModel.DisplayArticle(title: article.title ?? "", description: article.description ?? "", publishedAt: article.publishedAt ?? "", urlToImage: article.urlToImage ?? "")
            
            displayedArticles.append(displayedArticle)
        }
        
        let viewModel = ArticleModels.ViewModel(articles: displayedArticles)
        
        DispatchQueue.main.async {
            
            self.viewController?.displayFetchedArticles(viewModel: viewModel)
        }
        
    }
    
    
    func presentError(responseError: Error) {
        
        let errorViewModel = ErrorViewModel(title: AppStrings.Error.genericTitle, description: responseError.localizedDescription, buttonTitles: [AppStrings.Error.okButtonTitle])
        
        DispatchQueue.main.async {
            
            self.viewController?.displayError(viewModel: errorViewModel)
        }
        
    }
}
    
    

