// swiftlint:disable all
import Amplify
import Foundation

extension Symptoms {
  // MARK: - CodingKeys 
   public enum CodingKeys: String, ModelKey {
    case id
    case userId
    case createdAt
    case data
    case updatedAt
  }
  
  public static let keys = CodingKeys.self
  //  MARK: - ModelSchema 
  
  public static let schema = defineSchema { model in
    let symptoms = Symptoms.keys
    
    model.authRules = [
      rule(allow: .public, operations: [.create, .update, .delete, .read])
    ]
    
    model.pluralName = "Symptoms"
    
    model.fields(
      .id(),
      .field(symptoms.userId, is: .required, ofType: .string),
      .field(symptoms.createdAt, is: .required, ofType: .dateTime),
      .field(symptoms.data, is: .optional, ofType: .string),
      .field(symptoms.updatedAt, is: .optional, isReadOnly: true, ofType: .dateTime)
    )
    }
}