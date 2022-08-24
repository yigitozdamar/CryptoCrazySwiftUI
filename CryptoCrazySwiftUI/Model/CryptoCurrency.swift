//
//  CryptoCurrency.swift
//  CryptoCrazySwiftUI
//
//  Created by Yigit Ozdamar on 23.08.2022.
//

import Foundation

struct CryptoCurrency: Hashable, Decodable, Identifiable {
    let id = UUID()
    let currency: String
    let price: String
    
    private enum CodingKeys: String, CodingKey {
        case currency = "currency"
        case price = "price"
    }
}
