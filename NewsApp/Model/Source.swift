//
//  Source.swift
//  NewsApp
//
//  Created by Resham gurung on 06/01/2020.
//  Copyright © 2020 HAUDAE.com. All rights reserved.
//

import Foundation


struct Source {
    
    var id:     String?
    
    var name:   String?
    
    
}

extension Source: Decodable {
    
    enum CodingKeys: String, CodingKey {
        
        case id  = "id"
        
        case name  = "name"
    }
    
    init(from decoder: Decoder) throws {
        
        let values  = try decoder.container(keyedBy: CodingKeys.self)
        
        id          = try values.decodeIfPresent(String.self, forKey: .id)
        
        name        = try values.decodeIfPresent(String.self, forKey: .name)
        
    }
}
