//
//  NetworkingManager.swift
//  NewsHeadlines
//
//  Created by Michael Jester on 3/10/19.
//  Copyright © 2019 Michael Jester. All rights reserved.
//

import Foundation

struct NormalResponse: Decodable {
    let status: String
    let totalResults: Int
    let articles: [Article]
    
    enum CodingKeys: String, CodingKey {
        case status
        case totalResults
        case articles
    }
}

struct Source: Decodable {
    let id: String?
    let name: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
    }
}

struct Article: Decodable {
    let source: Source
    let author: String?
    let title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?
    
    enum CodingKeys: String, CodingKey {
        case source
        case author
        case title
        case description
        case url
        case urlToImage
        case publishedAt
        case content
    }
}

class NetworkingManager: NSObject {
    
    static func loadEventsWithCompletion(completionHandler:@escaping ([Article]) -> Void) -> Void {
        
        let baseAddress = "https://newsapi.org/v2/"
        let endpoint = "top-headlines"
        let country = "us"
        let apiKey = "575160f93e3b4f63a50a37ed5aff69a6"
        
        //example format for fully formed request string:
        //"https://newsapi.org/v2/top-headlines?country=us&apiKey=<apikey>"
        let requestString:String = baseAddress + endpoint + "?country=" + country + "&apiKey=" + apiKey
        
        print("RequestString = \(requestString)")
        
        guard let url = URL(string: requestString) else {
            print("Error: cannot create URL")
            return
        }
        
        // set up the session
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config,
                                 delegate: nil,
                                 delegateQueue: OperationQueue.main)
        
        // make the request with the session
        let urlRequest = URLRequest(url: url)
        let task = session.dataTask(with: urlRequest) { (data, response, error) in
            
            //check 1: no errors
            guard error == nil else {
                print("error calling the request:\(error!)")
                return
            }
            
            //check 2: data is non-nil
            guard let data = data else {
                print("Error: data is nil")
                return
            }
            
            //check 3: response parameter is non-nil
            if response != nil {
                do {
                    
                    let normalResponse = try JSONDecoder().decode(NormalResponse.self, from: data)
                    
                    print("status = \(normalResponse.status)")
                    print("count = \(normalResponse.totalResults)")
                    for article in normalResponse.articles {
                        print("*******")
                        if let title = article.title {
                            print("title = \(title)")
                        }
                    }
                    
                } catch let error as NSError {
                    
                    print("Error: \(error)")
                }
            }
        }
        
        task.resume()

    }
}
