//
//  ViewController.swift
//  BioGenesis
//
//  Created by Martin on 11/07/2022.
//

import UIKit

class HomeVC: UIViewController {
    
    var scrollView = UIScrollView()
    
    var topView = CustomTopBar()
    var calendarView: UICollectionView!
    //MARK: Local Elements
    let selectedDateLabel = UILabel()
    
    let symptomHighlights = ["Headache", "Caugh", "Nausea"]
    
    var cellId = "DateCell"
    
    var currentDate = 0
    var selectedDate = 0
    var calendarArray = NSArray()
    
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
        
        topView.title = "Home"
        topView.height = largeTabBarHeight
        self.view.addSubview(topView)
        
        scrollView.frame = CGRect(x: 0, y: topView.frame.height, width: screenSize.width, height: screenSize.height - topView.frame.height)
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        view.addSubview(scrollView)
        
        //MARK: Divider Selector
        let topSelectorDivider = UIView()
        topSelectorDivider.frame = CGRect(x: screenSize.width / 3, y: topView.frame.height - 3, width: (screenSize.width / 3), height: 3)
        topSelectorDivider.backgroundColor = .black
        topView.addSubview(topSelectorDivider)
    }
    
    func addTitle(title: String, yPosition: CGFloat, height: CGFloat) {
        let titleLabel = UILabel()
        titleLabel.frame = CGRect(x: 12, y: yPosition, width: screenSize.width - 24, height: height)
        titleLabel.text = title
        titleLabel.textColor = .black
        titleLabel.textAlignment = .left
        titleLabel.font = .header2()
        scrollView.addSubview(titleLabel)
        
    }
    
    func addPregnancyProgressBox(yPosition: CGFloat, title: String, subtitle: String, height: CGFloat) {
        let pregnancyBox = UIView()
        pregnancyBox.frame = CGRect(x: 12, y: yPosition, width: screenSize.width - 24, height: height)
        pregnancyBox.backgroundColor = .white
        pregnancyBox.layer.cornerRadius = cornerRadius
        scrollView.addSubview(pregnancyBox)
        
        let titleLabel = UILabel()
        titleLabel.font = .header2()
        titleLabel.frame = CGRect(x: 12, y: 12, width: pregnancyBox.frame.width - 24, height: 15)
        titleLabel.textColor = .black
        titleLabel.text = title
        pregnancyBox.addSubview(titleLabel)
        
        let subtitleLabel = UILabel()
        subtitleLabel.font = .paragraph3()
        subtitleLabel.frame = CGRect(x: 12, y: titleLabel.frame.maxY + 4, width: pregnancyBox.frame.width - 24, height: 12)
        subtitleLabel.textColor = .black
        subtitleLabel.text = subtitle
        pregnancyBox.addSubview(subtitleLabel)
        
        let fetusImage = UIImageView()
        fetusImage.frame = CGRect(x: 12, y: subtitleLabel.frame.maxY + 12, width: pregnancyBox.frame.width - 24, height: height - subtitleLabel.frame.maxY - 50)
        fetusImage.image = UIImage(named: "fetus_week_5")
        fetusImage.contentMode = .scaleAspectFit
        pregnancyBox.addSubview(fetusImage)
        
        let progressBarSkeeleton = UIView()
        let progressBarSkeeletonWidth: CGFloat = pregnancyBox.frame.width - 24
        let progressBarSkeeletonHeight: CGFloat = 8
        progressBarSkeeleton.backgroundColor = grayTextColor
        progressBarSkeeleton.frame = CGRect(x: 12 , y: height - 12 - progressBarSkeeletonHeight, width: progressBarSkeeletonWidth, height: progressBarSkeeletonHeight)
        progressBarSkeeleton.layer.cornerRadius = progressBarSkeeletonHeight / 2
        progressBarSkeeleton.clipsToBounds = true
        pregnancyBox.addSubview(progressBarSkeeleton)
        
        let progressBar = UIView()
        progressBar.backgroundColor = mainColor
        progressBar.frame = CGRect(x: 0 , y: 0, width: (20 / 100) * progressBarSkeeletonWidth, height: progressBarSkeeletonHeight)
        progressBar.layer.cornerRadius = progressBarSkeeletonHeight / 2
        progressBarSkeeleton.addSubview(progressBar)
        
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
    
    func setupScrollView() {
        
        //MARK: Variables
        var yPosition: CGFloat = 50
        let titleHeight: CGFloat = 20
        
        addTitle(title: "Pregnancy", yPosition: yPosition, height: titleHeight)
        yPosition += titleHeight + 12
        
        addPregnancyProgressBox(yPosition: yPosition, title: "Due on 29th of May", subtitle: "First Trimester, 5th week", height: 200)
        yPosition += 200 + 24
  
        addTitle(title: "Highlights", yPosition: yPosition, height: titleHeight)
        yPosition += titleHeight + 12
        
        setupBloodTestBox(height: 150, yPositionMain: yPosition)
        yPosition += 150 + 24
        
        addTitle(title: "Risk Factors", yPosition: yPosition, height: titleHeight)
        yPosition += titleHeight + 12
        
        
        let risks = ["Hypertension", "Flu", "Cold", "Ulcers"]
        
        for risk in risks {
            conditionAtRisk(yPosition: yPosition, height: 35, name: risk, riskValue: 80)
            
            yPosition += 35 + 12
        }
        
        yPosition += 12
        
        scrollView.contentSize = CGSize(width: screenSize.width, height: yPosition + 90)
        
    }
    
    
    func setupConditionBox(yPositionMain: CGFloat) {
        let conditionBox = UIButton()
        conditionBox.frame = CGRect(x: 12, y: yPositionMain, width: screenSize.width - 24, height: 80)
        conditionBox.backgroundColor = .white
        conditionBox.layer.cornerRadius = cornerRadius
        conditionBox.addTarget(self, action: #selector(conditionPressed(_:)), for: .touchUpInside)
        scrollView.addSubview(conditionBox)
        
        let conditionTitle = UILabel()
        conditionTitle.frame = CGRect(x: 16, y: 16, width: screenSize.width - 24, height: 20)
        conditionTitle.text = "Hyperprolactinemia"
        conditionTitle.font = .header3()
        conditionTitle.textColor = .black
        conditionBox.addSubview(conditionTitle)
        
        let conditionRisk = UILabel()
        conditionRisk.frame = CGRect(x: 16, y: conditionBox.frame.height - 16 - 20, width: screenSize.width - 24, height: 20)
        conditionRisk.text = "High Risk"
        conditionRisk.font = .paragraph2()
        conditionRisk.textColor = .black
        conditionBox.addSubview(conditionRisk)
    }
    
    func setupBloodTestBox(height: CGFloat, yPositionMain: CGFloat) {
        
        let bloodTestBox = UIButton()
        bloodTestBox.frame = CGRect(x: 12, y: yPositionMain, width: screenSize.width - 24, height: 150)
        bloodTestBox.backgroundColor = mainColor
        bloodTestBox.layer.cornerRadius = cornerRadius
        bloodTestBox.addTarget(self, action: #selector(labworkBtnPressed(_:)), for: .touchUpInside)
        scrollView.addSubview(bloodTestBox)
        
        var yPosition: CGFloat = 12
        
        let titleLabel = UILabel()
        titleLabel.frame = CGRect(x: 12, y: yPosition, width: bloodTestBox.frame.width - 24, height: 20)
        titleLabel.text = "Blood Test Results"
        titleLabel.font = .header3()
        titleLabel.textColor = .white
        bloodTestBox.addSubview(titleLabel)
        
        yPosition += titleLabel.frame.height + 2
                              
        let subtitileLabel = UILabel()
        subtitileLabel.frame = CGRect(x: 12, y: yPosition, width: bloodTestBox.frame.width - 24, height: 20)
        subtitileLabel.text = "31 biomarkers tested"
        subtitileLabel.font = .paragraph2()
        subtitileLabel.textColor = .white
        bloodTestBox.addSubview(subtitileLabel)
        
        let seeReportBox = UIView()
        seeReportBox.frame = CGRect(x: 12, y: height - 35 - 12, width: bloodTestBox.frame.width - 24, height: 35)
        seeReportBox.backgroundColor = .black.withAlphaComponent(0.25)
        seeReportBox.layer.cornerRadius = 10
        bloodTestBox.addSubview(seeReportBox)
        
        let seeReportBoxTitle = UILabel()
        seeReportBoxTitle.frame = CGRect(x: 12, y: 0, width: bloodTestBox.frame.width - 24, height: seeReportBox.frame.height)
        seeReportBoxTitle.text = "See report"
        seeReportBoxTitle.font = .paragraph3()
        seeReportBoxTitle.textAlignment = .center
        seeReportBoxTitle.textColor = .white
        seeReportBox.addSubview(seeReportBoxTitle)
        
    }
    
    func conditionAtRisk(yPosition: CGFloat, height: CGFloat, name: String, riskValue: CGFloat) {
        
        let riskBox = UIView()
        riskBox.frame = CGRect(x: 12, y: yPosition, width: screenSize.width - 24, height: height)
        riskBox.backgroundColor = .white
        riskBox.layer.cornerRadius = cornerRadius
        scrollView.addSubview(riskBox)
        
        let conditionName = UILabel()
        conditionName.frame = CGRect(x: 24, y: 0, width: riskBox.frame.width / 2, height: riskBox.frame.height)
        conditionName.text = name
        conditionName.font = .paragraph4()
        conditionName.textAlignment = .left
        conditionName.textColor = .black
        riskBox.addSubview(conditionName)
        
        let riskValueSkeleton = UIView()
        let riskValueSkeletonWidth: CGFloat = (riskBox.frame.width / 1.8) + 12
        riskValueSkeleton.backgroundColor = grayTextColor
        riskValueSkeleton.frame = CGRect(x: riskBox.frame.width - riskValueSkeletonWidth - 12 , y: (riskBox.frame.height / 2) - 5, width: riskValueSkeletonWidth, height: 7)
        riskValueSkeleton.layer.cornerRadius = riskValueSkeleton.frame.height / 2
        riskValueSkeleton.clipsToBounds = true
        riskBox.addSubview(riskValueSkeleton)
        
        let riskValueBar = UIView()
        riskValueBar.backgroundColor = mainColor
        riskValueBar.frame = CGRect(x: 0 , y: 0, width: (riskValue / 100) * riskValueSkeletonWidth, height: 7)
        riskValueBar.layer.cornerRadius = riskValueSkeleton.frame.height / 2
        riskValueSkeleton.addSubview(riskValueBar)
        
    }
    
    func addDivider(yPosition: CGFloat) {
        let divider = UIView()
        divider.frame = CGRect(x: 0, y: yPosition, width: screenSize.width, height: dividerHeight)
        divider.backgroundColor = dividerColor
        scrollView.addSubview(divider)
    }
    
    @IBAction func conditionPressed(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "ConditionDetailsVC")
        present(vc, animated: true, completion: nil)
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
    
    @IBAction func toggleProtocolBtnPressed(_ sender: UIButton) {
        if sender.tag == 0 {
            sender.setImage(UIImage(named: "protocol_complete"), for: .normal)
            sender.tag = 1
        } else {
            sender.setImage(UIImage(named: "protocol_incomplete"), for: .normal)
            sender.tag = 0
        }
    }
    
    @IBAction func labworkBtnPressed(_ sender: UIButton) {
    
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "LabworkResultsVC")
        present(vc, animated: true, completion: nil)
    }
    
    
    // -------------------------
    // Week Calendar Cell
    // Configuration & Functions
    // -------------------------
    
}



extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    //MARK: - Collection View Delegate and Data Source
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! HorizontalCalendarCell
        cell.dateLabel.text = self.calendarArray[indexPath.row] as? String
        cell.backgroundColor = .clear
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectedDateLabel.text = self.calendarArray[indexPath.row] as? String
        
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
                self.selectedDateLabel.text = self.calendarArray[(index?.row)!] as! String?
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
