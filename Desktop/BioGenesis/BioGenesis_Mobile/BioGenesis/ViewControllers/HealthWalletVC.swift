//
//  HealthWalletVC.swift
//  BioGenesis
//
//  Created by Martin on 17/07/2022.
//

import UIKit

class HealthWalletVC: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupScrollView()
    }
    
    let healthWalletElements = [
        "names" : ["Blood", "Profile", "Body", "Symptoms", "Protocols", "Immunizations", "Allergies"],
        "images" : []
    ]
    
    func setupScrollView() {
        
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        
        //TODO: remove + 40 after adding topbar
        var yPosition: CGFloat = 64 + 40
        
        let settingsButton = UIButton()
        settingsButton.frame = CGRect(x: screenSize.width - 80, y: 30, width: 40, height: 40)
        settingsButton.backgroundColor = .black
        settingsButton.addTarget(self, action: #selector(settingsButtonPressed(_:)), for: .touchUpInside)
        
        scrollView.addSubview(settingsButton)
        
        for (index, name) in (healthWalletElements["names"] ?? []).enumerated() {
            
            let walletElement = UIButton()
            walletElement.frame = CGRect(x: 16, y: yPosition, width: screenSize.width, height: 60)
            walletElement.addTarget(self, action: #selector(elementButtonPressed(_:)), for: .touchUpInside)
            walletElement.tag = index
            
            scrollView.addSubview(walletElement)
            
            yPosition += walletElement.frame.height + 16
            
            let elementTitle = UILabel()
            elementTitle.frame = CGRect(x: 16, y: 16, width: walletElement.frame.width , height: 17)
            elementTitle.font = UIFont(name: "Mont-Thin", size: 14)
            elementTitle.text = name as? String
            elementTitle.textColor = .black
            
            walletElement.addSubview(elementTitle)
            
            let div = UIView()
            div.frame = CGRect(x: 0, y: yPosition, width: screenSize.width, height: dividerHeight)
            div.backgroundColor = dividerColor
            
            scrollView.addSubview(div)
            
            yPosition += dividerHeight + 16
            
        }
        
        scrollView.contentSize = CGSize(width: screenSize.width, height: yPosition + 100)
        
    }
    @IBAction func settingsButtonPressed(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let settingsVC = storyboard.instantiateViewController(identifier: "SettingsVC")
        settingsVC.modalPresentationStyle = .fullScreen //or .overFullScreen for transparency
        self.present(settingsVC, animated: true, completion: nil)
    }
    
    @IBAction func elementButtonPressed(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            //MARK: Blood
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let bloodDetailsVC = storyboard.instantiateViewController(identifier: "BloodDetailsVC")
            present(bloodDetailsVC, animated: true, completion: nil)
        case 1:
            //MARK: Profile
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let profileDetailsVC = storyboard.instantiateViewController(identifier: "ProfileDetailsVC")
            present(profileDetailsVC, animated: true, completion: nil)
        case 2:
            //MARK: Body
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let bodyDetailsVC = storyboard.instantiateViewController(identifier: "BodyDetailsVC")
            present(bodyDetailsVC, animated: true, completion: nil)
        case 3:
            //MARK: Symptoms
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let symptomsDetailsVC = storyboard.instantiateViewController(identifier: "SymptomsDetailsVC")
            present(symptomsDetailsVC, animated: true, completion: nil)
        case 4:
            //MARK: Protocols
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let protocolsDetailsVC = storyboard.instantiateViewController(identifier: "ProtocolsDetailsVC")
            present(protocolsDetailsVC, animated: true, completion: nil)
        case 5:
            //MARK: Immunization
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let geneticDetailsVC = storyboard.instantiateViewController(identifier: "ImmunizationDetailsVC")
            present(geneticDetailsVC, animated: true, completion: nil)
        case 6:
            //MARK: Allergy
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let geneticDetailsVC = storyboard.instantiateViewController(identifier: "AllergyDetailsVC")
            present(geneticDetailsVC, animated: true, completion: nil)
        default:
            break
        }
    }

}
