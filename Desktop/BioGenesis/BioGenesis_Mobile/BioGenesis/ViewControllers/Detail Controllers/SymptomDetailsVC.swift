//
//  SymptomDetailsVC.swift
//  BioGenesis
//
//  Created by Martin on 06/09/2022.
//

import UIKit

class SymptomDetailsVC: UIViewController {
    
    var scrollView = UIScrollView()
    let topView = UIView()

    let biomarkerName : String = "Headache"
    
    let currentSymptoms = ["Vitamin D", "Advill", "Vitamin B12"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = backgroundColorMain
        scrollView.backgroundColor = backgroundColorMain
        
        setupBaseElements()
        setupScrollView()
    
    }
    
    func setupBaseElements() {
        
        let tapBarHeight = self.tabBarController?.tabBar.frame.height ?? 49.0
        
        topView.frame = CGRect(x: 0, y: 0, width: screenSize.width, height: 150)
        topView.backgroundColor = backgroundColorMain
        self.view.addSubview(topView)
        
        let segmentedControl = CustomSegmentedController(items: ["Day", "Week", "Month"])
        segmentedControl.frame = CGRect(x: 12, y: topView.frame.height - 30 - 12, width: screenSize.width - 24, height: 30)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(self.segmentedValueChanged(_:)), for: .valueChanged)
        
        topView.addSubview(segmentedControl)
        
        
        let titleLabel = UILabel()
        titleLabel.frame = CGRect(x: 0, y: 36, width: screenSize.width, height: 30)
        titleLabel.text = biomarkerName
        titleLabel.textColor = .black
        titleLabel.textAlignment = .center
        titleLabel.font = .header1()
        self.view.addSubview(titleLabel)
        
        var yPosition: CGFloat = topView.frame.height
        
        scrollView.frame = CGRect(x: 0, y: yPosition, width: screenSize.width, height: screenSize.height - yPosition - tapBarHeight)
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        view.addSubview(scrollView)
            
    }
    
    func setupGraphView(yPostion: CGFloat, height: CGFloat) {

    }
    
    func setupScrollView() {
        
        var yPosition: CGFloat = 12
        
        setupGraphView(yPostion: yPosition, height: 200)
        yPosition += 200 + 12
        
        let thickDivider = getThickDivider(yPosition: yPosition, parentView: self.view)
        scrollView.addSubview(thickDivider)
        yPosition += thickDivider.frame.height + 12
        
        let symptomsTitle = UILabel()
        symptomsTitle.frame = CGRect(x: 12, y: yPosition, width: screenSize.width, height: 30)
        symptomsTitle.text = "Symptoms"
        symptomsTitle.textColor = .black
        symptomsTitle.textAlignment = .left
        symptomsTitle.font = .header2()
        scrollView.addSubview(symptomsTitle)
        
        yPosition += symptomsTitle.frame.height + 4
        
        for currentSymptom in currentSymptoms {
            addSymptomsBox(yPosition: yPosition, height: 45, symptomName: currentSymptom)
            yPosition += 45 + 12
        }
        
        scrollView.contentSize = CGSize(width: screenSize.width, height: yPosition + 60)
    }

    func addSymptomsBox(yPosition: CGFloat, height: CGFloat, symptomName: String) {
        let symptomBox = UIView()
        symptomBox.backgroundColor = .white
        symptomBox.frame = CGRect(x: 12, y: yPosition, width: screenSize.width - 24, height: height)
        symptomBox.layer.cornerRadius = 10
        scrollView.addSubview(symptomBox)
        
        let symptomNameLabel = UILabel()
        symptomNameLabel.frame = CGRect(x: 12, y: 4, width: symptomBox.frame.width - 50, height: symptomBox.frame.height - 8)
        symptomNameLabel.text = symptomName
        symptomNameLabel.font = .paragraph2()
        symptomBox.addSubview(symptomNameLabel)
    }
    
    @objc func segmentedValueChanged(_ sender:UISegmentedControl!)
    {
        print("Selected Segment Index is : \(sender.selectedSegmentIndex)")
    }
}
