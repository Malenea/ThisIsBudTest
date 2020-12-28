//
//  ThisIsBudTests.swift
//  ThisIsBudTests
//
//  Created by Motionmetrics on 28/12/2020.
//  Copyright © 2020 OlivierConan. All rights reserved.
//

import XCTest
@testable import ThisIsBud

class MockURLSessionDataTask: URLSessionDataTaskProtocol {

    private (set) var resumeWasCalled = false

    func resume() { resumeWasCalled = true }

}

class MockURLSession: URLSessionProtocol {

    typealias DataTaskResult = (Foundation.Data?, URLResponse?, Error?) -> Void
    var nextDataTask = MockURLSessionDataTask()
    var nextData: Foundation.Data?
    var nextError: Error?
    private (set) var lastURL: URL?
    private var mockResponse: HTTPURLResponse?

    init() {}
    init(mockResponse: HTTPURLResponse) {
        self.mockResponse = mockResponse
    }

    func successHttpURLResponse(request: URLRequest) -> URLResponse {
        return HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: "HTTP/1.1", headerFields: nil)!
    }

    func wrongHttpURLResponse(request: URLRequest, statusCode:Int) -> URLResponse {
        return HTTPURLResponse(url: request.url!, statusCode: statusCode, httpVersion: "HTTP/1.1", headerFields: nil)!
    }

    func dataTask(with request: URLRequest, completionHandler: @escaping DataTaskResult) -> URLSessionDataTaskProtocol {
        lastURL = request.url
        nextDataTask.resume()
        if let mockResponse = mockResponse {
            completionHandler(nextData, mockResponse, nextError)
        } else {
            completionHandler(nextData, successHttpURLResponse(request: request), nextError)
        }
        return nextDataTask
    }

}

class ThisIsBudTests: XCTestCase {

    func testAPIHandler() throws {
        let dataTask = MockURLSessionDataTask()
        let session = MockURLSession()
        session.nextDataTask = dataTask

        let handler = APIHandler(session: session)
        handler.get(endpoint: .transactions) { response in
        }

        XCTAssert(dataTask.resumeWasCalled)
    }

    func testPerformanceExample() throws {
        measure {
            let dataTask = MockURLSessionDataTask()
            let session = MockURLSession()
            session.nextDataTask = dataTask

            let handler = APIHandler(session: session)
            handler.get(endpoint: .transactions) { response in
            }

            XCTAssert(dataTask.resumeWasCalled)
        }
    }

}
