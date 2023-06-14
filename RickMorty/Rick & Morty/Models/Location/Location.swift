// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? JSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - Welcome
struct LocationModel: Codable {
    let info: InfoLocation
    let results: [ResultLocation]
}

// MARK: - Info
struct InfoLocation: Codable {
    let count, pages: Int
    let next: String
    let prev: JSONNullLocation?
}

// MARK: - Result
struct ResultLocation: Codable {
    let id: Int
    let name, type, dimension: String
    let residents: [String]
    let url: String
    let created: String
}

// MARK: - Encode/decode helpers

class JSONNullLocation: Codable, Hashable {

    public static func == (lhs: JSONNullLocation, rhs: JSONNullLocation) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNullLocation.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
