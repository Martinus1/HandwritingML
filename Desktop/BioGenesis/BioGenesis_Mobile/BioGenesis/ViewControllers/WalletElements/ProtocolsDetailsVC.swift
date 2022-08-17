//
//  ProtocolsDetailsVC.swift
//  BioGenesis
//
//  Created by Martin on 17/07/2022.
//

import UIKit

class ProtocolsDetailsVC: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupScrollView()
    }

    func setupScrollView() {
        var yPosition: CGFloat = 60
        
        let profileValues = [
                "titles": ["Headache", "Constipation"," Fatigue", "Fever"],
                "frequencies": ["3x in the last week", "2x last month", "yesterday", "last year"]
        ]
        
        for (index, title) in profileValues["titles"]!.enumerated() {
            
            addSymptomBox(yPosition: yPosition, title: title, frequency: profileValues["frequencies"]![index])
            yPosition += 100
        }
        
        scrollView.contentSize = CGSize(width: screenSize.width, height: yPosition + 90)
    }
    
    func addSymptomBox(yPosition: CGFloat, title: String, frequency: String) {
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
        
        //MARK: Frequency
        let frequencyLabel = UILabel()
        frequencyLabel.frame = CGRect(x: 24, y: 32, width: screenSize.width - (48), height: 14)
        frequencyLabel.text = frequency
        frequencyLabel.font = UIFont(name: "Avenir-Thin", size: 9)
        
        detailsBox.addSubview(frequencyLabel)
        
    }
}
