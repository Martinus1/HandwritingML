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
    
    func createNewSymptomDataToCloud(symptomName: String) {
        
        guard let userId = Amplify.Auth.getCurrentUser()?.userId else {
            print("User ID does can't be read")
            return
        }
        
        let jsonObject: [String: Any] = [
            "name": "Headache",
            "logs": [
                "1": "10/04/2015 12:45",
                "2": "10/04/2015 16:00"
            ],
            "isHighlighted" : false
        ]

        let valid = JSONSerialization.isValidJSONObject(jsonObject)
        
        do {
            let createdAt = try Temporal.DateTime(iso8601String: "1970-01-01T12:30:23.999Z")
            //all fine with jsonData here
            
            let item = Symptoms(
                    userId: userId,
                    createdAt: createdAt,
                    data: "")
            Amplify.DataStore.save(item) { result in
                switch(result) {
                case .success(let savedItem):
                    print("Saved item: \(savedItem.id)")
                case .failure(let error):
                    print("Could not save item to DataStore: \(error)")
                }
            }
        } catch {
            //handle error
            print(error)
        }
        
    }

}
