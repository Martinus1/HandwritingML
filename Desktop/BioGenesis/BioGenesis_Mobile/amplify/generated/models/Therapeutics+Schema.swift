// swiftlint:disable all
import Amplify
import Foundation

extension Therapeutics {
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
    let therapeutics = Therapeutics.keys
    
    model.authRules = [
      rule(allow: .public, operations: [.create, .update, .delete, .read])
    ]
    
    model.pluralName = "Therapeutics"
    
    model.fields(
      .id(),
      .field(therapeutics.userId, is: .required, ofType: .string),
      .field(therapeutics.createdAt, is: .required, ofType: .dateTime),
      .field(therapeutics.data, is: .optional, ofType: .string),
      .field(therapeutics.updatedAt, is: .optional, isReadOnly: true, ofType: .dateTime)
    )
    }
}