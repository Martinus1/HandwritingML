//
//  AppDelegate.swift
//  BioGenesis
//
//  Created by Martin on 11/07/2022.
//

import UIKit
import Amplify
import AWSCognitoAuthPlugin
import AWSAPIPlugin
import AWSDataStorePlugin

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        //TODO: Check for internet connection
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        //TODO: AWS AMPLIFY
//        Auth.configureAmplify()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        var vc: UIViewController
        
        vc = storyboard.instantiateViewController(withIdentifier: "TabBarController")
        
        self.window?.rootViewController = vc
        self.window?.makeKeyAndVisible()
        
        //TODO: AWS AMPLIFY
//        Auth.fetchCurrentAuthSession { signedIn in
//            DispatchQueue.main.async {
//                Switcher.updateRootViewController(isSignedIn: signedIn)
//            }
//        }
        
        
        return true
    }

//    // MARK: UISceneSession Lifecycle
//
//    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
//        // Called when a new scene session is being created.
//        // Use this method to select a configuration to create the new scene with.
//        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
//    }
//
//    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
//        // Called when the user discards a scene session.
//        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
//        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
//    }
     
}


