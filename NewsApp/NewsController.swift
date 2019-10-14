//
//  NewsController.swift
//  NewsApp
//
//  Created by Tsimafei Zykau on 10/2/19.
//  Copyright © 2019 Timofey Zykov. All rights reserved.
//

import UIKit

class NewsController {
    
    static let shared = NewsController()
    
    var baseUrl = URL(string: "https://newsapi.org/v2/top-headlines?")!
    
    enum SortOptions: String {
        case relevancy
        case popularity
        case publishedAt
    }
    
    func fetchArticles(matching query: [String: String], completion: @escaping (NewsSource?) -> Void){
        guard let url = baseUrl.withQueries(queries: query) else {
            completion(nil)
            print("Can't create url")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            let jsonDecoder = JSONDecoder()
            if let data = data,
                let newsSource = try? jsonDecoder.decode(NewsSource.self, from: data) {
                    completion(newsSource)
                } else {
                    print("An error has occuried")
                    completion(nil)
                }
        }
        task.resume()
    }
    
    func fetchImage(url: URL, completion: @escaping (UIImage?) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data,
                let image = UIImage(data: data) {
                completion(image)
            } else {
                print("An error has occuried")
                completion(nil)
            }
        }
        task.resume()
    }
    
}
