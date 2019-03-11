//
//  ImageCache.swift
//  NewsHeadlines
//
//  Created by Michael Jester on 3/10/19.
//  Copyright © 2019 Michael Jester. All rights reserved.
//

import UIKit

class ImageCache: NSCache<NSString, UIImage> {
    
    static let sharedInstance = ImageCache()
    
    private override init(){
        super.init()
    }
    
}
