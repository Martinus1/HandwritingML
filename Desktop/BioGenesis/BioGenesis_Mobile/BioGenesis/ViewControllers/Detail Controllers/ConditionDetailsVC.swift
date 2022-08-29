//
//  ConditionDetailsVC.swift
//  BioGenesis
//
//  Created by Martin on 21/08/2022.
//

import UIKit

class ConditionDetailsVC: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = #colorLiteral(red: 0.955485642, green: 0.9675140977, blue: 0.9673025012, alpha: 1)
        scrollView.backgroundColor = #colorLiteral(red: 0.955485642, green: 0.9675140977, blue: 0.9673025012, alpha: 1)
        setupScrollView()
    }
    
    func setupScrollView() {
    
        var yPosition: CGFloat = 30
        
        //MARK: Condition Name
        
        let conditionName = UILabel()
        conditionName.frame = CGRect(x: 12, y: yPosition, width: screenSize.width, height: 40)
        conditionName.textAlignment = .left
        conditionName.text = "Hyperprolactinemia"
        conditionName.font = .header1()
        scrollView.addSubview(conditionName)
        
        yPosition += conditionName.frame.height + 8
        
        //MARK: Patient Condition Risk
        
        let conditionRisk = UILabel()
        conditionRisk.frame = CGRect(x: 12, y: yPosition, width: screenSize.width, height: 20)
        conditionRisk.textAlignment = .left
        conditionRisk.text = "You are at high risk of this condition"
        conditionRisk.font = .paragraph4()
        scrollView.addSubview(conditionRisk)
        
        yPosition += conditionRisk.frame.height + 12
        
        //MARK: Description
        
        let conditionDescription = UILabel()
        conditionDescription.frame = CGRect(x: 12, y: yPosition, width: screenSize.width, height: 80)
        conditionDescription.textAlignment = .left
        conditionDescription.numberOfLines = 0
        conditionDescription.text = "Hyperprolactinemia means you have higher-than-normal levels of prolactin in your blood. The most common cause is a prolactinoma, a benign (noncancerous) tumor in your pituitary gland. Certain health conditions and medications can also cause hyperprolactinemia"
        conditionDescription.font = .paragraph1()
        scrollView.addSubview(conditionDescription)
        
        yPosition += conditionDescription.frame.height + 12
        
        //MARK: Condition Symptoms
        
        let symptomsTitle = UILabel()
        symptomsTitle.frame = CGRect(x: 12, y: yPosition, width: screenSize.width, height: 20)
        symptomsTitle.textAlignment = .left
        symptomsTitle.text = "Symptoms"
        symptomsTitle.font = .header3()
        scrollView.addSubview(symptomsTitle)
        
        yPosition += symptomsTitle.frame.height + 12
        
        
        //MARK: Condition Biomarkers
        
        let biomarkersTitle = UILabel()
        biomarkersTitle.frame = CGRect(x: 12, y: yPosition, width: screenSize.width, height: 20)
        biomarkersTitle.textAlignment = .left
        biomarkersTitle.text = "Biomarkers"
        biomarkersTitle.font = .header3()
        scrollView.addSubview(biomarkersTitle)
        
        yPosition += biomarkersTitle.frame.height + 12
        
        
        //MARK: Condition Risk Factors
        
        let riskFactorsTitle = UILabel()
        riskFactorsTitle.frame = CGRect(x: 12, y: yPosition, width: screenSize.width, height: 20)
        riskFactorsTitle.textAlignment = .left
        riskFactorsTitle.text = "Risk Factors"
        riskFactorsTitle.font = .header3()
        scrollView.addSubview(riskFactorsTitle)
        
        yPosition += riskFactorsTitle.frame.height + 12
        
        //MARK: Condition Diagnosis Confirmation
    
        
        scrollView.contentSize = CGSize(width: screenSize.width, height: yPosition + 90)
    }

}
