//
//  Items.swift
//  ThisIsBud
//
//  Created by Olivier Conan on 27/12/2020.
//  Copyright © 2020 OlivierConan. All rights reserved.
//

import Foundation

struct Data: Codable {
    var data: [Transaction]
}

struct Transaction: Codable, Equatable, Hashable {

    var id: String
    var date: String
    var description: String
    var category: String
    var currency: String
    var amount: Amount
    var product: Product

    static func == (lhs: Transaction, rhs: Transaction) -> Bool {
        return lhs.id == rhs.id
    }

}

struct Amount: Codable, Hashable {

    var value: Double
    var currency_iso: String

}

struct Product: Codable, Hashable {

    var id: Int
    var title: String
    var icon: String

}
