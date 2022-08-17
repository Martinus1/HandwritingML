//
//  DrugBankAPIFunctions.swift
//  BioGenesis
//
//  Created by Martin on 15/07/2022.
//


// MARK: - DrugBankElement
struct DrugBankElement: Codable {
    let hits: [Hit]
    let detailedHits: [DetailedHit]?
    let name: String
    let displayName: String?
    let drugbankPcid: String?
    let brand: String?
    let level: Int?
    let route, form, strengths: JSONNull?
    let standing: Standing?
    let standingUpdatedAt: String?
    let standingActiveSince: String?
    let regions: Regions?
    let rxnormConcepts: [RxnormConcept]?
    let ingredients: [Ingredient]?

    enum CodingKeys: String, CodingKey {
        case hits
        case detailedHits
        case name
        case displayName
        case drugbankPcid
        case brand, level, route, form, strengths, standing
        case standingUpdatedAt
        case standingActiveSince
        case regions
        case rxnormConcepts
        case ingredients
    }
}

// MARK: - DetailedHit
struct DetailedHit: Codable {
    let field: Field?
    let matches: Matches?
    let matchHighlightName: String?

    enum CodingKeys: String, CodingKey {
        case field, matches
        case matchHighlightName
    }
}

enum Field: String, Codable {
    case brand = "brand"
    case ingredients = "ingredients"
    case productsAvailableUs = "products_available_us"
    case title = "title"
}

enum Matches: Codable {
    case stringArray([String])
    case stringArrayMap([String: [String]])

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode([String].self) {
            self = .stringArray(x)
            return
        }
        if let x = try? container.decode([String: [String]].self) {
            self = .stringArrayMap(x)
            return
        }
        throw DecodingError.typeMismatch(Matches.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Matches"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .stringArray(let x):
            try container.encode(x)
        case .stringArrayMap(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Hit
struct Hit: Codable {
    let value: String?
}

// MARK: - Ingredient
struct Ingredient: Codable {
    let name: String?
    let drug: Drug?
    let exactIngredient: Drug?

    enum CodingKeys: String, CodingKey {
        case name, drug
        case exactIngredient
    }
}

// MARK: - Drug
struct Drug: Codable {
    let name, drugbankID: String?

    enum CodingKeys: String, CodingKey {
        case name
        case drugbankID
    }
}

// MARK: - Regions
struct Regions: Codable {
    let us, canada, eu: Bool?
}

// MARK: - RxnormConcept
struct RxnormConcept: Codable {
    let name, rxcui: String?

    enum CodingKeys: String, CodingKey {
        case name
        case rxcui
    }
}

enum Standing: String, Codable {
    case active = "active"
}

typealias DrugBankResult = [DrugBankElement]

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
