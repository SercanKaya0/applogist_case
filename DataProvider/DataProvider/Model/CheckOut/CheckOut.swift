
import Foundation

public struct CheckOut: Decodable {
    
    public let orderId: String
    public let message: String?

     enum CodingKeys: String, CodingKey {
         case orderId = "orderID"
         case message
     }
}
