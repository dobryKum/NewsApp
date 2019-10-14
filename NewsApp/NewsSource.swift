//
//  NewsSource.swift
//  NewsApp
//
//  Created by Tsimafei Zykau on 10/6/19.
//  Copyright © 2019 Timofey Zykov. All rights reserved.
//

import Foundation

struct NewsSource: Codable {
    var status: String?
    var totalResults: Int?
    var articles: [Article]
    
    private enum CodingKeys: String, CodingKey {
        case status
        case totalResults
        case articles
    }
    
    struct Article: Codable {
        var source: Source
        var author: String?
        var title: String?
        var description: String?
        var url: String?
        var urlToImage: String?
        var publishedAt: String?
        
        struct Source: Codable {
            var id: String?
            var name: String?
        }
    }
}

