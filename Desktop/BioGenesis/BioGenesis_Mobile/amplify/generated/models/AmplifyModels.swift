// swiftlint:disable all
import Amplify
import Foundation

// Contains the set of classes that conforms to the `Model` protocol. 

final public class AmplifyModels: AmplifyModelRegistration {
  public let version: String = "d610ef7750edb6d82c1edc979804f847"
  
  public func registerModels(registry: ModelRegistry.Type) {
    ModelRegistry.register(modelType: Profile.self)
    ModelRegistry.register(modelType: Therapeutics.self)
    ModelRegistry.register(modelType: Symptoms.self)
  }
}