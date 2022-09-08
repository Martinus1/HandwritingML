//
//  SettingsVC.swift
//  BioGenesis
//
//  Created by Martin on 14/08/2022.
//

import UIKit
import MessageUI
import Amplify

class SettingsVC: UIViewController, MFMailComposeViewControllerDelegate {
    
    let scrollView = UIScrollView()
    let topView = CustomTopBar()


    let settingButtons = ["Pregnancy", "Account", "Storage", "Security", "Contact Us", "About"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = backgroundColorMain
        scrollView.backgroundColor = backgroundColorMain
        
        setupBaseElements()
        setupScrollView()
    }
    
    
    func setupBaseElements() {
        
        topView.title = "Settings"
        topView.height = normalTabBarHeight
        self.view.addSubview(topView)
        
        let backBtn = UIButton()
        backBtn.frame = CGRect(x: 12, y: topView.safeAreaTop, width: backBtnWH, height: backBtnWH)
        backBtn.setImage(UIImage(named: "back_button") , for: .normal)
        backBtn.addTarget(self, action: #selector(backBtnPressed(_:)), for: .touchUpInside)
        
        topView.addSubview(backBtn)
        
        scrollView.frame = CGRect(x: 0, y: topView.frame.height, width: screenSize.width, height: screenSize.height - topView.frame.height)
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        view.addSubview(scrollView)
        
    }
    
    func setupScrollView() {
        
        var yPosition: CGFloat = 12
        
        for (index, button) in settingButtons.enumerated() {
            addSettingsButton(yPosition: yPosition, tag: index,name: button, height: 55)
            yPosition += 55
        }
        
        yPosition += 24
        
        let signOutButton = UIButton()
        let signOutButtonWidth: CGFloat = screenSize.width / 4.5
        signOutButton.frame = CGRect(x: (screenSize.width - signOutButtonWidth ) / 2, y: yPosition, width:signOutButtonWidth, height: 50)
        signOutButton.backgroundColor = .black
        signOutButton.layer.cornerRadius = cornerRadius
        signOutButton.addTarget(self, action: #selector(signOutButtonPressed), for: .touchUpInside)
        scrollView.addSubview(signOutButton)
        
        let signOutButtonTitle = UILabel()
        signOutButtonTitle.frame = CGRect(x: 0, y: 0, width: signOutButton.frame.width, height: signOutButton.frame.height)
        signOutButtonTitle.text = "Sign Out"
        signOutButtonTitle.font = .header3()
        signOutButtonTitle.textAlignment = .center
        signOutButtonTitle.textColor = .white
        signOutButton.addSubview(signOutButtonTitle)
        
    }

    
    func addSettingsButton(yPosition: CGFloat, tag: Int, name: String, height: CGFloat) {
        let buttonBox = UIButton()
        buttonBox.frame = CGRect(x: 0, y: yPosition, width: screenSize.width, height: height)
        buttonBox.tag = tag
        if tag != 4 {
            buttonBox.addTarget(self, action: #selector(settingsButtonPressed(_:)), for: .touchUpInside)
        } else {
            //MARK: Contact us
            buttonBox.addTarget(self, action: #selector(contactUsPressed), for: .touchUpInside)
        }
        scrollView.addSubview(buttonBox)
        
        let buttonTitle = UILabel()
        buttonTitle.text = name
        buttonTitle.frame = CGRect(x: 12, y: 0, width: screenSize.width, height: height)
        buttonTitle.font = .paragraph3()
        buttonTitle.textColor = .black
        buttonTitle.textAlignment = .left
        buttonBox.addSubview(buttonTitle)
        
        let arrowImage = UIImageView()
        arrowImage.image = UIImage(named: "arrowRight")
        arrowImage.contentMode = .scaleAspectFit
        arrowImage.frame = CGRect(x: buttonBox.frame.width - 20 - 12, y: 4, width: 12, height: height - 8)
        buttonBox.addSubview(arrowImage)
    
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func signOutButtonPressed() {
        //Local Sign Out
//        Auth.localSignOut()
        
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
    
    @IBAction func settingsButtonPressed(_ sender: UIButton) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        switch sender.tag {
        case 0:
            //MARK: Blood
            let vc = storyboard.instantiateViewController(identifier: "BloodWalletVC")
//            present(vc, animated: true, completion: nil)
        case 1:
            //MARK: Profile
            let vc = storyboard.instantiateViewController(identifier: "SettingsAccountVC")
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
        case 2:
            //MARK: Symptoms
            let vc = storyboard.instantiateViewController(identifier: "SymptomWalletVC")
//            present(vc, animated: true, completion: nil)
        case 3:
            //MARK: Protocols
            let vc = storyboard.instantiateViewController(identifier: "ProtocolsWalletVC")
//            present(vc, animated: true, completion: nil)
        case 4:
            //MARK: Contact Us
            let vc = storyboard.instantiateViewController(identifier: "AllergyWalletVC")
//            present(vc, animated: true, completion: nil)
        case 5:
            //MARK: About
            let vc = storyboard.instantiateViewController(identifier: "SettingsAboutVC")
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
        default:
            break
        }
    }
    
    @objc func contactUsPressed() {
        let mailComposeViewController = configureMailComposer()
        if MFMailComposeViewController.canSendMail(){
            self.present(mailComposeViewController, animated: true, completion: nil)
        }else{
            print("Can't send email")
        }
    }
    
    
    func configureMailComposer() -> MFMailComposeViewController{
        let mailComposeVC = MFMailComposeViewController()
        mailComposeVC.mailComposeDelegate = self
        mailComposeVC.setToRecipients(["martin@biogenesistech.com"])
        mailComposeVC.setSubject("Feedback BioGenesis, iOS App")
        mailComposeVC.setMessageBody("", isHTML: true)
        return mailComposeVC
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
}
