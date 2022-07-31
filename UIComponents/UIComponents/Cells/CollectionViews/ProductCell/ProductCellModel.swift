//
//  ProductCellModel.swift
//  UIComponents
//
//  Created by Sercan KAYA on 29.07.2022.
//

import Foundation

public protocol ProductCellDataSource: AnyObject {
    var id: String? { get set }
    var image: String? { get set }
    var title: String? { get set }
    var price: Double? { get set }
    var currency: String? { get set }
    var stock: Int? { get set }
    var count: Int { get set }
}

public protocol ProductCellEventSource: AnyObject {
}

public protocol ProductCellProtocol: ProductCellDataSource, ProductCellEventSource {
    func updateCount(count: Int)
}

public final class ProductCellModel: ProductCellProtocol {
    
    public var image: String?
    public var title: String?
    public var price: Double?
    public var currency: String?
    public var id: String?
    public var stock: Int?
    public var count: Int = 0
        
    public init(image: String? = nil, title: String? = nil,
                price: Double? = nil, currency: String? = nil, id: String?, stock: Int?) {
        self.image = image
        self.title = title
        self.price = price
        self.currency = currency
        self.id = id
        self.stock = stock
    }

    public func updateCount(count: Int) {
        self.count = count
    }
}
