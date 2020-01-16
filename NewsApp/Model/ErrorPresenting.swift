//
//  ErrorPresenter.swift
//  NewsApp
//
//  Created by Resham gurung on 12/01/2020.
//  Copyright © 2020 HAUDAE.com. All rights reserved.
//

import UIKit
import Foundation



protocol ErrorPresenting {
    
    func presentError(viewModel: ErrorViewModel)
}

extension ErrorPresenting where Self: UIViewController {
    
    func presentError(viewModel: ErrorViewModel) {

        let alertController = UIAlertController(title: viewModel.title, message: viewModel.description, preferredStyle: .alert)

        if let buttonTitles = viewModel.buttonTitles {

            for title in buttonTitles {

                let action = UIAlertAction(title: title, style: UIAlertAction.Style.default, handler: nil)
                alertController.addAction(action)
            }
        }

        present(alertController, animated: true, completion: nil)
    }
}
