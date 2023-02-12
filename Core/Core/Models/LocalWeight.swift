/**
Weight representation used only on the client. Encodes to this structure for sending to the API
````
{
    "kilograms": {
        "kilograms": 70.1
    },
    "stone": {
        "stone": 11,
        "pounds": 3.4
    },
    "pounds": {
        "pounds": 157.4
    }
}
````
*/
public enum LocalWeight {
    case kilograms(kilograms: Decimal)
    case stone(stone: Int, pounds: Decimal)
    case pounds(pounds: Decimal)
}

extension LocalWeight: Encodable {
    
    enum CodingKeys: String, CodingKey {
        case kilograms, stone, pounds
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self )
        switch self {
        case .kilograms(kilograms: let kilograms):
            var innerContainer = container.nestedContainer(keyedBy: DataCodingKeys.self, forKey: .kilograms)
            try innerContainer.encode(kilograms, forKey: .makeKey(name: "kilograms"))
        case .pounds(pounds: let pounds):
            var innerContainer = container.nestedContainer(keyedBy: DataCodingKeys.self, forKey: .pounds)
            try innerContainer.encode(pounds, forKey: .makeKey(name: "pounds"))
        case .stone(stone: let stone, pounds: let pounds):
            var innerContainer = container.nestedContainer(keyedBy: DataCodingKeys.self, forKey: .stone)
            try innerContainer.encode(stone, forKey: .makeKey(name: "stone"))
            try innerContainer.encode(pounds, forKey: .makeKey(name: "pounds"))
        }
    }
    
}
