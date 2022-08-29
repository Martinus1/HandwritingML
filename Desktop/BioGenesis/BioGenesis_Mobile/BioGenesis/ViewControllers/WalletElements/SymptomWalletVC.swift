//
//  SymptomDetailsVC.swift
//  BioGenesis
//
//  Created by Martin on 17/07/2022.
//

import UIKit

class SymptomWalletVC: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = #colorLiteral(red: 0.955485642, green: 0.9675140977, blue: 0.9673025012, alpha: 1)
        scrollView.backgroundColor = #colorLiteral(red: 0.955485642, green: 0.9675140977, blue: 0.9673025012, alpha: 1)
        
        setupScrollView()
    }

    func setupScrollView() {
        
        var yPosition: CGFloat = 30
        
        let pageTitleLabel = UILabel()
        pageTitleLabel.frame = CGRect(x: 0, y: yPosition, width: screenSize.width, height: 40)
        pageTitleLabel.textAlignment = .center
        pageTitleLabel.text = "Symptoms"
        pageTitleLabel.font = .header1()
        scrollView.addSubview(pageTitleLabel)
        
        yPosition += 40 + 24
        
        let profileValues = [
                "titles": ["Headache", "Constipation","Fatigue", "Fever"],
                "frequencies": ["3x in the last week", "2x last month", "yesterday", "last year"]
        ]
        
        for (index, title) in profileValues["titles"]!.enumerated() {
            
            addSymptomBox(yPosition: yPosition, title: title, frequency: profileValues["frequencies"]![index])
            yPosition += 60 + 12
            
        }
        
        scrollView.contentSize = CGSize(width: screenSize.width, height: yPosition + 90)
    }
    
    func addSymptomBox(yPosition: CGFloat, title: String, frequency: String) {
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
        titleLabel.frame = CGRect(x: 24, y: 12, width: screenSize.width - (48), height: 20)
        titleLabel.text = title
        titleLabel.font = .header2()
        
        detailsBox.addSubview(titleLabel)
        
        //MARK: Frequency
        let frequencyLabel = UILabel()
        frequencyLabel.frame = CGRect(x: 24, y: 32, width: screenSize.width - (48), height: 20)
        frequencyLabel.text = frequency
        frequencyLabel.font = .paragraph2()
        
        detailsBox.addSubview(frequencyLabel)
        
    }
}
