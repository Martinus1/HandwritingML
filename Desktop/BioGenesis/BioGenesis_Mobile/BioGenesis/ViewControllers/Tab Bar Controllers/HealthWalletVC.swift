//
//  HealthWalletVC.swift
//  BioGenesis
//
//  Created by Martin on 17/07/2022.
//

import UIKit

class HealthWalletVC: UIViewController {
    
    
    let scrollView = UIScrollView()
    let topView = CustomTopBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = backgroundColorMain
        setupScrollView()
    }
    
    let healthWalletElements = [
        "names" : ["Blood", "Profile", "Vitals", "Symptoms", "Protocols", "Allergies", "Connect +"],
        "images" : ["wallet_blood", "wallet_profile", "wallet_vitals", "wallet_symptoms", "wallet_protocols", "wallet_allergy", "wallet_connect"]
    ]
    
    let walletVCidentifiers: [String] = ["BloodWalletVC", "ProfileWalletVC", "VitalDetailsVC", "SymptomWalletVC", "ProtocolsWalletVC", "AllergyWalletVC", "ImmunizationDetailsVC"]
    
    func setupScrollView() {
        
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        
        
        topView.title = "Wallet"
        topView.height = normalTabBarHeight
        self.view.addSubview(topView)
        
        let settingsButton = UIButton()
        settingsButton.frame = CGRect(x: screenSize.width - 24 - 12, y: topView.frame.height - 24 - 12, width: 24, height: 24)
        settingsButton.setImage(UIImage(named: "settings_button") , for: .normal)
        settingsButton.imageView?.contentMode = .scaleAspectFit
        settingsButton.addTarget(self, action: #selector(settingsButtonPressed(_:)), for: .touchUpInside)
        
        topView.addSubview(settingsButton)
        
        scrollView.frame = CGRect(x: 0, y: topView.frame.height, width: screenSize.width, height: screenSize.height - topView.frame.height)
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        self.view.addSubview(scrollView)
        
        var yPosition: CGFloat = 12
        
        //MARK: Wallet Variables
        let tapBarHeight = self.tabBarController?.tabBar.frame.height ?? 49.0
        let elementHeight: CGFloat = ((screenSize.height - tapBarHeight - (48) - normalTabBarHeight)) / 3
        let elementWidth: CGFloat = (screenSize.width - (12 * 3)) / 2
        
        for (index, name) in (healthWalletElements["names"] ?? []).enumerated() {
            
            let walletElement = UIButton()
            if (index + 1) % 2 == 0 {
                walletElement.frame = CGRect(x: 24 + elementWidth, y: yPosition, width: elementWidth, height: elementHeight)
                
                if (index + 1) != healthWalletElements["names"]?.count {
                    yPosition += walletElement.frame.height + 16
                }
            } else {
                walletElement.frame = CGRect(x: 12, y: yPosition, width: elementWidth, height: elementHeight)
            }
            
            walletElement.addTarget(self, action: #selector(elementButtonPressed(_:)), for: .touchUpInside)
            walletElement.backgroundColor = .white
            walletElement.layer.cornerRadius = 10
            walletElement.tag = index
            scrollView.addSubview(walletElement)
            
            let walletElementImage = UIImageView()
            let walletImageWH: CGFloat = elementHeight / 4
            // let margin: CGFloat = 14
            walletElementImage.image = UIImage(named: healthWalletElements["images"]![index])
//                .withInset(UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin))
            walletElementImage.contentMode = .scaleAspectFit
            walletElementImage.frame = CGRect(x: (elementWidth - walletImageWH) / 2, y: ((elementHeight - walletImageWH) / 2) - 24, width: walletImageWH, height: walletImageWH)
            walletElement.addSubview(walletElementImage)
            
            let elementTitle = UILabel()
            elementTitle.frame = CGRect(x: 0, y: walletElement.frame.height - 17 - 12, width: walletElement.frame.width, height: 17)
            elementTitle.font = .header2()
            elementTitle.text = name
            elementTitle.textAlignment = .center
            elementTitle.textColor = .black
            walletElement.addSubview(elementTitle)
            
            if index == (healthWalletElements["names"]!.count - 1){
                walletElement.backgroundColor = mainColor
                elementTitle.textColor = .white
            }
            
        }
        
        scrollView.contentSize = CGSize(width: screenSize.width, height: yPosition + elementHeight + 12)
        
    }
    
    @IBAction func settingsButtonPressed(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let settingsVC = storyboard.instantiateViewController(identifier: "SettingsVC")
        settingsVC.modalPresentationStyle = .fullScreen //or .overFullScreen for transparency
        self.present(settingsVC, animated: true, completion: nil)
    }
    
    @IBAction func elementButtonPressed(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: walletVCidentifiers[sender.tag])
        present(vc, animated: true, completion: nil)
    }

}
