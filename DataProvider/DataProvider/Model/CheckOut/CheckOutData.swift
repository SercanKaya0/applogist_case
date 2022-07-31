import Foundation

public struct CheckOutItem: Codable {
    public let id: String?
    public let amount: Int?
    
    public init(id: String?, amount: Int?) {
        self.id = id
        self.amount = amount
    }
}
