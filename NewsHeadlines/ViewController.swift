//
//  ViewController.swift
//  NewsHeadlines
//
//  Created by Michael Jester on 3/10/19.
//  Copyright © 2019 Michael Jester. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        performNetworkCall()
    }

    private func performNetworkCall() {
        
        let loadArticlesCompletionHandler:([Article]) -> Void = { (articleArray:[Article]) -> Void in
            
            for article in articleArray {
                print("***************************************")
                if let title = article.title {
                    print("title = \(title)")
                }
            }
            
        }
        
        NetworkingManager.loadArticlesWithCompletion(completionHandler: loadArticlesCompletionHandler)
    }
}

