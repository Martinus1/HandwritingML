//
//  AddProtocolVC.swift
//  BioGenesis
//
//  Created by Martin on 13/07/2022.
//

import UIKit
import Hero

class AddProtocolVC: UIViewController {
    
    //MARK: - id(string), label(string)
    var drugSearchJson: DrugBankResult = []
    
    var scrollView = UIScrollView()
    
    //MARK: Timing Selection Labels
    let morningTimingButton = UIButton()
    let morninglLabel = UILabel()
    
    let afternoonTimingButton = UIButton()
    let afternoonlLabel = UILabel()
    
    let eveningTimingButton = UIButton()
    let eveninglLabel = UILabel()
    
    var timingSelectionButtons: [UIButton] = []
    var timingSelectionLabels: [UILabel] = []
    
    //MARK: Food intake option
    let preMealButton = UIButton()
    let preMealLabel = UILabel()
    
    let postMealButton = UIButton()
    let postMealLabel = UILabel()
    
    var mealButtons: [UIButton] = []
    var mealLabels: [UILabel] = []
    
    //MARK: Intake ammount
    var intakeAmmountPickerView: UIPickerView! = UIPickerView()
    
    var intakeAmmountUnit: [[String]] = []

    var currentIntakeAmmount: String = ""
    var currentIntakeUnit: String = ""
    
    let intakeTextField = UITextField()
 
    //MARK: Period of intake
    var intakePeriodPickerView: UIPickerView! = UIPickerView()
    
    var periodAmmountUnit: [[String]] = []

    var currentPeriodAmmount: String = ""
    var currentPeriodUnit: String = ""
    
    let intakePeriodTextField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupPickerView()
        
        timingSelectionButtons = [morningTimingButton, afternoonTimingButton, eveningTimingButton]
        timingSelectionLabels = [morninglLabel, afternoonlLabel, eveninglLabel]
        
        mealButtons = [preMealButton, postMealButton]
        mealLabels = [preMealLabel, postMealLabel]
        
        self.view.backgroundColor = #colorLiteral(red: 0.955485642, green: 0.9675140977, blue: 0.9673025012, alpha: 1)
        
        self.hero.isEnabled = true
        self.view.hero.id = "addProtocols"
        
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height))
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        view.addSubview(scrollView)
        
        setupScreen()
    }
    
    func setupPickerView() {
        
        //MARK: TOOLAB
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        toolBar.sizeToFit()

        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(self.togglePickerView))

        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        //MARK: Scroll Views
        let intakeVolumeArray = arrayOfVolumes(from: 1, to: 999)
        let intakeUnitArray = ["mg", "g", "pills", "injections" ,"drops", "teaspoons", "tablespoons"]
        
        intakeAmmountUnit = [intakeVolumeArray, intakeUnitArray]
        
        self.intakeAmmountPickerView.delegate = self
        self.intakeAmmountPickerView.dataSource = self
        self.intakeAmmountPickerView.tag = 0
        
        let periodVolumeArray = arrayInRange(from: 1, to: 99)
        let periodUnitArray = ["days", "weeks", "months", "chronic"]
        
        periodAmmountUnit = [periodVolumeArray, periodUnitArray]
        
        self.intakePeriodPickerView.delegate = self
        self.intakePeriodPickerView.delegate = self
        self.intakePeriodPickerView.tag = 1


        intakeTextField.inputView = intakeAmmountPickerView
        intakeTextField.inputAccessoryView = toolBar
        
        intakePeriodTextField.inputView = intakePeriodPickerView
        intakePeriodTextField.inputAccessoryView = toolBar
    }
    
    func setupScreen() {
        
        var yPosition: CGFloat = 50
        
        let backBtn = UIButton()
        backBtn.frame = CGRect(x: 12, y: yPosition, width: backBtnWH, height: backBtnWH)
        backBtn.setImage(UIImage(named: "back_button") , for: .normal)
        backBtn.addTarget(self, action: #selector(backBtnPressed(_:)), for: .touchUpInside)
        scrollView.addSubview(backBtn)
        
        yPosition += backBtnWH + 12
        
        //MARK: Selected Protocol
        
        let protocolSelectedButton = UIButton()
        protocolSelectedButton.frame = CGRect(x: 12, y: yPosition, width: screenSize.width - 24, height: 40)
        protocolSelectedButton.backgroundColor = .white
        protocolSelectedButton.layer.cornerRadius = cornerRadius
        protocolSelectedButton.addTarget(self, action: #selector(selectedProtocolBtnPressed(_:)), for: .touchUpInside)
        scrollView.addSubview(protocolSelectedButton)
        
        yPosition += protocolSelectedButton.frame.height + 24
        
        let selectedProtocolLabel = UILabel()
        selectedProtocolLabel.frame = CGRect(x: 24, y: 0, width: protocolSelectedButton.frame.width - 24, height: protocolSelectedButton.frame.height)
        selectedProtocolLabel.text = "Advill"
        selectedProtocolLabel.font = .header3()
        selectedProtocolLabel.textColor = .black
        selectedProtocolLabel.textAlignment = .left
        
        protocolSelectedButton.addSubview(selectedProtocolLabel)
        
        let twoElementWidth: CGFloat = (screenSize.width - (12 * 3)) / 2
        
        intakeTextField.frame = CGRect(x: 12, y: yPosition, width: twoElementWidth, height: 40)
        intakeTextField.backgroundColor = .white
        intakeTextField.layer.cornerRadius = cornerRadius
        intakeTextField.tag = 0
        intakeTextField.textAlignment = .center
        intakeTextField.font = .header3()
        intakeTextField.addTarget(self, action: #selector(intakeBtnPressed(_:)), for: .touchUpInside)
        scrollView.addSubview(intakeTextField)
        
        intakePeriodTextField.frame = CGRect(x: 24 + (twoElementWidth), y: yPosition, width: twoElementWidth, height: 40)
        intakePeriodTextField.backgroundColor = .white
        intakePeriodTextField.layer.cornerRadius = cornerRadius
        intakePeriodTextField.tag = 1
        intakePeriodTextField.textAlignment = .center
        intakePeriodTextField.font = .header3()
        intakePeriodTextField.addTarget(self, action: #selector(intakePeriodBtnPressed(_:)), for: .touchUpInside)
        scrollView.addSubview(intakePeriodTextField)
        
        yPosition += intakeTextField.frame.height + 24
        
        //MARK: Time of taking buttons
        
        let threeElementWidth: CGFloat = (screenSize.width - (12 * 4)) / 3
        
        morningTimingButton.frame = CGRect(x: 12, y: yPosition, width: threeElementWidth, height: 40)
        morningTimingButton.backgroundColor = .white
        morningTimingButton.layer.cornerRadius = cornerRadius
        morningTimingButton.tag = 0
        morningTimingButton.addTarget(self, action: #selector(timingBtnPressed(_:)), for: .touchUpInside)
        scrollView.addSubview(morningTimingButton)
        
        morninglLabel.frame = CGRect(x: 0, y: 0, width: morningTimingButton.frame.width , height: morningTimingButton.frame.height)
        morninglLabel.text = "Morning"
        morninglLabel.font = .header3()
        morninglLabel.textColor = .black
        morninglLabel.textAlignment = .center
        morningTimingButton.addSubview(morninglLabel)
        
        
        afternoonTimingButton.frame = CGRect(x: 24 + threeElementWidth, y: yPosition, width: threeElementWidth, height: 40)
        afternoonTimingButton.backgroundColor = .white
        afternoonTimingButton.layer.cornerRadius = cornerRadius
        afternoonTimingButton.tag = 1
        afternoonTimingButton.addTarget(self, action: #selector(timingBtnPressed(_:)), for: .touchUpInside)
        scrollView.addSubview(afternoonTimingButton)
        
        afternoonlLabel.frame = CGRect(x: 0, y: 0, width: afternoonTimingButton.frame.width , height: afternoonTimingButton.frame.height)
        afternoonlLabel.text = "Afternoon"
        afternoonlLabel.font = .header3()
        afternoonlLabel.textColor = .black
        afternoonlLabel.textAlignment = .center
        afternoonTimingButton.addSubview(afternoonlLabel)
        
        eveningTimingButton.frame = CGRect(x: 36 + (threeElementWidth * 2), y: yPosition, width: threeElementWidth, height: 40)
        eveningTimingButton.backgroundColor = .white
        eveningTimingButton.layer.cornerRadius = cornerRadius
        eveningTimingButton.tag = 2
        eveningTimingButton.addTarget(self, action: #selector(timingBtnPressed(_:)), for: .touchUpInside)
        scrollView.addSubview(eveningTimingButton)
        
        eveninglLabel.frame = CGRect(x: 0, y: 0, width: eveningTimingButton.frame.width , height: eveningTimingButton.frame.height)
        eveninglLabel.text = "Evening"
        eveninglLabel.font = .header3()
        eveninglLabel.textColor = .black
        eveninglLabel.textAlignment = .center
        eveningTimingButton.addSubview(eveninglLabel)
        
        yPosition += afternoonTimingButton.frame.height + 24
        
        preMealButton.frame = CGRect(x: 12, y: yPosition, width: twoElementWidth, height: 40)
        preMealButton.backgroundColor = .white
        preMealButton.layer.cornerRadius = 10
        preMealButton.tag = 0
        preMealButton.addTarget(self, action: #selector(mealBtnPressed(_:)), for: .touchUpInside)
        scrollView.addSubview(preMealButton)
        
        preMealLabel.frame = CGRect(x: 0, y: 0, width: preMealButton.frame.width , height: preMealButton.frame.height)
        preMealLabel.text = "Before Food"
        preMealLabel.font = .header3()
        preMealLabel.textColor = .black
        preMealLabel.textAlignment = .center
        preMealButton.addSubview(preMealLabel)
        
        postMealButton.frame = CGRect(x: 24 + (twoElementWidth), y: yPosition, width: twoElementWidth, height: 40)
        postMealButton.backgroundColor = .white
        postMealButton.layer.cornerRadius = 10
        postMealButton.tag = 1
        postMealButton.addTarget(self, action: #selector(mealBtnPressed(_:)), for: .touchUpInside)
        scrollView.addSubview(postMealButton)
        
        postMealLabel.frame = CGRect(x: 0, y: 0, width: postMealButton.frame.width , height: postMealButton.frame.height)
        postMealLabel.text = "With Food"
        postMealLabel.font = .header3()
        postMealLabel.textColor = .black
        postMealLabel.textAlignment = .center
        postMealButton.addSubview(postMealLabel)
        
        let addProtocolButton = UIButton()
        let addProtocolButtonHeight: CGFloat = 50
        addProtocolButton.frame = CGRect(x: 12, y: screenSize.height - addProtocolButtonHeight - 24, width: screenSize.width - 24, height: addProtocolButtonHeight)
        addProtocolButton.backgroundColor = .black
        addProtocolButton.layer.cornerRadius = addProtocolButtonHeight / 2
        addProtocolButton.titleLabel?.text = "Add Protocol"
        addProtocolButton.titleLabel?.textColor = .white
        view.addSubview(addProtocolButton)
        
        let addProtocolButtonTitle = UILabel()
        addProtocolButtonTitle.frame = CGRect(x: 0, y: 0, width: addProtocolButton.frame.width , height: addProtocolButtonHeight)
        addProtocolButtonTitle.text = "Add protocol"
        addProtocolButtonTitle.font = .header3()
        addProtocolButtonTitle.textColor = .black
        addProtocolButtonTitle.textAlignment = .center
        addProtocolButton.addSubview(addProtocolButtonTitle)
        
        scrollView.contentSize = CGSize(width: screenSize.width, height: yPosition + 60)
        
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func selectedProtocolBtnPressed(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "SearchProtocolsVC")
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func timingBtnPressed(_ sender: UIButton) {
        for (index, timingSelectionButton) in timingSelectionButtons.enumerated() {
            timingSelectionButton.backgroundColor = .white
            timingSelectionLabels[index].textColor = .black
        }
        
        timingSelectionButtons[sender.tag].backgroundColor = .black
        timingSelectionLabels[sender.tag].textColor = .white
    }
    
    @IBAction func intakeBtnPressed(_ sender: UIButton) {
        
    }
    
    @IBAction func mealBtnPressed(_ sender: UIButton) {
        
        for (index, mealButton) in mealButtons.enumerated() {
            mealButton.backgroundColor = .white
            mealLabels[index].textColor = .black
        }
        
        mealButtons[sender.tag].backgroundColor = .black
        mealLabels[sender.tag].textColor = .white
    }
    
    @IBAction func intakePeriodBtnPressed(_ sender: UIButton) {
        
    }
    
    func dismissPickerView() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let button = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.togglePickerView))
        toolBar.setItems([button], animated: true)
        toolBar.isUserInteractionEnabled = true
    }
    
    @objc func togglePickerView(_ textField: UITextField) {
        view.endEditing(true)
    }
    
}

extension AddProtocolVC: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 0 {
            return intakeAmmountUnit[component].count
        } else {
            return periodAmmountUnit[component].count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 0 {
            return String(intakeAmmountUnit[component][row])
        } else {
            return String(periodAmmountUnit[component][row])
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 0 {
            if component == 0 {
                currentIntakeAmmount = String(intakeAmmountUnit[component][row])
            } else {
                currentIntakeUnit = String(intakeAmmountUnit[component][row])
            }
            
            intakeTextField.text = currentIntakeAmmount + " " + currentIntakeUnit
        } else {
            if component == 0 {
                currentPeriodAmmount = String(periodAmmountUnit[component][row])
            } else {
                currentPeriodUnit = String(periodAmmountUnit[component][row])
            }
            
            intakePeriodTextField.text = currentPeriodAmmount + " " + currentPeriodUnit
        }
    }
    
    
    
}

