//
//  SettingsVC.swift
//  BioGenesis
//
//  Created by Martin on 14/08/2022.
//

import UIKit
import Amplify

class SettingsVC: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupScrollView()
    }
    
    func setupScrollView() {
        let signOutButton = UIButton()
        signOutButton.frame = CGRect(x: 12, y: screenSize.height - 80, width: screenSize.width - 24, height: 50)
        signOutButton.backgroundColor = .black
        signOutButton.setTitle("Sign Out", for: .normal)
        signOutButton.addTarget(self, action: #selector(signOutButtonPressed), for: .touchUpInside)
        
        scrollView.addSubview(signOutButton)
    }

    @IBAction func signOutButtonPressed() {
        //Local Sign Out
        Auth.localSignOut()
        
        //Global Sign Out
//        Amplify.Auth.signOut(options: .init(globalSignOut: true)) { result in
//            switch result {
//            case .success:
//                print("Successfully signed out")
//            case .failure(let error):
//                print("Sign out failed with error \(error)")
//            }
//        }
    }
    
}
