
import Foundation

// MARK: - Welcome
struct EpisodeModel: Codable {
    let info: Info
    let results: [ResultEp]
}

// MARK: - Info
struct InfoEp: Codable {
    let count, pages: Int
    let next: String
    let prev: JSONNullEp?
}

// MARK: - Result
struct ResultEp: Codable {
    let id: Int
    let name, airDate, episode: String
    let characters: [String]
    let url: String
    let created: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case airDate = "air_date"
        case episode, characters, url, created
    }
}

// MARK: - Encode/decode helpers

class JSONNullEp: Codable, Hashable {
    static func == (lhs: JSONNullEp, rhs: JSONNullEp) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNullEp.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
