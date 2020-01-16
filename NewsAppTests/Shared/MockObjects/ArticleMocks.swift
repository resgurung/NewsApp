//
//  ArticleMocks.swift
//  NewsAppTests
//
//  Created by Resham gurung on 14/01/2020.
//  Copyright © 2020 HAUDAE.com. All rights reserved.
//

import XCTest
@testable import NewsApp


// MARK: - ArticleViewDisplayLogicMock
class ArticleViewDisplayLogicMock: ArticleTableViewControllerDisplayLogic {
    
    var displayFetchArticleWasCalled = false
    
    var displayErrorWasCalled = false
    
    var articleViewModel: ArticleModels.ViewModel?
    
    var responseError: ErrorViewModel?
    
    func displayFetchedArticles(viewModel: ArticleModels.ViewModel) {
        
        displayFetchArticleWasCalled = true
        
        articleViewModel = viewModel
    }
    
    func displayError(viewModel: ErrorViewModel) {
        
        displayErrorWasCalled = true
        
        responseError = viewModel
    }
}

// MARK: - ArticlePresenterLogicMock
class ArticlePresenterLogicMock: ArticlePresentationLogic {
    
    var presentFetchArticlesWasCalled = false
    
    var presentErrorWasCalled = false
    
    func presentFetchArticles(response: ArticleModels.Response) {
        
        presentFetchArticlesWasCalled = true
    }
    
    func presentError(responseError: Error) {
        
        presentErrorWasCalled = true
    }
}

// MARK: - ArticleWorkerMock
class ArticleWorkerMock: ArticleWorker {
    
    var fetchWasCalled = false
    
    var error: Error?
    
    var response: ArticleModels.Response?
    
    override func fetch<T>(ofType: T.Type, completion: @escaping (T?, Error?) -> ()) where T : Decodable {
        
        fetchWasCalled = true
        
        completion(response as? T, error)
    }
}

// MARK: - APIServiceMock
class APIServiceMock: APIServiceType {
    
    var fetchWasCalled = false
    
    func fetch<T>(response type: T.Type, with route: EndPointType, completion: @escaping (T?, Error?) -> ()) where T : Decodable {
        
        fetchWasCalled = true
        
        completion(nil,nil)
    }
}

class ArticleTVCBussinessLogic: ArticleBussinessLogic, ArticleDataStore {
    
    var responseData: ArticleModels.Response?
    
    var getArticlesWasCalled = false
    
    func getArticles(request: ArticleModels.Request) {
        
        getArticlesWasCalled = true
    }
}

// MARK: - ArticleRouterMock
class ArticleRouterMock: NSObject, ArticleRoutingProtocol, ArticleDataPassing {
    
    var dataStore: ArticleDataStore?
    
    weak var viewController: ArticleTableViewController?
    
    var routeToDetailWasCalled = false
    
    func routeToDetail(indexPath: IndexPath, animated: Bool) {
        
        routeToDetailWasCalled = true
    }
}

// MARK: - NavigationControllerMock
final class NavigationControllerMock: UINavigationController {
    
    var pushedViewController: UIViewController?
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        super.pushViewController(viewController, animated: animated)
        
        pushedViewController = viewController
    }
}
