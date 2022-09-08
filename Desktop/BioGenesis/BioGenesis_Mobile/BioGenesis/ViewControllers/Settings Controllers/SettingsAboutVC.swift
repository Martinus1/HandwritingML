//
//  SettingsAboutVC.swift
//  BioGenesis
//
//  Created by Martin on 07/09/2022.
//

import UIKit

class SettingsAboutVC: UIViewController {
    
    let scrollView = UIScrollView()
    
    let aboutTitles = ["Third-party software", "Terms & Conditions", "Privacy Policy"]

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = backgroundColorMain
        // Do any additional setup after loading the view.
        setupBaseElements()
        setupScrollView()
    }
    
    func setupBaseElements() {
        
        let topView = CustomTopBar()
        topView.title = "About"
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
        
        //MARK: Variables
        let elementHeight: CGFloat = 45
        var yPosition: CGFloat = 12
        
        let versionLabel = UILabel()
        versionLabel.frame = CGRect(x: 0, y: yPosition, width: screenSize.width, height: elementHeight)
        versionLabel.textColor = .black
        versionLabel.textAlignment = .center
        versionLabel.font = .paragraph1()
        versionLabel.text = "Version 0.1"
        scrollView.addSubview(versionLabel)
        
        yPosition += elementHeight
        
        for (index, buttonTitle) in aboutTitles.enumerated() {
            let button = UIButton()
            button.frame = CGRect(x: 0, y: yPosition, width: screenSize.width, height: elementHeight)
            button.tag = index
            button.addTarget(self, action: #selector(aboutButtonPressed(_:)), for: .touchUpInside)
            scrollView.addSubview(button)
            
            let buttonLabel = UILabel()
            buttonLabel.frame = CGRect(x: 0, y: 0, width: screenSize.width, height: elementHeight)
            buttonLabel.textColor = .black
            buttonLabel.textAlignment = .center
            buttonLabel.font = .paragraph1()
            buttonLabel.text = buttonTitle
            button.addSubview(buttonLabel)
            
            yPosition += elementHeight
        }
        
        scrollView.contentSize = CGSize(width: screenSize.width, height: yPosition + 12)
    }
    
    @IBAction func aboutButtonPressed(_ sender: UIButton) {
        
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        switch sender.tag {
//        case 0:
//            //MARK: Blood
//        }
    }
    
    @IBAction func backBtnPressed(_ sender: UIButton) {
        dismiss(animated: true)
    }
}
