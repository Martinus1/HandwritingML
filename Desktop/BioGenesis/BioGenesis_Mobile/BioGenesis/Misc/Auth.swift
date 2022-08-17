//
//  Auth.swift
//  BioGenesis
//
//  Created by Martin on 14/08/2022.
//

import UIKit
import Amplify
import AWSCognitoAuthPlugin
import AWSAPIPlugin
import AWSDataStorePlugin

class Auth {
    
    static func configureAmplify() {
        do {
            try Amplify.add(plugin: AWSCognitoAuthPlugin())
            let models = AmplifyModels()
            try Amplify.add(plugin: AWSAPIPlugin(modelRegistration: models))
            try Amplify.add(plugin: AWSDataStorePlugin(modelRegistration: models))
            try Amplify.configure()
            print("Amplify initialized!")
        } catch {
            print("Failed to initialize Amplify with \(error)")
        }
    }

    
    enum RequestState: Error {
        case success, failure
    }
    
    //Return: IsUserSignedIn
    static func fetchCurrentAuthSession(completion: @escaping (Bool) -> Void) {
        var isSignedIn: Bool = false
        _ = Amplify.Auth.fetchAuthSession { result in
            switch result {
            case .success(let session):
                isSignedIn = session.isSignedIn
                print("Is user signed in - \(isSignedIn)")
                completion(isSignedIn)
            
            case .failure(let error):
                print("Fetch session failed with error \(error)")
                //TODO: Error Screen And Reload
            }
        }
        
    }
    
    static func localSignOut() {
        Amplify.Auth.signOut() { result in
            switch result {
            case .success:
                print("Successfully signed out")
            case .failure(let error):
                print("Sign out failed with error \(error)")
            }
        }
    }
    
    static func globalSignOut() {
        Amplify.Auth.signOut() { result in
            switch result {
            case .success:
                print("Successfully signed out")
            case .failure(let error):
                print("Sign out failed with error \(error)")
            }
        }
    }
    
}


struct Constants {
    struct StoryboardID {
        static let signInViewController = "SignupVC"
        static let mainTabBarController = "TabBarController"
    }
}


class Switcher {

    static func updateRootViewController(isSignedIn: Bool) {

        var rootViewController : UIViewController?

        #if DEBUG
        print(isSignedIn)
        #endif

        if (isSignedIn == true) {
            let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
            let mainTabBarController = mainStoryBoard.instantiateViewController(withIdentifier: Constants.StoryboardID.mainTabBarController) as! TabBarController
            rootViewController = mainTabBarController
        } else {
            let mainStoryBoard = UIStoryboard(name: "Onboarding", bundle: nil)
            let signInViewController = mainStoryBoard.instantiateViewController(withIdentifier: Constants.StoryboardID.signInViewController) as! SignupVC
            rootViewController = signInViewController
        }

        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = rootViewController
        appDelegate.window?.makeKeyAndVisible()

    }

}
