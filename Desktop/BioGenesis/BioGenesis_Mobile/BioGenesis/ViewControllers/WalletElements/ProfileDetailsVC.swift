//
//  ProfileDetailsVC.swift
//  BioGenesis
//
//  Created by Martin on 17/07/2022.
//

import UIKit

class ProfileDetailsVC: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupScrollView()
    }
    
    func setupScrollView() {
        var yPosition: CGFloat = 60
        
        let profileValues = [
                "titles": ["Age", "Sex"," Weight", "Height", "BMI", "Ethnicity", "Birth Place"],
                "valueTexts": ["32", "Male", "176lbs", "5′10", "22.3", "Caucasian/White", "United States"]
        ]
        
        for (index, title) in profileValues["titles"]!.enumerated() {
            
            addProfileBox(yPosition: yPosition, title: title, valueText: profileValues["valueTexts"]![index])
            yPosition += 100
        }
        
        scrollView.contentSize = CGSize(width: screenSize.width, height: yPosition + 90)

    }
    
    func addProfileBox(yPosition: CGFloat, title: String, valueText: String) {
        
        let sideSpacing: CGFloat = 12
        let boxHeight: CGFloat = 100
        
        //MARK: Back Box
        let detailsBox = UIButton()
        detailsBox.frame = CGRect(x: sideSpacing, y: yPosition, width: screenSize.width - (sideSpacing * 1.5), height: boxHeight)
        
        scrollView.addSubview(detailsBox)
        
        //MARK: Title
        let titleLabel = UILabel()
        titleLabel.frame = CGRect(x: 24, y: 12, width: screenSize.width - (48), height: 14)
        titleLabel.text = title
        titleLabel.font = UIFont(name: "Mont-Thin", size: 12)
        
        detailsBox.addSubview(titleLabel)
        
        //MARK: Value
        let valueLabel = UILabel()
        valueLabel.frame = CGRect(x: 24, y: 12, width: screenSize.width - (48), height: 14)
        valueLabel.textAlignment = .right
        valueLabel.text = valueText
        valueLabel.font = UIFont(name: "Mont-Thin", size: 12)
        
        detailsBox.addSubview(valueLabel)
    }
    
}
