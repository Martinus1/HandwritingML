//
//  BiomarkersData.swift
//  BioGenesis
//
//  Created by Martin on 03/08/2022.
//

import Foundation

// MARK: - BiomarkersDataStruct
struct BiomarkersDataStruct: Codable {
    let name: String
    let targetGroupRanges: [TargetGroupRange]?
    let codes: Codes?
}

struct TargetGroupRange: Codable {
    //MARK: Information about group Type
    let targetAgeLow: Int?
    let targetAgeHigh: Int?
    let targetSex: Int?
    let taxonomies: [Taxonomy]?
    
    //MARK: Specifics about group Type
    let ranges: [RangeTypes : Float]?
    let unit: String?
}


enum RangeTypes: Codable {
    case lowerLimit
    case borderlineLowerLimit
    case borderlineUpperLimit
    case upperLimit
}

struct Codes: Codable {
    let code: String?
    let codeSystem: String?
    let codeSystemName: String?
    let name: String?
}

enum Taxonomy: Codable {
    case postmenopausal
}


let biomarkerValues: [BiomarkersDataStruct] = [
    
    //MARK: Ions and trace metals
    
    BiomarkersDataStruct(name: "Sodium",
                         
                         targetGroupRanges: [TargetGroupRange(
                            targetAgeLow: nil,
                            targetAgeHigh: nil,
                            targetSex: nil,
                            taxonomies: nil,
                            ranges: [.lowerLimit: 135, .upperLimit: 145],
                            unit: "mmol/L")],
                         
                         codes: nil),
    
    BiomarkersDataStruct(name: "Potassium",
                         
                         targetGroupRanges: [TargetGroupRange(
                            targetAgeLow: nil,
                            targetAgeHigh: nil,
                            targetSex: nil,
                            taxonomies: nil,
                            ranges: [.lowerLimit: 3.5, .upperLimit: 5.0],
                            unit: "mmol/L")],
                         
                         codes: nil),
    
    BiomarkersDataStruct(name: "Chloride",
                         
                         targetGroupRanges: [TargetGroupRange(
                            targetAgeLow: nil,
                            targetAgeHigh: nil,
                            targetSex: nil,
                            taxonomies: nil,
                            ranges: [.lowerLimit: 95, .upperLimit: 105],
                            unit: "mmol/L")],
                         
                         codes: nil),
    
    BiomarkersDataStruct(name: "Ionized calcium",

                         targetGroupRanges: [TargetGroupRange(
                            targetAgeLow: nil,
                            targetAgeHigh: nil,
                            targetSex: nil,
                            taxonomies: nil,
                            ranges: [.lowerLimit: 1.03, .upperLimit: 1.23],
                            unit: "mmol/L")],

                         codes: nil),
    
    BiomarkersDataStruct(name: "Total calcium",

                         targetGroupRanges: [TargetGroupRange(
                            targetAgeLow: nil,
                            targetAgeHigh: nil,
                            targetSex: nil,
                            taxonomies: nil,
                            ranges: [.lowerLimit: 2.1, .upperLimit: 2.5],
                            unit: "mmol/L")],

                         codes: nil),
    
    BiomarkersDataStruct(name: "Total serum iron",

                         targetGroupRanges: [
                        //Male
                        TargetGroupRange(
                            targetAgeLow: nil,
                            targetAgeHigh: nil,
                            targetSex: 1,
                            taxonomies: nil,
                            ranges: [.lowerLimit: 76, .upperLimit: 198],
                            unit: "µg/dL"),
                                             
                         //Female
                         TargetGroupRange(
                            targetAgeLow: nil,
                            targetAgeHigh: nil,
                            targetSex: 0,
                            taxonomies: nil,
                            ranges: [.lowerLimit: 26, .upperLimit: 170],
                            unit: "µg/dL")],
                         codes: nil),
    
    BiomarkersDataStruct(name: "Total iron-binding capacity",

                         targetGroupRanges: [TargetGroupRange(
                            targetAgeLow: nil,
                            targetAgeHigh: nil,
                            targetSex: 1,
                            taxonomies: nil,
                            ranges: [.lowerLimit: 262, .upperLimit: 474],
                            unit: "µg/dL")],
                                             
                         codes: nil),
    
    BiomarkersDataStruct(name: "Ferritin",

                         targetGroupRanges: [
                            //Postmenopausal Female
                            TargetGroupRange(
                            targetAgeLow: nil,
                            targetAgeHigh: nil,
                            targetSex: 0,
                            taxonomies: [.postmenopausal],
                            ranges: [.lowerLimit: 12, .upperLimit: 300],
                            unit: "µg/L"),
                         
                            //Premenopausal Female
                            TargetGroupRange(
                            targetAgeLow: nil,
                            targetAgeHigh: nil,
                            targetSex: 0,
                            taxonomies: [.postmenopausal],
                            ranges: [.lowerLimit: 12, .upperLimit: 200],
                            unit: "µg/L"),
                            
                            //Male
                            TargetGroupRange(
                            targetAgeLow: nil,
                            targetAgeHigh: nil,
                            targetSex: 1,
                            taxonomies: [.postmenopausal],
                            ranges: [.lowerLimit: 12, .upperLimit: 300],
                            unit: "µg/L")
                         
                         ],
                                             
                         codes: nil),
    
    BiomarkersDataStruct(name: "Ammonia",

                         targetGroupRanges: [TargetGroupRange(
                            targetAgeLow: nil,
                            targetAgeHigh: nil,
                            targetSex: nil,
                            taxonomies: [.postmenopausal],
                            ranges: [.lowerLimit: 10, .upperLimit: 35],
                            unit: "μmol/L")],
                                             
                         codes: nil),
    
    BiomarkersDataStruct(name: "Copper",

                         targetGroupRanges: [TargetGroupRange(
                            targetAgeLow: nil,
                            targetAgeHigh: nil,
                            targetSex: nil,
                            taxonomies: [.postmenopausal],
                            ranges: [.lowerLimit: 70, .upperLimit: 150],
                            unit: "µg/dL")],
                                             
                         codes: nil),
    
    BiomarkersDataStruct(name: "Ceruloplasmin",

                         targetGroupRanges: [TargetGroupRange(
                            targetAgeLow: nil,
                            targetAgeHigh: nil,
                            targetSex: nil,
                            taxonomies: [.postmenopausal],
                            ranges: [.lowerLimit: 15, .upperLimit: 60],
                            unit: "mg/dL")],
                                             
                         codes: nil),
    
    BiomarkersDataStruct(name: "Phosphate",

                         targetGroupRanges: [TargetGroupRange(
                            targetAgeLow: nil,
                            targetAgeHigh: nil,
                            targetSex: nil,
                            taxonomies: [.postmenopausal],
                            ranges: [.lowerLimit: 0.8, .upperLimit: 1.5],
                            unit: "mmol/L")],
                                             
                         codes: nil),
    
    BiomarkersDataStruct(name: "Inorganic phosphorus",

                         targetGroupRanges: [TargetGroupRange(
                            targetAgeLow: nil,
                            targetAgeHigh: nil,
                            targetSex: nil,
                            taxonomies: [.postmenopausal],
                            ranges: [.lowerLimit: 1, .upperLimit: 1.5],
                            unit: "mmol/L")],
                                             
                         codes: nil),
    
    BiomarkersDataStruct(name: "Zinc",

                         targetGroupRanges: [TargetGroupRange(
                            targetAgeLow: nil,
                            targetAgeHigh: nil,
                            targetSex: nil,
                            taxonomies: [.postmenopausal],
                            ranges: [.lowerLimit: 60, .upperLimit: 110],
                            unit: "μg/dL")],
                                             
                         codes: nil),
    
    BiomarkersDataStruct(name: "Magnesium",

                         targetGroupRanges: [TargetGroupRange(
                            targetAgeLow: nil,
                            targetAgeHigh: nil,
                            targetSex: nil,
                            taxonomies: [.postmenopausal],
                            ranges: [.lowerLimit: 1.5, .upperLimit: 2.0],
                            unit: "mg/dL")],
                                             
                         codes: nil),
    
    //MARK: Liver function

    BiomarkersDataStruct(name: "Total Protein",

                         targetGroupRanges: [TargetGroupRange(
                            targetAgeLow: nil,
                            targetAgeHigh: nil,
                            targetSex: nil,
                            taxonomies: [.postmenopausal],
                            ranges: [.lowerLimit: 60, .upperLimit: 78],
                            unit: "g/L")],
                                             
                         codes: nil),
    
    BiomarkersDataStruct(name: "Albumin",

                         targetGroupRanges: [TargetGroupRange(
                            targetAgeLow: nil,
                            targetAgeHigh: nil,
                            targetSex: nil,
                            taxonomies: [.postmenopausal],
                            ranges: [.lowerLimit: 35, .upperLimit: 48],
                            unit: "g/L")],
                                             
                         codes: nil),
    
    BiomarkersDataStruct(name: "Albumin",

                         targetGroupRanges: [TargetGroupRange(
                            targetAgeLow: nil,
                            targetAgeHigh: nil,
                            targetSex: nil,
                            taxonomies: [.postmenopausal],
                            ranges: [.lowerLimit: 35, .upperLimit: 48],
                            unit: "g/L")],
                                             
                         codes: nil),
    
    BiomarkersDataStruct(name: "Globulins",

                         targetGroupRanges: [TargetGroupRange(
                            targetAgeLow: nil,
                            targetAgeHigh: nil,
                            targetSex: nil,
                            taxonomies: [.postmenopausal],
                            ranges: [.lowerLimit: 23, .upperLimit: 35],
                            unit: "g/L")],
                                             
                         codes: nil),
    
    BiomarkersDataStruct(name: "Total bilirubin",

                         targetGroupRanges: [TargetGroupRange(
                            targetAgeLow: nil,
                            targetAgeHigh: nil,
                            targetSex: nil,
                            taxonomies: [.postmenopausal],
                            ranges: [.lowerLimit: 1.7, .upperLimit: 22],
                            unit: "μmol/L")],
                                             
                         codes: nil),
    
    
    BiomarkersDataStruct(name: "Conjugated bilirubin",

                         targetGroupRanges: [TargetGroupRange(
                            targetAgeLow: nil,
                            targetAgeHigh: nil,
                            targetSex: nil,
                            taxonomies: [.postmenopausal],
                            ranges: [.lowerLimit: 0, .upperLimit: 5],
                            unit: "μmol/L")],
                                             
                         codes: nil),
    
    BiomarkersDataStruct(name: "Alanine transaminase",

                         targetGroupRanges: [
                        //Male
                        TargetGroupRange(
                            targetAgeLow: nil,
                            targetAgeHigh: nil,
                            targetSex: 1,
                            taxonomies: nil,
                            ranges: [.lowerLimit: 0.15, .upperLimit: 1.1],
                            unit: "µkat/L"),
                                             
                         //Female
                         TargetGroupRange(
                            targetAgeLow: nil,
                            targetAgeHigh: nil,
                            targetSex: 0,
                            taxonomies: nil,
                            ranges: [.lowerLimit: 26, .upperLimit: 0.75],
                            unit: "µkat/L")],
                         codes: nil),
    
    BiomarkersDataStruct(name: "Alanine phosphatase",

                         targetGroupRanges: [
                        //Male
                        TargetGroupRange(
                            targetAgeLow: nil,
                            targetAgeHigh: nil,
                            targetSex: 1,
                            taxonomies: nil,
                            ranges: [.lowerLimit: 53, .upperLimit: 128],
                            unit: "U/L"),
                                             
                         //Female
                         TargetGroupRange(
                            targetAgeLow: nil,
                            targetAgeHigh: nil,
                            targetSex: 0,
                            taxonomies: nil,
                            ranges: [.lowerLimit: 42, .upperLimit: 98],
                            unit: "U/L")],
                         
                         codes: nil),
    
    BiomarkersDataStruct(name: "Gamma glutamyl transferase",

                         targetGroupRanges: [TargetGroupRange(
                            targetAgeLow: nil,
                            targetAgeHigh: nil,
                            targetSex: 1,
                            taxonomies: nil,
                            ranges: [.lowerLimit: 8, .upperLimit: 78],
                            unit: "µkat/L")],
                                             
                         codes: nil)
    

    
//    BiomarkersDataStruct(name: "",
//
//                         targetGroupRanges: [TargetGroupRange(
//                            targetAgeLow: nil,
//                            targetAgeHigh: nil,
//                            targetSex: nil,
//                            ranges: [.lowerLimit: , .upperLimit: ],
//                            unit: "mmol/L")],
//
//                         codes: nil),
    
    
    
]
