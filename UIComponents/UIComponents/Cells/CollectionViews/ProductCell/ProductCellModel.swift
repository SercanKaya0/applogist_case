//
//  ProductCellModel.swift
//  UIComponents
//
//  Created by Sercan KAYA on 29.07.2022.
//

import Foundation

public protocol ProductCellDataSource: AnyObject {
    var image: String? { get set }
    var title: String? { get set }
    var price: Double? { get set }
    var currency: String? { get set }
}

public protocol ProductCellEventSource: AnyObject {
    
}

public protocol ProductCellProtocol: ProductCellDataSource, ProductCellEventSource {
    
}

public final class ProductCellModel: ProductCellProtocol {
    
    public var image: String?
    public var title: String?
    public var price: Double?
    public var currency: String?
    
    public init(image: String? = nil, title: String? = nil,
                price: Double? = nil, currency: String? = nil) {
        self.image = image
        self.title = title
        self.price = price
        self.currency = currency
    }
}
