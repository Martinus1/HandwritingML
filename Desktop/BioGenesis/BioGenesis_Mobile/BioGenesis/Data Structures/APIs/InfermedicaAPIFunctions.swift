//
//  InfermedicaAPIFunctions.swift
//  BioGenesis
//
//  Created by Martin on 15/07/2022.
//


struct InfermedicaSearchResponse: Codable {
    let id, label: String
}

typealias SearchResponse = [InfermedicaSearchResponse]
