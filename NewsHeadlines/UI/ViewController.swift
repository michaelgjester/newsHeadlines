//
//  ViewController.swift
//  NewsHeadlines
//
//  Created by Michael Jester on 3/10/19.
//  Copyright © 2019 Michael Jester. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var articlesTableView: UITableView!
    
    private var articleArray: [Article] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        articlesTableView.dataSource = self
        articlesTableView.delegate = self
        
        performNetworkCall()
    }

    private func performNetworkCall() {
        
        let loadArticlesCompletionHandler:([Article]) -> Void = { (articleArray:[Article]) -> Void in
            
            self.articleArray = articleArray
            self.articlesTableView.reloadData()
        }
        
        NetworkingManager.loadArticlesWithCompletion(completionHandler: loadArticlesCompletionHandler)
    }
    
}

//MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articleArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reuseIdentifier = "ArticleTableViewCell"
        
        let cell = articlesTableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! ArticleTableViewCell

        cell.dateLabel.text = formatDateString(articleArray[indexPath.row].publishedAt) ?? ""
        cell.titleLabel.text = articleArray[indexPath.row].title ?? ""
        if let imageThumbnailUrl = articleArray[indexPath.row].urlToImage {
            cell.thumbnailImageView?.downloadImageFromNetworkAtURL(url: imageThumbnailUrl)
        }
        
        return cell
    }
    
    private func formatDateString(_ inputDateString: String?) -> String? {
        
        var outputString: String? = nil
        
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        let dateFormatterDisplay = DateFormatter()
        dateFormatterDisplay.dateFormat = "MMM dd, yyyy"
        
        if let date = dateFormatterGet.date(from: inputDateString ?? "") {
            outputString = dateFormatterDisplay.string(from: date)
        }
        
        return outputString
    }
}

// MARK: - UITableViewDelegate
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //TODO - load a detail VC when tapping on a row
        //for now just animate the selection action
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
