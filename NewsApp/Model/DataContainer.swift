//
//  DataContainer.swift
//  NewsApp
//
//  Created by Resham gurung on 06/01/2020.
//  Copyright © 2020 HAUDAE.com. All rights reserved.
//

import Foundation


struct DataContainer<T: Decodable>: Decodable {
    
    var status:         String
    
    var totalResults:    Int
    
    var articles:        T
}
