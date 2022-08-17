// swiftlint:disable all
import Amplify
import Foundation

public struct Profile: Model {
  public let id: String
  public var userId: String
  public var createdAt: Temporal.DateTime
  public var data: String?
  public var updatedAt: Temporal.DateTime?
  
  public init(id: String = UUID().uuidString,
      userId: String,
      createdAt: Temporal.DateTime,
      data: String? = nil) {
    self.init(id: id,
      userId: userId,
      createdAt: createdAt,
      data: data,
      updatedAt: nil)
  }
  internal init(id: String = UUID().uuidString,
      userId: String,
      createdAt: Temporal.DateTime,
      data: String? = nil,
      updatedAt: Temporal.DateTime? = nil) {
      self.id = id
      self.userId = userId
      self.createdAt = createdAt
      self.data = data
      self.updatedAt = updatedAt
  }
}