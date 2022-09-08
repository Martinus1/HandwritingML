//
//  ProfileDetailsVC.swift
//  BioGenesis
//
//  Created by Martin on 17/07/2022.
//

import UIKit

class ProfileWalletVC: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = backgroundColorMain
        scrollView.backgroundColor = backgroundColorMain
        
        setupScrollView()
    }
    
    func setupScrollView() {
        
        var yPosition: CGFloat = 30
        
        let topView = CustomTopBar()
        topView.title = "Profile"
        topView.height = normalTabBarHeight
        self.view.addSubview(topView)
        
        yPosition += 40 + 24
        
        let profileValues = [
                "titles": ["Age", "Sex"," Weight", "Height", "BMI", "Ethnicity", "Birth Place"],
                "valueTexts": ["32", "Male", "176lbs", "5′10", "22.3", "Caucasian/White", "United States"]
        ]
        
        for (index, title) in profileValues["titles"]!.enumerated() {
            
            addProfileBox(yPosition: yPosition, title: title, valueText: profileValues["valueTexts"]![index])
            yPosition += 60 + 12
        }
        
        scrollView.contentSize = CGSize(width: screenSize.width, height: yPosition + 90)

    }
    
    func addProfileBox(yPosition: CGFloat, title: String, valueText: String) {
        
        let sideSpacing: CGFloat = 12
        let boxHeight: CGFloat = 60
        
        //MARK: Back Box
        let detailsBox = UIButton()
        detailsBox.backgroundColor = .white
        detailsBox.layer.cornerRadius = 10
        detailsBox.frame = CGRect(x: sideSpacing, y: yPosition, width: screenSize.width - (sideSpacing * 1.5), height: boxHeight)
        
        scrollView.addSubview(detailsBox)
        
        //MARK: Title
        let titleLabel = UILabel()
        titleLabel.frame = CGRect(x: 24, y: boxHeight / 2 - (20 / 2), width: detailsBox.frame.width - (48), height: 20)
        titleLabel.text = title
        titleLabel.textColor = .black
        titleLabel.font = .header2()
        
        detailsBox.addSubview(titleLabel)
        
        //MARK: Value
        let valueLabel = UILabel()
        valueLabel.frame = CGRect(x: 24, y: boxHeight / 2 - (20 / 2), width: detailsBox.frame.width - (48), height: 20)
        valueLabel.textAlignment = .right
        valueLabel.text = valueText
        valueLabel.textColor = .black
        valueLabel.font = .paragraph1()
        
        detailsBox.addSubview(valueLabel)
    }
    
}
