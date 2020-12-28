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

// MARK: - URL session protocol
protocol URLSessionDataTaskProtocol { func resume() }
protocol URLSessionProtocol { typealias DataTaskResult = (Foundation.Data?, URLResponse?, Error?) -> Void

    func dataTask(with request: URLRequest, completionHandler: @escaping DataTaskResult) -> URLSessionDataTaskProtocol

}

extension URLSessionDataTask: URLSessionDataTaskProtocol {}
extension URLSession: URLSessionProtocol {

    func dataTask(with request: URLRequest, completionHandler: @escaping DataTaskResult) -> URLSessionDataTaskProtocol {
        let task: URLSessionDataTask = dataTask(with: request, completionHandler: completionHandler) as URLSessionDataTask
        return task
    }

}

// MARK: - API handler
class APIHandler {

    // MARK: - Singleton
    static let shared = APIHandler(session: URLSession.shared)

    private let session: URLSessionProtocol
    init(session: URLSessionProtocol) {
        self.session = session
    }

    func get(endpoint: Endpoint, completion: ((APIResponse) -> Void)? = nil) {
        guard let url = URL(string: endpoint.urlString) else { return }
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = "GET"
        session.dataTask(with: request as URLRequest) { data, response, error in
            completion?(APIResponse(data: data, response: response, error: error))
        }.resume()
    }

}
