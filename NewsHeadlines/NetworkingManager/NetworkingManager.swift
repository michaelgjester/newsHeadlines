//
//  NetworkingManager.swift
//  NewsHeadlines
//
//  Created by Michael Jester on 3/10/19.
//  Copyright © 2019 Michael Jester. All rights reserved.
//

import Foundation



class NetworkingManager: NSObject {
    
    static func loadEventsWithCompletion(completionHandler:@escaping ([NSObject]) -> Void) -> Void {
        
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
            guard data != nil else {
                print("Error: data is nil")
                return
            }
            
            //check 3: response parameter is non-nil
            if response != nil {
                do {
                    
                    //JSON response
                    if let jsonDictionary = try JSONSerialization.jsonObject(with: data!, options: [])as? [String: AnyObject]{
                        
                        print("jsonDictionary = \(jsonDictionary)")
                    }
                    
                } catch let error as NSError {
                    print(error)
                }
            }
        }
        
        task.resume()

    }
}
