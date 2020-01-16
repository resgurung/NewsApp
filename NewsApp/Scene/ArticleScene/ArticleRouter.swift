//
//  ArticleRouter.swift
//  NewsApp
//
//  Created by Resham gurung on 04/01/2020.
//  Copyright © 2020 HAUDAE.com. All rights reserved.
//

import UIKit


protocol ArticleRoutingProtocol {
    
    var viewController: ArticleTableViewController? { get }
    
    func routeToDetail(indexPath: IndexPath, animated: Bool)
}

protocol ArticleDataPassing {
    
    var dataStore: ArticleDataStore? { get }
}

final class ArticleRouter: NSObject, ArticleRoutingProtocol, ArticleDataPassing { 
    
    weak var viewController: ArticleTableViewController?
    
    var dataStore: ArticleDataStore?
    
    init(viewController: ArticleTableViewController) {
        
        self.viewController = viewController
    }
    
    //MARK: Communications
    func routeToDetail(indexPath: IndexPath, animated: Bool = false) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let destinationVC = storyboard.instantiateViewController(identifier: "ArticleDetailViewController", creator: { coder in
            return ArticleDetailViewController(coder: coder)
        })
        
        guard let homeDS = dataStore, var destinationDS = destinationVC.router?.dataStore else {
            fatalError("Nil value")
        }
        
        if indexPath.row < homeDS.responseData?.articles.count ?? 0 {
            
            destinationDS.data = homeDS.responseData?.articles[indexPath.row]
            
            viewController?.navigationController?.pushViewController(destinationVC, animated: animated)
        }
        

    }
}
