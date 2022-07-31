public struct CheckOutRequest: BaseRequest {
    
    public typealias ResponseType = CheckOut
    
    public var path: String = "checkout"
    public var method: RequestMethod = .post
    public var parameters: RequestParameters = [:]
    public var headers: RequestHeaders = [:]
    
    public init(items: [CheckOutItem]?) {
        let body = items?.map { item -> [String: Any?] in
            return [
                "id" : item.id,
                "amount": item.amount
            ]
        }
        parameters = ["products": body]
    }
}
