//
//  Home.swift
//  DataProvider
//
//  Created by Sercan KAYA on 29.07.2022.
//

import Foundation

public struct Home: Decodable {
    public let id: String?
    public let name: String?
    public let price: Double?
    public let currency: String?
    public let imageURL: String?
    public let stock: Int?

     enum CodingKeys: String, CodingKey {
         case id, name, price, currency
         case imageURL = "imageUrl"
         case stock
     }
}
