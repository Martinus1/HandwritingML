//
//  BloodDetailsVC.swift
//  BioGenesis
//
//  Created by Martin on 17/07/2022.
//

import UIKit

class BloodDetailsVC: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupScrollView()
    }
    
    func setupScrollView() {
        
        //MARK: Top View - Search Bar & Back Buttom
        ///NOT ADDED - CARD VIEW
        let backBtn = UIButton()
        backBtn.frame = CGRect(x: 20, y: 50, width: 30, height: 30)
        backBtn.backgroundColor = .black
        backBtn.addTarget(self, action: #selector(backBtnPressed(_:)), for: .touchUpInside)
        
//        scrollView.addSubview(backBtn)
        
        var yPosition: CGFloat = 60
        
        for data in biomarkerValues {
            
            let ranges = data.targetGroupRanges![0].ranges!
            let totalRange: CGFloat = CGFloat((ranges[.upperLimit]! - ranges[.lowerLimit]!))
            let lowest: CGFloat = CGFloat(ranges[.lowerLimit]!) - (totalRange * 0.25)
            let highest: CGFloat = CGFloat(ranges[.upperLimit]!) + (totalRange * 0.25)
            let current: CGFloat = CGFloat.random(in: lowest...highest)
            
            addBloodDetailsBox(yPosition: yPosition, labValueName: data.name, ranges: data.targetGroupRanges![0].ranges!, currentValue: current, units: "nmol/L")
            yPosition += 90
        }
        
        scrollView.contentSize = CGSize(width: screenSize.width, height: yPosition + 90)
        
    }
    

    func addBloodDetailsBox(yPosition: CGFloat, labValueName: String, ranges: [RangeTypes : Float],
                            currentValue: CGFloat, units: String) {
        
        let sideSpacing: CGFloat = 12
        let boxHeight: CGFloat = 100
        
        //-------------
        //MARK: Back Box
        //-------------
        let detailsBox = UIButton()
        detailsBox.frame = CGRect(x: sideSpacing, y: yPosition, width: screenSize.width - (sideSpacing * 1.5), height: boxHeight)
        
        scrollView.addSubview(detailsBox)
        
        //--------------------
        //MARK: Value Details
        //--------------------
        
        //MARK: Lab Value Name
        let labValueNameLabel = UILabel()
        labValueNameLabel.frame = CGRect(x: 24, y: 12, width: screenSize.width - (48), height: 14)
        labValueNameLabel.text =  labValueName
        labValueNameLabel.font = UIFont(name: "Mont-Thin", size: 12)
        
        detailsBox.addSubview(labValueNameLabel)
        
        //MARK: Value Label + Unit
        let currentValueLabel = UILabel()
        currentValueLabel.frame = CGRect(x: 24, y: boxHeight - 12 - 8, width: screenSize.width - (48), height: 12)
        
        var adjustedValue = 0.0
        if (currentValue - floor(currentValue) >= 0.01) {
            adjustedValue = preciseRound(currentValue, precision: .tenths)
        } else {
            adjustedValue = preciseRound(currentValue, precision: .ones)
        }
        currentValueLabel.text =  String(adjustedValue) + units
        currentValueLabel.font = UIFont(name: "Mont-Thin", size: 15)
        
        detailsBox.addSubview(currentValueLabel)
        
        //--------------------
        //MARK: Horizontal Bar
        //--------------------
        
        //MARK: Value Horizontal Bar Skeleton
        let barSideSpacing: CGFloat = 24
        let barHeight: CGFloat = 10
        let barWidth: CGFloat = detailsBox.frame.width - (barSideSpacing * 2)
        let barY: CGFloat = boxHeight - barHeight - 24
        
        let barSkeleton = UIView()
        barSkeleton.backgroundColor = dividerColor
        barSkeleton.frame = CGRect(x: barSideSpacing, y: barY, width: barWidth, height: barHeight)
        barSkeleton.layer.cornerRadius = barHeight / 2
        barSkeleton.clipsToBounds = true
        
        detailsBox.addSubview(barSkeleton)
        
        let normalRange: CGFloat = CGFloat(ranges[.upperLimit]! - ranges[.lowerLimit]!)
        var totalRange: CGFloat = normalRange * 1.5
        
        var lowerMin: CGFloat = CGFloat(ranges[.lowerLimit]!) - (normalRange * 0.25)
        if lowerMin < 0 {
            totalRange -= abs(lowerMin)
            lowerMin = 0
        }
        let lowerMax: CGFloat = CGFloat(ranges[.lowerLimit]!)
        
        let upperMin: CGFloat = CGFloat(ranges[.upperLimit]!)
        let upperMax: CGFloat = CGFloat(ranges[.upperLimit]!) + (normalRange * 0.25)
        //MARK: This indicates how much is 1 point of what we are colculating worth in relation to the width - makes calculation simpler
        let unitValue: CGFloat =  barWidth / totalRange
        
        //MARK: Value Horizontal Bar - LOW
        let lowBox = UIView()
        let lowBoxX: CGFloat = 0
        let lowBoxWidth: CGFloat = (unitValue * (lowerMax - lowerMin))
        lowBox.frame = CGRect(x: lowBoxX, y: 0, width: lowBoxWidth, height: barHeight)
        lowBox.backgroundColor = rangeIndicatorColorBad
        barSkeleton.addSubview(lowBox)
        
//        //MARK: Value Horizontal Bar - BORDERLINE LOW
//        let borderlineLowBox = UIView()
//        let borderlineLowBoxX: CGFloat = unitValue * borderlineLowMin
//        let borderlineLowBoxWidth: CGFloat = (unitValue * borderlineLowMax) - borderlineLowBoxX
//        borderlineLowBox.frame = CGRect(x: borderlineLowBoxX, y: 0, width: borderlineLowBoxWidth, height: barHeight)
//        borderlineLowBox.backgroundColor = rangeIndicatorColorBorderline
//        barSkeleton.addSubview(borderlineLowBox)
        
        //MARK: Value Horizontal Bar - OPTIMAL
        let optimalBox = UIView()
        let optimalBoxX: CGFloat = unitValue * (lowerMax - lowerMin)
        let optimalBoxWidth: CGFloat = (unitValue * (upperMin - lowerMin)) - optimalBoxX
        optimalBox.frame = CGRect(x: optimalBoxX, y: 0, width: optimalBoxWidth, height: barHeight)
        optimalBox.backgroundColor = rangeIndicatorColorOptimal
        barSkeleton.addSubview(optimalBox)
        
//        //MARK: Value Horizontal Bar - BORDERLINE HIGH
//        let borderlineHighBox = UIView()
//        let borderlineHighBoxX: CGFloat = unitValue * borderlineHighMin
//        let borderlineHighBoxWidth: CGFloat = (unitValue * borderlineHighMax) - borderlineHighBoxX
//        borderlineHighBox.frame = CGRect(x: borderlineHighBoxX, y: 0, width: borderlineHighBoxWidth, height: barHeight)
//        borderlineHighBox.backgroundColor = rangeIndicatorColorBorderline
//        barSkeleton.addSubview(borderlineHighBox)
        
        //MARK: Value Horizontal Bar -  HIGH
        let highBox = UIView()
        let highBoxX: CGFloat = unitValue * (upperMin - lowerMin)
        let highBoxWidth: CGFloat = (unitValue * (upperMax - lowerMin)) - highBoxX
        highBox.frame = CGRect(x: highBoxX, y: 0, width: highBoxWidth, height: barHeight)
        highBox.backgroundColor = rangeIndicatorColorBad
        barSkeleton.addSubview(highBox)
        
        //MARK: Current Value Indicator
        let currentValueIndicator = UIView()
        let currentValueWidth: CGFloat = 4
        let currentValueX: CGFloat = barSideSpacing + (unitValue * (currentValue - lowerMin) - (currentValueWidth / 2))
        let currentValueY: CGFloat = (barY - 4)
        currentValueIndicator.frame = CGRect(x: currentValueX, y: currentValueY, width: currentValueWidth, height: (barHeight + 8))
        currentValueIndicator.backgroundColor = .black
        detailsBox.addSubview(currentValueIndicator)
        
        bloodRangesTest(biomarkerName: labValueName, totalRange: totalRange, lowerMin: lowerMin, lowerMax: lowerMax, upperMin: upperMin, upperMax: upperMax)
    }
    
    func bloodRangesTest(biomarkerName: String, totalRange: CGFloat,
                        lowerMin: CGFloat, lowerMax: CGFloat,
                        upperMin: CGFloat, upperMax: CGFloat) {
        
        print("TEST FOR RANGES OF: " + biomarkerName)
        print("TOTAL RANGE: \(totalRange)")
        print(lowerMin)
        print("|")
        print(lowerMax)
        print("|")
        print(upperMin)
        print("|")
        print(upperMax)
        print("\n")
        
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
        dismiss(animated: true)
    }
    
}
