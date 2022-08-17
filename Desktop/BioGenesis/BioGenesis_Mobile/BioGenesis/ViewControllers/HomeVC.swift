//
//  ViewController.swift
//  BioGenesis
//
//  Created by Martin on 11/07/2022.
//

import UIKit
import JTAppleCalendar

class HomeVC: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    //TopView Elemetns: calendar, primary buttons located on the top of the screen
    @IBOutlet weak var topInformationView: UIView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var weekCalendarView: JTACMonthView!
    
    //MARK: Local Elements
    let dateTopLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        weekCalendarView.scrollingMode = .none
        weekCalendarView.scrollDirection = .horizontal
        
        setupTopView()
        setupScrollView()
        
        weekCalendarView.selectDates([Date()])
        weekCalendarView.scrollToDate(Date()) {}
    }
    
    func setupTopView() {
        
        //MARK: Date Top Label
        dateTopLabel.text = "Thu, Jul 14"
        dateTopLabel.frame = CGRect(x: 0, y: 0, width: topInformationView.frame.width, height: topInformationView.frame.height - 13)
        ///Font setting does not work
        dateTopLabel.font = .header1()
        dateTopLabel.textAlignment = .center
        topInformationView.addSubview(dateTopLabel)
        
        //MARK: Divider
        let topViewLine = UIView()
        topViewLine.frame = CGRect(x: 0, y: topView.frame.height - 1, width: screenSize.width, height: 1)
        topViewLine.backgroundColor = .black
        topView.addSubview(topViewLine)
    }
    
    func setupScrollView() {
        
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        
        //MARK: Variables
        var yPosition: CGFloat = 50
        let spacing: CGFloat = 16
        
        //MARK: Highlights
        
        
        //MARK: Protocols
        setupProtocolsBox(yPositionMain: yPosition)
        
        yPosition += 240 + spacing
        addDivider(yPosition: yPosition)
        yPosition += dividerHeight + spacing
        
        //MARK: Symptoms
        setupSymptomsBox(yPositionMain: yPosition)
        
        
    }
    
    //Returns: yPosition adding Value
    func setupHighlightsBox() {
        let highlightsBox = UIView()
    
    }
    
    //Returns: yPosition
    func setupProtocolsBox(yPositionMain: CGFloat) {
        
        var yPositionProtocols: CGFloat = 12
        
        let protocolsBox = UIView()
        protocolsBox.frame = CGRect(x: 0, y: yPositionMain, width: screenSize.width, height: 240)
        scrollView.addSubview(protocolsBox)
        
        //MARK: Protocols Title Label
        let protocolsTitle = UILabel()
        protocolsTitle.frame = CGRect(x: 12, y: yPositionProtocols, width: screenSize.width - 24, height: 20)
        protocolsTitle.text = "Protocols"
        protocolsTitle.font = .header3()
        protocolsTitle.textColor = .black
        protocolsBox.addSubview(protocolsTitle)
        
        yPositionProtocols += 20 + 8
        
        //MARK: Individual Protocols
        //TODO: Account for other days than today
        for _ in 0...2 {
            
            let boxHeight: CGFloat = 60
            
            let toggleButtonWH: CGFloat = 32
            let toggleButtonY: CGFloat = (boxHeight - toggleButtonWH) / 2
            
            let individualProtocolBox = UIView()
            individualProtocolBox.frame = CGRect(x: 0, y: yPositionProtocols, width: screenSize.width, height: boxHeight)
            protocolsBox.addSubview(individualProtocolBox)
            
            let protocolName = UILabel()
            protocolName.frame = CGRect(x: 12, y: toggleButtonY, width: 150, height: 12)
            protocolName.text = "Vitamin D"
            protocolName.font = .paragraph1()
            protocolName.textColor = .black
            individualProtocolBox.addSubview(protocolName)
            
            let protocolValue = UILabel()
            protocolValue.frame = CGRect(x: 50, y: toggleButtonY + toggleButtonWH - 12, width: 150, height: 12)
            protocolValue.text = "1000 iu"
            protocolValue.font = .paragraph3()
            protocolValue.textColor = #colorLiteral(red: 0.6941176471, green: 0.6941176471, blue: 0.6941176471, alpha: 1)
            individualProtocolBox.addSubview(protocolValue)
            
            let protocolTime = UILabel()
            protocolTime.frame = CGRect(x: 12, y: toggleButtonY + toggleButtonWH - 12, width: 70, height: 12)
            protocolTime.text = "3PM"
            protocolTime.font = .paragraph3()
            protocolTime.textColor = #colorLiteral(red: 0.6941176471, green: 0.6941176471, blue: 0.6941176471, alpha: 1)
            individualProtocolBox.addSubview(protocolTime)
            
            let protocolToggleButton = UIButton()
            protocolToggleButton.frame = CGRect(x: individualProtocolBox.frame.width - toggleButtonWH - 24, y: toggleButtonY, width: toggleButtonWH, height: toggleButtonWH)
            protocolToggleButton.layer.cornerRadius = protocolToggleButton.frame.height / 2
            protocolToggleButton.layer.borderWidth = 1
            protocolToggleButton.layer.borderColor = dividerColor.cgColor
            protocolToggleButton.setImage(UIImage(named: "protocol_incomplete"), for: .normal)
            protocolToggleButton.addTarget(self, action: #selector(toggleProtocolBtnPressed(_:)), for: .touchUpInside)
            protocolToggleButton.tag = 0
            individualProtocolBox.addSubview(protocolToggleButton)
            
            yPositionProtocols += 60
        }
        
        let addProtocolButton = UIButton()
        addProtocolButton.setTitleColor(.black, for: .normal)
        addProtocolButton.setTitle("Add Protocol", for: .normal)
        addProtocolButton.titleLabel?.font = .header2()
        addProtocolButton.frame = CGRect(x: (screenSize.width / 2) - 70, y: yPositionProtocols, width: 140, height: 40)
        addProtocolButton.addTarget(self, action: #selector(addProtocolBtnPressed(_:)), for: .touchUpInside)
        protocolsBox.addSubview(addProtocolButton)
        
    }
    
    //Returns: yPosition
    func setupSymptomsBox(yPositionMain: CGFloat) {
        
        var yPositionSymptoms: CGFloat = 12
        
        let symptomsBox = UIView()
        symptomsBox.frame = CGRect(x: 0, y: yPositionMain, width: screenSize.width, height: 240)
        scrollView.addSubview(symptomsBox)
        
        //MARK: Symptom Title Label
        let symptomsTitle = UILabel()
        symptomsTitle.frame = CGRect(x: 12, y: yPositionSymptoms, width: screenSize.width - 24, height: 20)
        symptomsTitle.text = "Symptoms"
        symptomsTitle.font = .header3()
        symptomsTitle.textColor = .black
        symptomsBox.addSubview(symptomsTitle)
        
        yPositionSymptoms += 20 + 8
        
        //MARK: Add Symptoms
        let addSymptomButton = UIButton()
        addSymptomButton.setTitleColor(.black, for: .normal)
        addSymptomButton.setTitle("Add Symptom", for: .normal)
        addSymptomButton.titleLabel?.font = .header2()
        addSymptomButton.frame = CGRect(x: (screenSize.width / 2) - 70, y: yPositionSymptoms, width: 140, height: 40)
        addSymptomButton.addTarget(self, action: #selector(addSymptomBtnPressed(_:)), for: .touchUpInside)
        symptomsBox.addSubview(addSymptomButton)
        
        yPositionSymptoms += 40 + 12
        
        //MARK: Perform eCheckup Button
        let eCheckupButton = UIButton()
        eCheckupButton.setTitleColor(.black, for: .normal)
        eCheckupButton.setTitle("E-Checkup", for: .normal)
        eCheckupButton.titleLabel?.font = .header2()
        eCheckupButton.frame = CGRect(x: (screenSize.width / 2) - 70, y: yPositionSymptoms, width: 140, height: 40)
        addSymptomButton.addTarget(self, action: #selector(eCheckupBtnPressed(_:)), for: .touchUpInside)
        symptomsBox.addSubview(eCheckupButton)
    }
    
    //Returns: yPosition
    func setupEcheckupBox() {
        
    }
    
    func addDivider(yPosition: CGFloat) {
        let divider = UIView()
        divider.frame = CGRect(x: 0, y: yPosition, width: screenSize.width, height: dividerHeight)
        divider.backgroundColor = dividerColor
        scrollView.addSubview(divider)
    }
    
    @IBAction func addProtocolBtnPressed(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let addProtocolVC = storyboard.instantiateViewController(identifier: "AddProtocolVC")
        present(addProtocolVC, animated: true, completion: nil)
    }
    
    @IBAction func addSymptomBtnPressed(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let addSymptomVC = storyboard.instantiateViewController(identifier: "AddSymptomVC")
        present(addSymptomVC, animated: true, completion: nil)
    }
    
    @IBAction func eCheckupBtnPressed(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let eCheckupVC = storyboard.instantiateViewController(identifier: "ECheckupVC")
        present(eCheckupVC, animated: true, completion: nil)
    }
    
    @IBAction func toggleProtocolBtnPressed(_ sender: UIButton) {
        if sender.tag == 0 {
            sender.setImage(UIImage(named: "protocol_complete"), for: .normal)
            sender.tag = 1
        } else {
            sender.setImage(UIImage(named: "protocol_incomplete"), for: .normal)
            sender.tag = 0
        }
    }
    
    
    // -------------------------
    // Week Calendar Cell
    // Configuration & Functions
    // -------------------------
    
    var isDeselecting: Bool = false
    
    func configureCell(view: JTACDayCell?, cellState: CellState) {
        guard let cell = view as? WeekCalendarCell  else { return }
        
        let dateFormatter = DateFormatter()

        dateFormatter.dateFormat = "d"

        handleCellConfiguration(cell: cell, cellState: cellState)
        
        if cellState.dateBelongsTo == .thisMonth {
           cell.isHidden = false
        } else {
           cell.isHidden = true
        }
        
        cell.dayNumberLabel.text = dateFormatter.string(from: cellState.date)
        //cell.dayNumberLabel.font = .unicaRegular(size: 12)
        
        cell.outlineBox.layer.cornerRadius =  cell.outlineBox.frame.width / 2
        cell.outlineBox.layer.borderWidth = 1
        cell.outlineBox.layer.borderColor = dividerColor.cgColor
        
        cell.dateIndicatorBox.layer.cornerRadius =  cell.dateIndicatorBox.frame.width / 2
        
        dateFormatter.dateFormat = "EEEEE"
        cell.daySymbolLabel.text = dateFormatter.string(from: cellState.date)
        //cell.daySymbolLabel.font = .unicaRegular(size: 8)
        
        
    }
    
    func handleCellConfiguration(cell: JTACDayCell?, cellState: CellState) {
        handleCellSelection(view: cell, cellState: cellState)
    }
    
    func handleCellSelection(view: JTACDayCell?, cellState: CellState) {
        guard let cell = view as? WeekCalendarCell else { return }
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "EEE, MMM d"
        
        if cellState.date.get(.year) != Date().get(.year) {
            dateFormatter.dateFormat = "EEE, MMM d, yyyy"
        }
        
        cell.dateIndicatorBox.layer.cornerRadius = cell.dateIndicatorBox.frame.width / 2
        
        if cellState.isSelected {
            //                if justLaunched == true {
            //                    monthLbl.text = dateFormatter.string(from: cellState.date)
            //                }
            //                loadDay(date: cellState.date)
            //                selectedDate = cellState.date
            dateTopLabel.text = dateFormatter.string(from: cellState.date)
            cell.daySymbolLabel.textColor = .white
            cell.dateIndicatorBox.backgroundColor = .black
        } else {
            cell.daySymbolLabel.textColor = .black
            cell.dateIndicatorBox.backgroundColor = .clear
        }
        
    }
    
    func calendar(_ calendar: JTACMonthView, didSelectDate date: Date, cell: JTACDayCell?, cellState: CellState, indexPath: IndexPath) {
         configureCell(view: cell, cellState: cellState)
     }
    
    func calendar(_ calendar: JTACMonthView, didDeselectDate date: Date, cell: JTACDayCell?, cellState: CellState, indexPath: IndexPath) {
        isDeselecting = true
        configureCell(view: cell, cellState: cellState)
        isDeselecting = false
        
     }


}

extension HomeVC: JTACMonthViewDataSource {
    func configureCalendar(_ calendar: JTACMonthView) -> ConfigurationParameters {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en")
        formatter.dateFormat = "yyyy MM dd"
        let startDate = formatter.date(from: "2020 01 01")!
        let endDate = Date()
        
        return ConfigurationParameters(startDate: startDate,
                                       endDate: endDate,
                                       numberOfRows: 1,
                                       generateInDates: .off,
                                       generateOutDates: .off,
                                       hasStrictBoundaries: false)
    }
}

extension HomeVC: JTACMonthViewDelegate {

    func calendar(_ calendar: JTACMonthView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTACDayCell {
        let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: "WeekCalendarCell", for: indexPath) as! WeekCalendarCell
        self.calendar(calendar, willDisplay: cell, forItemAt: date, cellState: cellState, indexPath: indexPath)
        return cell
    }
    
//    func calendar(_ calendar: JTACMonthView, didScrollToDateSegmentWith visibleDates: DateSegmentInfo) {
//        if let index = daysInWeek.firstIndex(of: "Monday") {
//            weekCalendarView.selectDates([weekCalendarView.visibleDates().monthDates[index].date])
//        }
//
//    }
    
    func calendar(_ calendar: JTACMonthView, willDisplay cell: JTACDayCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath) {
        configureCell(view: cell, cellState: cellState)
    }
}
