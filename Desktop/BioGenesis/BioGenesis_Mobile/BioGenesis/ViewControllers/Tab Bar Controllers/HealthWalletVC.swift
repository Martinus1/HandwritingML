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

        view.backgroundColor = #colorLiteral(red: 0.955485642, green: 0.9675140977, blue: 0.9673025012, alpha: 1)
        setupScrollView()
    }
    
    let healthWalletElements = [
        "names" : ["Blood", "Profile", "Symptoms", "Therapeutic Protocols", "Allergies"],
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
            walletElement.frame = CGRect(x: 12, y: yPosition, width: screenSize.width - 24, height: 70)
            walletElement.addTarget(self, action: #selector(elementButtonPressed(_:)), for: .touchUpInside)
            walletElement.backgroundColor = .white
            walletElement.layer.cornerRadius = 10
            walletElement.tag = index
            
            scrollView.addSubview(walletElement)
            
            yPosition += walletElement.frame.height + 16
            
            let elementTitle = UILabel()
            elementTitle.frame = CGRect(x: 16, y: 16, width: walletElement.frame.width , height: 17)
            elementTitle.font = .header2()
            elementTitle.text = name
            elementTitle.textColor = .black
            
            walletElement.addSubview(elementTitle)
            
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
            let vc = storyboard.instantiateViewController(identifier: "BloodWalletVC")
            present(vc, animated: true, completion: nil)
        case 1:
            //MARK: Profile
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(identifier: "ProfileWalletVC")
            present(vc, animated: true, completion: nil)
        case 2:
            //MARK: Symptoms
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(identifier: "SymptomWalletVC")
            present(vc, animated: true, completion: nil)
        case 3:
            //MARK: Protocols
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(identifier: "ProtocolsWalletVC")
            present(vc, animated: true, completion: nil)
        case 4:
            //MARK: Allergy
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(identifier: "AllergyWalletVC")
            present(vc, animated: true, completion: nil)
        case 5:
            //MARK: Immunization
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(identifier: "ImmunizationDetailsVC")
            present(vc, animated: true, completion: nil)
        default:
            break
        }
    }

}
