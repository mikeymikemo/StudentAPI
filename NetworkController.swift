//
//  NetworkController.swift
//  StudentAPI
//
//  Created by Michael Montoya on 10/19/16.
//  Copyright © 2016 Michael Montoya. All rights reserved.
//

import Foundation


class NetworkController {
    
    //==================================================
    // MARK: Properties
    //==================================================
    
    enum HTTPMethod: String {
        
        case Get = "GET"
        case Put = "PUT"
        case Post = "POST"
        case Patch = "PATCH"
        case Delete = "DELETE"
        
    }
    
    static func performRequest(for url: URL, httpMethod: HTTPMethod, urlParameters: [String : String]? = nil, body: Data? = nil, completion: ((Data?, Error?) -> Void)? = nil) {
        
        // Build our entire URL
        
        let requestURL = self.url(byAdding: urlParameters, to: url)
        var request = URLRequest(url: requestURL)
        request.httpMethod = httpMethod.rawValue
        request.httpBody = body
        
        // Create and "resume" (a.k.a. run) the task
        
        let dataTask = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            
            completion?(data, error)
            
        })
        
        dataTask.resume()
        
    }
    
    static func url(byAdding parameters: [String : String]?, to url: URL) -> URL {
        
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        components?.queryItems = parameters?.flatMap({URLQueryItem(name: $0.0, value: $0.1)})
        
        
        guard let url = components?.url else {
            fatalError("URL optional is nil")
        }
        
        return url
        
    }
}
