//
//  Global.swift
//  BioGenesis
//
//  Created by Martin on 12/07/2022.
//

import UIKit

//MARK: Color Palette
let mainColor = #colorLiteral(red: 0.3607843137, green: 0.5725490196, blue: 0.9921568627, alpha: 1)
let colorPalette = [ #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1), #colorLiteral(red: 0.4756349325, green: 0.4756467342, blue: 0.4756404161, alpha: 1), #colorLiteral(red: 0.1298420429, green: 0.1298461258, blue: 0.1298439503, alpha: 1)]
let dividerColor = #colorLiteral(red: 0.9411764706, green: 0.9411764706, blue: 0.9411764706, alpha: 1)

let backgroundColorMain = #colorLiteral(red: 0.9607843137, green: 0.9607843137, blue: 0.9607843137, alpha: 1)

let grayTextColor = #colorLiteral(red: 0.7568627451, green: 0.7921568627, blue: 0.8117647059, alpha: 1)

let bioGenesisDark = #colorLiteral(red: 0.1921568627, green: 0.1607843137, blue: 0.2156862745, alpha: 1)


//HEX: #7AEDB6
let rangeIndicatorColorOptimal = #colorLiteral(red: 0.4784313725, green: 0.9294117647, blue: 0.7137254902, alpha: 1)
//HEX: #FEF17A
let rangeIndicatorColorBorderline = #colorLiteral(red: 0.9960784314, green: 0.9450980392, blue: 0.4784313725, alpha: 1)
//HEX: #F04060
let rangeIndicatorColorBad = #colorLiteral(red: 0.9411764706, green: 0.2509803922, blue: 0.3764705882, alpha: 1)

//MARK: Elements Sizing
let dividerHeight: CGFloat = 10

//MARK: Corner Radius Box
let cornerRadius: CGFloat = 10

//MARK: General Global Varibales
let screenSize: CGRect = UIScreen.main.bounds

//MARK: Calendar Global Variable
let daysInWeek: [String] = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]


//MARK: Global Button Values
let backBtnWH: CGFloat = 55


func arrayOfDates() -> NSArray {
    
    let numberOfDays: Int = 50
    let startDate = Date()
    let formatter: DateFormatter = DateFormatter()
    formatter.dateFormat = "EEE, MMM d"
    let calendar = Calendar.current
    var offset = DateComponents()
//        var dates: [Any] = [formatter.string(from: startDate)]
    var dates: [Any] = ["Today"]
    
    for i in 1..<numberOfDays {
        offset.day = -i
        let nextDay: Date? = calendar.date(byAdding: offset, to: startDate)
        let nextDayString = formatter.string(from: nextDay!)
        dates.append(nextDayString)
    }
    return dates.reversed() as NSArray
}

func arrayOfVolumes(from start: Int, to end: Int) -> [String] {
    
    var rangeArray: [String] = ["0.5"]
    
    for i in start...end {
        rangeArray.append(String(i))
        if i < 3 {
            rangeArray.append(String(Double(i) + 0.5))
        }
    }
    
    return rangeArray
}

func arrayInRange(from start: Int, to end: Int) -> [String] {
    
    var rangeArray: [String] = []
    
    for i in start...end {
        rangeArray.append(String(i))
    }
    
    return rangeArray
}

func pickerViewStringDates() -> [String] {
    
    let numberOfDays: Int = 12
    let startDate = Date()
    let formatter: DateFormatter = DateFormatter()
    formatter.dateFormat = "EEE, MMM d"
    let calendar = Calendar.current
    var offset = DateComponents()
//        var dates: [Any] = [formatter.string(from: startDate)]
    var dates: [String] = ["Today"]
    
    for i in 1..<numberOfDays {
        offset.day = -i
        let nextDay: Date? = calendar.date(byAdding: offset, to: startDate)
        let nextDayString = formatter.string(from: nextDay!)
        dates.append(nextDayString)
    }
    return dates
}


func getThickDivider(yPosition: CGFloat, parentView: UIView) -> UIView {
    
    //MARK: VARIABLES
    let dividerHeight: CGFloat = 12
    let dividerWidth: CGFloat = parentView.frame.width
    
    //MARK: DIVIDER
    let thickDivider = UILabel()
    thickDivider.frame = CGRect(x: 0, y: yPosition, width: dividerWidth, height: dividerHeight)
    thickDivider.backgroundColor = #colorLiteral(red: 0.9058823529, green: 0.9058823529, blue: 0.9058823529, alpha: 1)
    
    return thickDivider
}

func getThinDivider(yPosition: CGFloat, parentView: UIView) -> UIView {
    
    //MARK: VARIABLES
    let dividerHeight: CGFloat = 1
    let dividerWidth: CGFloat = parentView.frame.width
    
    //MARK: DIVIDER
    let thinDivider = UILabel()
    thinDivider.frame = CGRect(x: 0, y: yPosition, width: dividerWidth, height: dividerHeight)
    thinDivider.backgroundColor = #colorLiteral(red: 0.9058823529, green: 0.9058823529, blue: 0.9058823529, alpha: 1)
    
    return thinDivider
}

