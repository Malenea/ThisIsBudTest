//
//  APIHandler.swift
//  ThisIsBud
//
//  Created by Olivier Conan on 27/12/2020.
//  Copyright © 2020 OlivierConan. All rights reserved.
//

import Foundation

// MARK: Endpoint definitions
public enum Endpoint {
    case transactions
    case other(String)
}

extension Endpoint {
    var urlString: String {
        switch self {
            case .transactions:
                return "https://www.mocky.io/v2/5b36325b340000f60cf88903"
            case .other(let urlString):
                return urlString
        }
    }
}

// MARK: - APIResponse struct
struct APIResponse {
    var data: Foundation.Data?
    var response: URLResponse?
    var error: Error?
}

// MARK: - API handler
class APIHandler {

    // MARK: - Singleton
    static let shared = APIHandler()

    func get(endpoint: Endpoint, completion: ((APIResponse) -> Void)? = nil) {
        guard let url = URL(string: endpoint.urlString) else { return }
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
            completion?(APIResponse(data: data, response: response, error: error))
        }.resume()
    }

}
