//
//  CheckOutModel.swift
//  applogist_case
//
//  Created by Sercan KAYA on 31.07.2022.
//

import Foundation

struct CheckOutModel {

    var image: String?
    var id: String?
    var price: Double?
    var title: String?
    var count: Int
    var currency: String?
    var stock: Int?
    
    public init(image: String?, id: String?, price: Double?, title: String?, count: Int, currency: String?, stock: Int?) {
        self.image = image
        self.id = id
        self.price = price
        self.title = title
        self.count = count
        self.currency = currency
        self.stock = stock
    }
}
