//
//  URL+Helpers.swift
//  NewsApp
//
//  Created by Tsimafei Zykau on 10/13/19.
//  Copyright © 2019 Timofey Zykov. All rights reserved.
//

import Foundation

extension URL {
    func withQueries(queries: [String: String]) -> URL? {
        var components = URLComponents(url: self, resolvingAgainstBaseURL: true)
        components?.queryItems = queries.map { URLQueryItem(name: $0.0, value: $0.1) }
        return components?.url
    }
}
