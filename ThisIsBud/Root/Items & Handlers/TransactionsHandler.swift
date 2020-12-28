//
//  TransactionsHandler.swift
//  ThisIsBud
//
//  Created by Olivier Conan on 27/12/2020.
//  Copyright © 2020 OlivierConan. All rights reserved.
//

import Foundation

protocol TransactionsProtocol {

    func getTransactions(completion: @escaping ([Transaction]) -> Void)
    func removeTransaction(ids: String..., completion: ((Error?) -> Void)?) -> Void

}

class TransactionHandler: TransactionsProtocol {

    // MARK: - Singleton
    static let shared = TransactionHandler()

    func getTransactions(completion: @escaping ([Transaction]) -> Void) {
        APIHandler.shared.get(endpoint: .transactions) { response in
            if let data = response.data, let decodedResponse = try? JSONDecoder().decode(Data.self, from: data) {
                completion(decodedResponse.data)
                return
            }
        }
    }

    func removeTransaction(ids: String..., completion: ((Error?) -> Void)?) {
        removeTransaction(ids: ids, completion: completion)
    }

    func removeTransaction(ids: [String], completion: ((Error?) -> Void)?) {
        /// Remove is just here to simulate it, since endpoint is just a `get` for this test
        print("removing: \(ids)")
        completion?(nil)
    }
    
}
