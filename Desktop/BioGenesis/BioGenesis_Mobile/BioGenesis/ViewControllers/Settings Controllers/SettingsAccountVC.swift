//
//  SettingsAccountVC.swift
//  BioGenesis
//
//  Created by Martin on 07/09/2022.
//

import UIKit

class SettingsAccountVC: UIViewController {

    let scrollView = UIScrollView()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = backgroundColorMain
        // Do any additional setup after loading the view.
        setupBaseElements()
        setupScrollView()
    }
    
    func setupBaseElements() {
        
        let topView = CustomTopBar()
        topView.title = "Account"
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
        let elementHeight: CGFloat = 75
        var yPosition: CGFloat = 12
        
        //MARK: Subscription plan
        let planButton = UIButton()
        planButton.frame = CGRect(x: 0, y: yPosition, width: screenSize.width, height: elementHeight)
        planButton.addTarget(self, action: #selector(aboutButtonPressed(_:)), for: .touchUpInside)
        scrollView.addSubview(planButton)
        
        let planImage = UIImageView()
        planImage.frame = CGRect(x: 12, y: 4, width: elementHeight - 8, height: elementHeight - 8)
        planImage.image = UIImage(named: "premium_individual")
        planImage.layer.cornerRadius = 5
        planImage.clipsToBounds = true
        planButton.addSubview(planImage)
        
        let buttonLabel = UILabel()
        buttonLabel.frame = CGRect(x: planImage.frame.maxX + 12, y: 0, width: screenSize.width, height: elementHeight)
        buttonLabel.textColor = .black
        buttonLabel.textAlignment = .left
        buttonLabel.font = .paragraph1()
        buttonLabel.text = "Premium individual"
        planButton.addSubview(buttonLabel)
        
        yPosition += elementHeight
        
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
