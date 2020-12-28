//
//  CachedRequest.swift
//  ThisIsBud
//
//  Created by Olivier Conan on 27/12/2020.
//  Copyright © 2020 OlivierConan. All rights reserved.
//

import Foundation

class CachedRequest {

    static let cache = URLCache(memoryCapacity: 40 * 1024 * 1024, diskCapacity: 512 * 1024 * 1024, diskPath: "urlCache")

    static func request(endpoint: Endpoint, completion: @escaping (Foundation.Data?, URLResponse?, Error?, Bool)->() ) -> URLSessionTask? {
        guard let url = URL(string: endpoint.urlString) else { return nil }
        let request = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 100)

        if let cacheResponse = cache.cachedResponse(for: request) {
            completion(cacheResponse.data, cacheResponse.response, nil, true)
            return nil
        } else {
            let config = URLSessionConfiguration.default

            config.urlCache = cache

            let session = URLSession(configuration: config)
            let task = session.dataTask(with: request) { data, response, error in
                if let response = response, let data = data {
                    let cacheResponse = CachedURLResponse(response: response, data: data)
                    URLCache.shared.storeCachedResponse(cacheResponse, for: request)
                }
                completion(data, response, error, false)
            }
            task.resume()
            return task
        }
    }
}
