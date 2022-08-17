//
//  DBManager.swift
//  BioGenesis
//
//  Created by Martin on 17/08/2022.
//

import UIKit
import Amplify
import AWSCognitoAuthPlugin
import AWSAPIPlugin
import AWSDataStorePlugin

class DBManager {
    func querySymptoms() {
        Amplify.DataStore.query(Symptoms.self) { result in
            switch(result) {
                
            case .success(let items):
                for item in items {
                    print("Symptoms ID: \(item.userId)")
                }
                
            case .failure(let error):
                print("Could not query DataStore(Symptoms): \(error)")
            }
        }
    }
    
    func queryTherapeutics() {
        Amplify.DataStore.query(Therapeutics.self) { result in
            switch(result) {
                
            case .success(let items):
                for item in items {
                    print("Symptoms ID: \(item.userId)")
                }
                
            case .failure(let error):
                print("Could not query DataStore(Thereapeutics): \(error)")
            }
        }
    }
    
    func postSymptomDataToCloud() {
        do {
            let createdAt = try Temporal.DateTime(iso8601String: "1970-01-01T12:30:23.999Z")
            let symptomData: NSDictionary = try JSONSerialization.jsonObject(with: urlData! as Data, options: JSONSerialization.ReadingOptions.mutableContainers ) as! NSDictionary
            //all fine with jsonData here
        } catch {
            //handle error
            print(error)
        }
        
        guard let userId = Amplify.Auth.getCurrentUser()?.userId else {
            print("User ID does can't be read")
        }
        
        
        let item = Symptoms(
                userId: userId,
                createdAt: createdAt,
                data: $data)
        Amplify.DataStore.save(item) { result in
            switch(result) {
            case .success(let savedItem):
                print("Saved item: \(savedItem.id)")
            case .failure(let error):
                print("Could not save item to DataStore: \(error)")
            }
        }
        
    }
    
    //TODO
    func postAPISymptoms() {
        func postTodo() {
            let message = #"{"message": "my new Todo"}"#
            let request = RESTRequest(path: "/todo", body: message.data(using: .utf8))
            Amplify.API.post(request: request) { result in
                switch result {
                case .success(let data):
                    let str = String(decoding: data, as: UTF8.self)
                    print("Success \(str)")
                case .failure(let apiError):
                    print("Failed", apiError)
                }
            }
        }
    }
}
