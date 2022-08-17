// swiftlint:disable all
import Amplify
import Foundation

extension Profile {
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
    let profile = Profile.keys
    
    model.authRules = [
      rule(allow: .public, operations: [.create, .update, .delete, .read])
    ]
    
    model.pluralName = "Profiles"
    
    model.fields(
      .id(),
      .field(profile.userId, is: .required, ofType: .string),
      .field(profile.createdAt, is: .required, ofType: .dateTime),
      .field(profile.data, is: .optional, ofType: .string),
      .field(profile.updatedAt, is: .optional, isReadOnly: true, ofType: .dateTime)
    )
    }
}