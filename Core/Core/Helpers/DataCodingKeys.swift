public struct DataCodingKeys: CodingKey {
    public var stringValue: String
    public var intValue: Int?
    
    public init?(stringValue: String) {
        self.stringValue = stringValue
    }
    
    public init?(intValue: Int) {
        self.intValue = intValue
        self.stringValue = "\(intValue)"
    }
    
    static func makeKey(name: String) -> DataCodingKeys {
        return DataCodingKeys(stringValue: name)!
    }
}
