//
//  HumanAPIFunctions.swift
//  BioGenesis
//
//  Created by Martin on 04/08/2022.
//

import Foundation

//MARK: Allergies

// MARK: - AllergenElement
struct AllergenElement {
    let createdAt, id, name: String?
    let organization: Organization?
    let patient: Patient?
    let reactionsFull: [Any?]
    let source, updatedAt: String?
    let allergen: Allergen?
    let codes: [Code]?
}

// MARK: - Allergen
struct Allergen {
    let codes: [Code]?
}

// MARK: - Code
struct Code {
    let code, codeSystem, codeSystemName, name: String?
}

// MARK: - Organization
struct Organization {
    let href, id, name: String?
}

// MARK: - Patient
struct Patient {
    let name: String?
}


//MARK: Allergies

// MARK: - WelcomeElement
struct WelcomeElement {
    let allResults: [Any?]
    let components: [Component]?
    let codes: [Code]?
    let createdAt, id, name, orderedBy: String?
    let organization: Organization?
    let patient: Patient?
    let recipients: [Recipient]?
    let resultDateTime, source, status, updatedAt: String?
}

// MARK: - Component
struct Component {
    let codes: [Any?]
    let high, low, name, unit: String?
    let value: String?
}

// MARK: - Recipient
struct Recipient {
    let isPCP: Bool?
    let name, objectID, recipTemplate: String?
}
