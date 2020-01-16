//
//  NewsAPIService.swift
//  NewsApp
//
//  Created by Resham gurung on 07/01/2020.
//  Copyright © 2020 HAUDAE.com. All rights reserved.
//

import Foundation


protocol APIServiceType {
    
    func fetch<T: Decodable>(response type: T.Type,with route: EndPointType, completion: @escaping (_ data: T?,_ error: Error?) -> () )
}


class APIService: APIServiceType {
    
    private var apiRequestType: APIRequestType
    
    private var apiSession:     APISessionType
    
    init(apiRequestType: APIRequestType = APIRequest(), apiSession: APISessionType = APISession() /*MockAPISession(session: URLSession.shared)*/) {
        
        self.apiRequestType = apiRequestType
        
        self.apiSession     = apiSession
    }
    
    // fetch article
    func fetch<T: Decodable>(response type: T.Type,with route: EndPointType, completion: @escaping (T?, Error?) -> ()) {
        
        do {
            
            let request    = try apiRequestType.build(endPoint: route)
            
            apiSession.send(request: request) { [ weak self ] result in
                
                switch result {
                    
                    case .failure(let error):
                        
                        completion(nil, error)
                    
                    case .success(let data):
                        
                        /// Decode the `Date` as an ISO-8601-formatted string (in RFC 3339 format).
                        self?.decode(type, data, .iso8601) { (decodedData, error) in

                            completion(decodedData, error)

                        }

                }
            }
            
        } catch  {
            
            completion(nil, error)
        }
        
    }
    
    func decode<T: Decodable>(_ type: T.Type, _ data: Data, _ strategy: JSONDecoder.DateDecodingStrategy, completion: @escaping ( T?, Error?) -> () ) {
    
        do {
            
            let decoder = JSONDecoder()
            
            decoder.dateDecodingStrategy = strategy //.iso8601
            
            let response = try decoder.decode(T.self, from: data)
            
            completion(response, nil)
            
        } catch DecodingError.keyNotFound(let codingKey, let context){
            
            completion(nil, DecodingError.keyNotFound(codingKey, context))
            
        } catch DecodingError.typeMismatch(let type, let context){
            
            completion(nil, DecodingError.typeMismatch(type, context))
            
        } catch DecodingError.valueNotFound(let type, let context) {
            
            completion(nil, DecodingError.valueNotFound(type, context))
            
        } catch DecodingError.dataCorrupted(let context) {
            
            completion(nil, DecodingError.dataCorrupted(context))
            
        } catch {
            
            completion(nil, ResponseError.unexpectedResponse("Cannot decode data from server: \(error.localizedDescription)."))
        }
        
    }
    
}
