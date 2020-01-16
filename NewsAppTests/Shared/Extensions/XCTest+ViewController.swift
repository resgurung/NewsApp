//
//  XCTest+ViewController.swift
//  NewsAppTests
//
//  Created by Resham gurung on 15/01/2020.
//  Copyright © 2020 HAUDAE.com. All rights reserved.
//

import Foundation
import UIKit
import XCTest


extension XCTestCase {
    
    // MARK: - Load view

    func loadView(window: UIWindow, viewController: UIViewController) {

        window.addSubview(viewController.view)
        RunLoop.current.run(until: Date())
    }
}
