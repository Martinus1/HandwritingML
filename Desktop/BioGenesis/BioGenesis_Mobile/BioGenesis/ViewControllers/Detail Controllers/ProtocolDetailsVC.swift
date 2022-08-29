//
//  ProtocolDetailsVC.swift
//  BioGenesis
//
//  Created by Martin on 21/08/2022.
//

import UIKit

class ProtocolDetailsVC: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = #colorLiteral(red: 0.9568627451, green: 0.968627451, blue: 0.968627451, alpha: 1)
        scrollView.backgroundColor = #colorLiteral(red: 0.955485642, green: 0.9675140977, blue: 0.9673025012, alpha: 1)
        
        setupScrollView()
    }
    
    func setupScrollView() {
    
        var yPosition: CGFloat = 30
        
        //MARK: Protocol Name
        
        let protocolName = UILabel()
        protocolName.frame = CGRect(x: 12, y: yPosition, width: screenSize.width - 24, height: 40)
        protocolName.textAlignment = .left
        protocolName.text = "Acetaminophen"
        protocolName.font = .header1()
        scrollView.addSubview(protocolName)
        
        yPosition += protocolName.frame.height + 8
        
        //MARK: Protocol Type
        
        let protocolType = UILabel()
        protocolType.frame = CGRect(x: 12, y: yPosition, width: screenSize.width - 24, height: 20)
        protocolType.textAlignment = .left
        protocolType.text = "Small Molecule"
        protocolType.font = .paragraph4()
        scrollView.addSubview(protocolType)
        
        yPosition += protocolType.frame.height + 12
        
        //MARK: Protocol Group
        
        let protocolGroup = UILabel()
        protocolGroup.frame = CGRect(x: 12, y: yPosition, width: screenSize.width - 24, height: 20)
        protocolGroup.textAlignment = .left
        protocolGroup.text = "Approved"
        protocolGroup.font = .paragraph4()
        scrollView.addSubview(protocolGroup)
        
        yPosition += protocolGroup.frame.height + 12
        
        //MARK: Protoocol Description
        
        let protocolDescription = UILabel()
        protocolDescription.frame = CGRect(x: 12, y: yPosition, width: screenSize.width - 24, height: 80)
        protocolDescription.textAlignment = .left
        protocolDescription.numberOfLines = 0
        protocolDescription.text = "Acetaminophen is an analgesic drug used alone or in combination with opioids for pain management, and as an antipyretic agent."
        protocolDescription.font = .paragraph1()
        scrollView.addSubview(protocolDescription)
        
        yPosition += protocolDescription.frame.height + 12
        
        //TODO: Github-Like CALENDAR
        
        //MARK: Distribution Details
        
        let distributionDetailsTitle = UILabel()
        distributionDetailsTitle.frame = CGRect(x: 12, y: yPosition, width: screenSize.width - 24, height: 20)
        distributionDetailsTitle.textAlignment = .left
        distributionDetailsTitle.text = "Distribution"
        distributionDetailsTitle.font = .header3()
        scrollView.addSubview(distributionDetailsTitle)
        
        yPosition += distributionDetailsTitle.frame.height + 12
        
        
        let protocolDistributionParagraph = UILabel()
        protocolDistributionParagraph.frame = CGRect(x: 12, y: yPosition, width: screenSize.width - 24, height: 100)
        protocolDistributionParagraph.textAlignment = .left
        protocolDistributionParagraph.numberOfLines = 0
        protocolDistributionParagraph.text = "Volume of distribution is about 0.9L/kg. 10 to 20% of the drug is bound to red blood cells.11 Acetaminophen appears to be widely distributed throughout most body tissues except in fat."
        protocolDistributionParagraph.font = .paragraph2()
        scrollView.addSubview(protocolDistributionParagraph)
        
        yPosition += protocolDistributionParagraph.frame.height + 12
        
        //MARK: Food Interactions Details
        
        let foodInteractionsTitle = UILabel()
        foodInteractionsTitle.frame = CGRect(x: 12, y: yPosition, width: screenSize.width - 24, height: 20)
        foodInteractionsTitle.textAlignment = .left
        foodInteractionsTitle.text = "Food Interactions"
        foodInteractionsTitle.font = .header3()
        scrollView.addSubview(foodInteractionsTitle)
        
        yPosition += foodInteractionsTitle.frame.height + 12
        
        let foodInteractionsParagraph = UILabel()
        foodInteractionsParagraph.frame = CGRect(x: 12, y: yPosition, width: screenSize.width - 24, height: 80)
        foodInteractionsParagraph.textAlignment = .left
        foodInteractionsParagraph.numberOfLines = 0
        foodInteractionsParagraph.text = "Avoid alcohol. Alcohol may increase the risk of hepatotoxicity. Take with or without food. The absorption is unaffected by food."
        foodInteractionsParagraph.font = .paragraph2()
        scrollView.addSubview(foodInteractionsParagraph)
        
        yPosition += foodInteractionsParagraph.frame.height + 12
        
        
        //MARK: Disclaimer
        
        let disclaimerBox = UIView()
        disclaimerBox.backgroundColor = .white
        disclaimerBox.layer.cornerRadius = 10
        disclaimerBox.frame = CGRect(x: 12, y: yPosition, width: screenSize.width - (12 * 1.5), height: 100)
        scrollView.addSubview(disclaimerBox)
        
        let disclaimerTitle = UILabel()
        disclaimerTitle.frame = CGRect(x: 24, y: 12, width: disclaimerBox.frame.width, height: 20)
        disclaimerTitle.textAlignment = .left
        disclaimerTitle.text = "Medical Disclaimer"
        disclaimerTitle.font = .header3()
        
        disclaimerBox.addSubview(disclaimerTitle)
        
        let disclaimerText = UILabel()
        disclaimerText.frame = CGRect(x: 24, y: 32, width: disclaimerBox.frame.width - 48, height: disclaimerBox.frame.height - 32)
        disclaimerText.textAlignment = .left
        disclaimerText.numberOfLines = 0
        disclaimerText.text = "The material contained within this page is for information purposes only. It is not a substitute for medical advice, diagnosis or treatement."
        disclaimerText.font = .paragraph3()
        
        disclaimerBox.addSubview(disclaimerText)
        
        scrollView.contentSize = CGSize(width: screenSize.width, height: yPosition + 90)
    }
}
