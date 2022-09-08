//
//  SymptomsVC.swift
//  BioGenesis
//
//  Created by Martin on 28/08/2022.
//

import UIKit

class SymptomsVC: UIViewController {

    let topView = CustomTopBar()
    let scrollView = UIScrollView()

    var calendarView: UICollectionView!
    
    var currentDate = 0
    var selectedDate = 0
    var calendarArray = NSArray()
    
    var cellId = "DateCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = backgroundColorMain
        
        setupBaseElements()
        setupCalendar()
        setupScrollView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.calendarArray = arrayOfDates()
        let layoutMargins: CGFloat = self.calendarView.layoutMargins.left + self.calendarView.layoutMargins.right
        let sideInset = (self.view.frame.width / 2) - layoutMargins
        self.calendarView.contentInset = UIEdgeInsets(top: 10, left: sideInset, bottom: 0 , right: sideInset)
        self.calendarView.selectItem(at: IndexPath(row: calendarArray.count - 1, section: 0), animated: false, scrollPosition: .centeredHorizontally)
    }

    
    func setupBaseElements() {
        
        topView.title = "Symptoms"
        topView.height = largeTabBarHeight
        self.view.addSubview(topView)
        
        scrollView.frame = CGRect(x: 0, y: topView.frame.height, width: screenSize.width, height: screenSize.height - topView.frame.height)
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        view.addSubview(scrollView)
        
        //MARK: Divider
        let topViewDivider = UIView()
        topViewDivider.frame = CGRect(x: 0, y: topView.frame.height - 1, width: screenSize.width, height: 1)
        topViewDivider.backgroundColor = grayTextColor
        topView.addSubview(topViewDivider)
        
        //MARK: Divider Selector
        let topSelectorDivider = UIView()
        topSelectorDivider.frame = CGRect(x: screenSize.width / 3, y: topView.frame.height - 3, width: (screenSize.width / 3), height: 3)
        topSelectorDivider.backgroundColor = .black
        topView.addSubview(topSelectorDivider)
    }
    
    func setupCalendar() {
        // MARK: Instantiate the layout of calendar collection view
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: 60, height: 30)
        layout.scrollDirection = .horizontal
        
        let calendarViewHeight: CGFloat = 30
        
        calendarView = UICollectionView(frame: CGRect(x: 0, y: topView.frame.height - calendarViewHeight - 12, width: screenSize.width, height: calendarViewHeight), collectionViewLayout: layout)
        calendarView.dataSource = self
        calendarView.delegate = self
        calendarView.register(HorizontalCalendarCell.self, forCellWithReuseIdentifier: cellId)
        calendarView.showsVerticalScrollIndicator = false
        calendarView.showsHorizontalScrollIndicator = false
        calendarView.backgroundColor = .clear
        topView.addSubview(calendarView)
        
        calendarView.delegate = self
        calendarView.dataSource = self
    }
    
    let currentSymptoms = ["Headache", "Nausea", "Low libido"]
    
    let reccuringSymptoms = ["Blurry vision", "Nausea", "Back pain"]
    
    func setupScrollView() {
        
        var yPosition: CGFloat = 24
        
        //MARK: Current Symptoms Title
        let currentSymptomsTitle = UILabel()
        currentSymptomsTitle.frame = CGRect(x: 12, y: yPosition, width: screenSize.width - 24, height: 30)
        currentSymptomsTitle.text = "Current Symptoms"
        currentSymptomsTitle.textColor = .black
        currentSymptomsTitle.font = .header1()
        scrollView.addSubview(currentSymptomsTitle)
        
        yPosition += currentSymptomsTitle.frame.height + 12
        
        for currentSymptom in currentSymptoms {
            addCurrenSymptom(yPosition: yPosition, height: 40, symptomName: currentSymptom)
            
            yPosition += 40 + 12
        }
        
        //MARK: Add Symptoms Button
        let addSymptomsButton = UIButton()
        addSymptomsButton.backgroundColor = mainColor
        addSymptomsButton.frame = CGRect(x: 12, y: yPosition, width: screenSize.width - 24, height: 50)
        addSymptomsButton.layer.cornerRadius = 10
        addSymptomsButton.addTarget(self, action: #selector(addSymptomBtnPressed(_:)), for: .touchUpInside)
        scrollView.addSubview(addSymptomsButton)
        
        //MARK: Add Symptoms Button Text
        let addSymptomsButtonLabel = UILabel()
        addSymptomsButtonLabel.frame = CGRect(x: 12, y: 0, width: addSymptomsButton.frame.width - 24, height: addSymptomsButton.frame.height)
        addSymptomsButtonLabel.text = "Add Symptoms"
        addSymptomsButtonLabel.textAlignment = .center
        addSymptomsButtonLabel.textColor = .white
        addSymptomsButtonLabel.font = .header3()
        addSymptomsButton.addSubview(addSymptomsButtonLabel)
        
        yPosition += addSymptomsButton.frame.height + 24
        
        //MARK: Reccuring Symptoms Title
        let reccuringSymptomsTitle = UILabel()
        reccuringSymptomsTitle.frame = CGRect(x: 12, y: yPosition, width: screenSize.width - 24, height: 30)
        reccuringSymptomsTitle.text = "Reccuring Symptoms"
        reccuringSymptomsTitle.textColor = .black
        reccuringSymptomsTitle.font = .header1()
        scrollView.addSubview(reccuringSymptomsTitle)
        
        yPosition += 30 + 12
        
        for reccuringSymptom in reccuringSymptoms {
            addReccuringSymptom(yPosition: yPosition, height: 50, symptomName: reccuringSymptom)
            
            yPosition += 50 + 12
        }
        
        scrollView.contentSize = CGSize(width: screenSize.width, height: yPosition + 90)
    }
    
    func addCurrenSymptom(yPosition: CGFloat, height: CGFloat, symptomName: String) {
        let symptomBox = UIView()
        symptomBox.backgroundColor = .white
        symptomBox.frame = CGRect(x: 12, y: yPosition, width: screenSize.width - 24, height: height)
        symptomBox.layer.cornerRadius = 10
        scrollView.addSubview(symptomBox)
        
        let symptomNameLabel = UILabel()
        symptomNameLabel.frame = CGRect(x: 12, y: 4, width: symptomBox.frame.width - 50, height: symptomBox.frame.height - 8)
        symptomNameLabel.text = symptomName
        symptomNameLabel.font = .paragraph2()
        symptomNameLabel.textColor = .black
        symptomBox.addSubview(symptomNameLabel)
        
        let deleteSymptomButton = UIButton()
        let deleteSymptomButtonWH: CGFloat = 16
        deleteSymptomButton.frame = CGRect(x: symptomBox.frame.width - deleteSymptomButtonWH - 12 , y: (symptomBox.frame.height - deleteSymptomButtonWH) / 2, width: deleteSymptomButtonWH, height: deleteSymptomButtonWH)
        deleteSymptomButton.setImage(UIImage(named: "remove_symptom_button") , for: .normal)
        deleteSymptomButton.imageView?.contentMode = .scaleAspectFit
        symptomBox.addSubview(deleteSymptomButton)
        
    }
    
    func addReccuringSymptom(yPosition: CGFloat, height: CGFloat, symptomName: String) {
        let symptomBox = UIView()
        symptomBox.backgroundColor = .clear
        symptomBox.frame = CGRect(x: 12, y: yPosition, width: screenSize.width - 24, height: height)
        scrollView.addSubview(symptomBox)
        
        let symptomNameLabel = UILabel()
        symptomNameLabel.frame = CGRect(x: 0, y: 4, width: symptomBox.frame.width - 50, height: symptomBox.frame.height - 8)
        symptomNameLabel.text = symptomName
        symptomNameLabel.textAlignment = .left
        symptomNameLabel.textColor = .black
        symptomNameLabel.font = .paragraph2()
        symptomBox.addSubview(symptomNameLabel)
        
        let symptomLogButton = UIButton()
        let logButtonWidth: CGFloat = 65
        symptomLogButton.frame = CGRect(x: symptomBox.frame.width - logButtonWidth, y: 6, width: logButtonWidth, height: height - 12)
        symptomLogButton.backgroundColor = mainColor
        symptomLogButton.titleLabel?.text = "Log"
        symptomLogButton.titleLabel?.textColor = .white
        symptomLogButton.titleLabel?.font = .paragraph3()
        symptomLogButton.layer.cornerRadius = 10
        symptomBox.addSubview(symptomLogButton)
        
        //MARK: Log Symptoms Button Text
        let logSymptomsButtonLabel = UILabel()
        logSymptomsButtonLabel.frame = CGRect(x: 0, y: 0, width: symptomLogButton.frame.width, height: symptomLogButton.frame.height)
        logSymptomsButtonLabel.text = "Log"
        logSymptomsButtonLabel.textAlignment = .center
        logSymptomsButtonLabel.textColor = .white
        logSymptomsButtonLabel.font = .header3()
        symptomLogButton.addSubview(logSymptomsButtonLabel)
        
    }
    
    func setupSymptomsBox(yPositionMain: CGFloat) {
        
        var yPositionSymptoms: CGFloat = yPositionMain
        
        //MARK: Symptom Title Label
        let symptomsTitle = UILabel()
        symptomsTitle.frame = CGRect(x: 12, y: yPositionSymptoms, width: screenSize.width - 24, height: 20)
        symptomsTitle.text = "Symptoms"
        symptomsTitle.font = .header3()
        symptomsTitle.textColor = .black
        scrollView.addSubview(symptomsTitle)
        
        //MARK: Add Symptoms
        let addSymptomButton = UIButton()
        addSymptomButton.setTitleColor(.black, for: .normal)
        addSymptomButton.setTitle("+", for: .normal)
        addSymptomButton.titleLabel?.font = .header1()
        addSymptomButton.titleLabel?.textAlignment = .center
        addSymptomButton.frame = CGRect(x: screenSize.width - 32, y: yPositionSymptoms, width: 20, height: 20)
        addSymptomButton.addTarget(self, action: #selector(addSymptomBtnPressed(_:)), for: .touchUpInside)
        scrollView.addSubview(addSymptomButton)
        
        yPositionSymptoms += 20 + 12
        
    }
    
    @IBAction func addSymptomBtnPressed(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let addSymptomVC = storyboard.instantiateViewController(identifier: "AddSymptomVC")
        present(addSymptomVC, animated: true, completion: nil)
    }
    
}

extension SymptomsVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    //MARK: - Collection View Delegate and Data Source
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! HorizontalCalendarCell
        cell.dateLabel.text = self.calendarArray[indexPath.row] as? String
        cell.backgroundColor = .clear
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        self.selectedDateLabel.text = self.calendarArray[indexPath.row] as? String
        
        let centeredIndexPath = IndexPath.init(item: selectedDate, section: 0)
        calendarView.scrollToItem(at: centeredIndexPath, at: .centeredHorizontally, animated: true)
        
        if indexPath == centeredIndexPath {
            calendarView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
    
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if calendarView == scrollView {
            setSelectedItemFromScrollView(scrollView)
        }
    }
    
    func setSelectedItemFromScrollView(_ scrollView: UIScrollView) {
        if calendarView == scrollView {

            let center = CGPoint(x: (calendarView.frame.size.width / 2) + scrollView.contentOffset.x, y: (calendarView.frame.size.height / 2) + scrollView.contentOffset.y)
            let index = calendarView.indexPathForItem(at: center)

            if index != nil {
                calendarView.scrollToItem(at: index!, at: .centeredHorizontally, animated: true)
                self.calendarView.selectItem(at: index, animated: false, scrollPosition: [])
//                self.collectionView(self.calendarView, didSelectItemAt: index!)

                self.selectedDate = (index?.row)!
            }
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        if calendarView == scrollView && !decelerate  {
            setSelectedItemFromScrollView(scrollView)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / 2.6
        let height = 30.0
        return CGSize(width: width, height: height)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return calendarArray.count
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        //MARK: Spacing Between individual cells - Calendar Dates
        return 0
    }
    
}
