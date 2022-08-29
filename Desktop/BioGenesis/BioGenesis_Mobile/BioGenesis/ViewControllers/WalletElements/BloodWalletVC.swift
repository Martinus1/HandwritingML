//
//  BloodDetailsVC.swift
//  BioGenesis
//
//  Created by Martin on 17/07/2022.
//

import UIKit

class BloodWalletVC: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = #colorLiteral(red: 0.955485642, green: 0.9675140977, blue: 0.9673025012, alpha: 1)
        scrollView.backgroundColor = #colorLiteral(red: 0.955485642, green: 0.9675140977, blue: 0.9673025012, alpha: 1)
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
        
        var yPosition: CGFloat = 30
        
        let pageTitleLabel = UILabel()
        pageTitleLabel.frame = CGRect(x: 0, y: yPosition, width: screenSize.width, height: 40)
        pageTitleLabel.textAlignment = .center
        pageTitleLabel.text = "Bloodwork"
        pageTitleLabel.font = .header1()
        scrollView.addSubview(pageTitleLabel)
        
        yPosition += 40 + 24
        
        for data in biomarkerValues {
            
            let ranges = data.targetGroupRanges![0].ranges!
            let totalRange: CGFloat = CGFloat((ranges[.upperLimit]! - ranges[.lowerLimit]!))
            let lowest: CGFloat = CGFloat(ranges[.lowerLimit]!) - (totalRange * 0.25)
            let highest: CGFloat = CGFloat(ranges[.upperLimit]!) + (totalRange * 0.25)
            let current: CGFloat = CGFloat.random(in: lowest...highest)
            
            addBloodDetailsBox(yPosition: yPosition, labValueName: data.name, ranges: data.targetGroupRanges![0].ranges!, currentValue: current, units: "nmol/L")
            yPosition += 150 + 12
        }
        
        scrollView.contentSize = CGSize(width: screenSize.width, height: yPosition + 90)
        
    }
    

    func addBloodDetailsBox(yPosition: CGFloat, labValueName: String, ranges: [RangeTypes : Float],
                            currentValue: CGFloat, units: String) {
        
        //-------------
        //MARK: Variables
        //-------------
        let sideSpacing: CGFloat = 12
        let boxHeight: CGFloat = 150
        
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
        
        
        //-------------
        //MARK: Back Box
        //-------------
        let detailsBox = UIButton()
        detailsBox.backgroundColor = .white
        detailsBox.layer.cornerRadius = 10
        detailsBox.frame = CGRect(x: sideSpacing, y: yPosition, width: screenSize.width - (sideSpacing * 1.5), height: boxHeight)
        
        scrollView.addSubview(detailsBox)
        
        //--------------------
        //MARK: Value Details
        //--------------------
        
        //MARK: Lab Value Name
        let labValueNameLabel = UILabel()
        labValueNameLabel.frame = CGRect(x: 24, y: 24, width: screenSize.width - (48), height: 18)
        labValueNameLabel.text =  labValueName
        labValueNameLabel.font = .header3()
        
        detailsBox.addSubview(labValueNameLabel)
        
        //MARK: Value Label + Unit
        let currentValueLabel = UILabel()
        currentValueLabel.frame = CGRect(x: 24, y: labValueNameLabel.frame.maxY + 8, width: screenSize.width - (48), height: 20)
        
        var adjustedValue = 0.0
        if (currentValue - floor(currentValue) >= 0.01) {
            adjustedValue = preciseRound(currentValue, precision: .tenths)
        } else {
            adjustedValue = preciseRound(currentValue, precision: .ones)
        }
        currentValueLabel.text =  String(adjustedValue) + units
        currentValueLabel.font = .paragraph3()
        
        detailsBox.addSubview(currentValueLabel)
        
        //MARK: Value Risk Indicator
        let riskIndicatorBox = UIView()
        riskIndicatorBox.frame = CGRect(x: detailsBox.frame.width - 80 - 12, y: 24, width: 80, height: 18)
        riskIndicatorBox.layer.cornerRadius = riskIndicatorBox.frame.height / 2
        detailsBox.addSubview(riskIndicatorBox)
        
        let riskIndicatorLabel = UILabel()
        riskIndicatorLabel.frame = CGRect(x: 0, y: 0, width: 80, height: 18)
        riskIndicatorLabel.textAlignment = .center
        riskIndicatorLabel.textColor = .white
        riskIndicatorLabel.font = .paragraph4()
        riskIndicatorBox.addSubview(riskIndicatorLabel)
        
        if currentValue <= lowerMax {
            riskIndicatorBox.backgroundColor = rangeIndicatorColorBad
            riskIndicatorLabel.text = "Low"
        } else if currentValue > upperMin {
            riskIndicatorBox.backgroundColor = rangeIndicatorColorBad
            riskIndicatorLabel.text = "High"
        } else {
            riskIndicatorBox.backgroundColor = rangeIndicatorColorOptimal
            riskIndicatorLabel.text = "Optimal"
        }
        
        //--------------------
        //MARK: Horizontal Bar
        //--------------------
        
        //MARK: Value Horizontal Bar Skeleton
        let barSideSpacing: CGFloat = 24
        let barHeight: CGFloat = 10
        let barWidth: CGFloat = detailsBox.frame.width - (barSideSpacing * 2)
        let barY: CGFloat = boxHeight - barHeight - 48
        
        //MARK: This indicates how much is 1 point of what we are colculating worth in relation to the width - makes calculation simpler
        let unitValue: CGFloat =  barWidth / totalRange
        
        let barSkeleton = UIView()
        barSkeleton.backgroundColor = dividerColor
        barSkeleton.frame = CGRect(x: barSideSpacing, y: barY, width: barWidth, height: barHeight)
        barSkeleton.layer.cornerRadius = barHeight / 2
        barSkeleton.clipsToBounds = true
        
        detailsBox.addSubview(barSkeleton)
        
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
        currentValueIndicator.layer.cornerRadius = currentValueIndicator.frame.width / 2
        currentValueIndicator.backgroundColor = .black
        detailsBox.addSubview(currentValueIndicator)
        
        
        //MARK: Value range titles
        
        var adjustedValueOptimal = 0.0
        if (lowerMax - floor(lowerMax) >= 0.01) {
            adjustedValueOptimal = preciseRound(lowerMax, precision: .tenths)
        } else {
            adjustedValueOptimal = preciseRound(lowerMax, precision: .ones)
        }
        
        var adjustedValueHigh = 0.0
        if (upperMin - floor(upperMin) >= 0.01) {
            adjustedValueHigh = preciseRound(upperMin, precision: .tenths)
        } else {
            adjustedValueHigh = preciseRound(upperMin, precision: .ones)
        }
        
        let opitmalValueTitle = UILabel()
        opitmalValueTitle.frame = CGRect(x: 50, y: barSkeleton.frame.maxY + 12, width: 60, height: 14)
        opitmalValueTitle.textAlignment = .center
        opitmalValueTitle.text =  "Optimized"
        opitmalValueTitle.font = .paragraph3()
        
        let optimalValue = UILabel()
        optimalValue.frame = CGRect(x: 50, y: opitmalValueTitle.frame.maxY, width: 60, height: 14)
        optimalValue.textAlignment = .center
        optimalValue.text = String(adjustedValueOptimal)
        optimalValue.font = .paragraph4()
        
        let highValueTitle = UILabel()
        highValueTitle.frame = CGRect(x: detailsBox.frame.width - 60 - 50, y: barSkeleton.frame.maxY + 12, width: 60, height: 14)
        highValueTitle.textAlignment = .center
        highValueTitle.text =  "High"
        highValueTitle.font = .paragraph3()
        
        let highValue = UILabel()
        highValue.frame = CGRect(x: detailsBox.frame.width - 60 - 50, y: highValueTitle.frame.maxY, width: 60, height: 14)
        highValue.textAlignment = .center
        highValue.text = String(adjustedValueHigh)
        highValue.font = .paragraph4()
        
        detailsBox.addSubview(opitmalValueTitle)
        detailsBox.addSubview(optimalValue)
        detailsBox.addSubview(highValueTitle)
        detailsBox.addSubview(highValue)
        
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
