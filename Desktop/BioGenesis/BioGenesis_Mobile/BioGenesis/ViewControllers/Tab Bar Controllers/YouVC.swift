//
//  YouVC.swift
//  BioGenesis
//
//  Created by Martin on 28/08/2022.
//

import UIKit

class YouVC: UIViewController {

    let topView = CustomTopBar()
    
    var calendarView: UICollectionView!
    
    var currentDate = 0
    var selectedDate = 0
    var calendarArray = NSArray()
    
    var cellId = "DateCell"
    
    let vitalsValues: [String : CGFloat] = ["Heart rate" : 70, "Body Temperature" : 98.4, "Glucose" : 110]
    let vitalsImages: [String: UIImage] = [
        "Heart rate" : UIImage(named: "heartRate")!,
        "Body Temperature" : UIImage(named: "temperature")!,
        "Glucose" : UIImage(named: "glucose")!,
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = backgroundColorMain
        
        setupBaseElements()
        setupCalendar()
        setupMainView()
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
        
        topView.title = "You"
        topView.height = largeTabBarHeight
        self.view.addSubview(topView)
        
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
    
    func setupMainView() {
        
        //MARK: Bottom Graph
        let tapBarHeight = self.tabBarController?.tabBar.frame.height ?? 49.0
        let bottomGraphView = UIView()
        let bottomGraphViewHeight: CGFloat = 175
        bottomGraphView.frame = CGRect(x: 12, y: screenSize.height - tapBarHeight - 12 - bottomGraphViewHeight, width: screenSize.width - 24, height: bottomGraphViewHeight)
        bottomGraphView.layer.cornerRadius = 10
        bottomGraphView.backgroundColor = .white
        self.view.addSubview(bottomGraphView)
        
        //MARK: Left Side Vertical Vital View
        let vitalView = UIView()
        let vitalViewHeight: CGFloat = 175
        let vitalViewWidth: CGFloat = screenSize.width / 4.5
        vitalView.frame = CGRect(x: 12, y: bottomGraphView.frame.minY - vitalViewHeight - 12, width: vitalViewWidth, height: vitalViewHeight)
        vitalView.layer.cornerRadius = 10
        vitalView.backgroundColor = .white
        self.view.addSubview(vitalView)
        
        var yPositionVitals: CGFloat = 12
        let vitalElementHeight: CGFloat = (vitalViewHeight - 24) / CGFloat(vitalsValues.count)
        let vitalElementWidth: CGFloat = (vitalView.frame.width / 2) - 12
        
        for (vital, vitalsValue) in vitalsValues {
            
            let vitalElementImage = UIImageView()
            let margin: CGFloat = 14
            vitalElementImage.image = vitalsImages[vital]!.withInset(UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin))
            vitalElementImage.contentMode = .scaleAspectFit
            vitalElementImage.frame = CGRect(x: 12, y: yPositionVitals, width: vitalElementWidth, height: vitalElementHeight)
            vitalView.addSubview(vitalElementImage)
            
            let vitalValueLabel = UILabel()
            vitalValueLabel.frame = CGRect(x: vitalElementWidth + 18, y: yPositionVitals, width: vitalElementWidth, height: vitalElementHeight)
            vitalValueLabel.font = .paragraph2()
            vitalValueLabel.textColor = .black
            vitalValueLabel.textAlignment = .left
            
            if (vitalsValue - floor(vitalsValue) >= 0.01) {
                print("VTIALS VALUE")
                print(vitalsValue)
                var adjustedValue = preciseRound(vitalsValue, precision: .tenths)
                vitalValueLabel.text =  String(adjustedValue)
            } else {
                var adjustedValue = Int(round(vitalsValue))
                vitalValueLabel.text =  String(adjustedValue)
            }
            vitalView.addSubview(vitalValueLabel)
            
            yPositionVitals += vitalElementHeight
        }
        
        //MARK: Person silhouette
        let personSilhouette = UIImageView()
        personSilhouette.image = UIImage(named: "personSilhouette")
        personSilhouette.contentMode = .scaleAspectFit
        let personSilhouetteHeight: CGFloat = screenSize.height - topView.frame.height - bottomGraphViewHeight - tapBarHeight - 36
        let personSilhouetteWidth: CGFloat = screenSize.width
        personSilhouette.frame = CGRect(x: 12, y: topView.frame.height + 12, width: personSilhouetteWidth, height: personSilhouetteHeight)
        self.view.addSubview(personSilhouette)
        
        //MARK: Add Vitals Button
        let addVitalBtnWH: CGFloat = 50
        let addVitalButton = UIButton()
        addVitalButton.frame = CGRect(x: screenSize.width - addVitalBtnWH - 12 , y: bottomGraphView.frame.minY - addVitalBtnWH - 12, width: addVitalBtnWH, height: addVitalBtnWH)
        addVitalButton.setImage(UIImage(named: "general_add_button") , for: .normal)
        addVitalButton.addTarget(self, action: #selector(addVitalBtnPressed(_:)), for: .touchUpInside)
        addVitalButton.layer.zPosition = 1
        addVitalButton.hero.id = "addVital"
        
        self.view.addSubview(addVitalButton)
        
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
    
    @IBAction func addDataPointBtnPressed(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let addSymptomVC = storyboard.instantiateViewController(identifier: "")
        present(addSymptomVC, animated: true, completion: nil)
    }
    
    @IBAction func addVitalBtnPressed(_ sender: UIButton) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "AddVitalVC") as! AddVitalVC
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }

}


extension YouVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
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

