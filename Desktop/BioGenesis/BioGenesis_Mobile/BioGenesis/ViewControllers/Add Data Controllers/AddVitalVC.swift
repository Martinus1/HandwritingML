//
//  AddVitalVC.swift
//  BioGenesis
//
//  Created by Martin on 04/09/2022.
//

import UIKit

class AddVitalVC: UIViewController {

    let vitals = ["Weight", "Temperature", "Heart rate", "Blood pressure", "Glucose"]
    
    var dates: [String] = []
    
    let values = ["1", "2", "3", "4", "5", "6"]
    
    //MARK: Select Vital
    var selectVitalPickerView: UIPickerView! = UIPickerView()
    
    var currentVital: String = ""
    
    let selectVitalTextField = UITextField()
    
    //MARK: Date Recorded
    var selectDatePickerView: UIPickerView! = UIPickerView()
    
    var currentDate: String = ""
    
    let dateRecordedTextField = UITextField()
    
    //MARK: Value Recorded
    var selectValuePickerView: UIPickerView! = UIPickerView()
    
    var currentValue: String = ""
    
    let valueRecordedTextField = UITextField()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = backgroundColorMain
        
        self.dates = pickerViewStringDates()
        
        setupScreen()
        setupPickerView()
    }
    
    func setupScreen() {
        var yPosition: CGFloat = 50
        
        let backBtn = UIButton()
        backBtn.frame = CGRect(x: 12, y: yPosition, width: backBtnWH, height: backBtnWH)
        backBtn.setImage(UIImage(named: "back_button") , for: .normal)
        backBtn.addTarget(self, action: #selector(backBtnPressed(_:)), for: .touchUpInside)
        
        view.addSubview(backBtn)
        
        yPosition += backBtnWH + 12
        
        //MARK: Selected Vital
        selectVitalTextField.frame = CGRect(x: 12, y: yPosition, width: screenSize.width - 24, height: 40)
        selectVitalTextField.backgroundColor = .white
        selectVitalTextField.textColor = .black
        selectVitalTextField.layer.cornerRadius = cornerRadius
        selectVitalTextField.tag = 0
        selectVitalTextField.textAlignment = .center
        selectVitalTextField.font = .header3()
        self.view.addSubview(selectVitalTextField)
        
        yPosition += selectVitalTextField.frame.height + 24
        
        //MARK: Date Recorded
        dateRecordedTextField.frame = CGRect(x: 12, y: yPosition, width: screenSize.width - 24, height: 40)
        dateRecordedTextField.backgroundColor = .white
        dateRecordedTextField.textColor = .black
        dateRecordedTextField.layer.cornerRadius = cornerRadius
        dateRecordedTextField.tag = 1
        dateRecordedTextField.textAlignment = .center
        dateRecordedTextField.font = .header3()
        self.view.addSubview(dateRecordedTextField)
        
        yPosition += dateRecordedTextField.frame.height + 24
        
        //MARK: Value Recorded
        valueRecordedTextField.frame = CGRect(x: 12, y: yPosition, width: screenSize.width - 24, height: 40)
        valueRecordedTextField.backgroundColor = .white
        valueRecordedTextField.layer.cornerRadius = cornerRadius
        valueRecordedTextField.tag = 2
        valueRecordedTextField.textColor = .black
        valueRecordedTextField.textAlignment = .center
        valueRecordedTextField.font = .header3()
        self.view.addSubview(valueRecordedTextField)
        
        yPosition += valueRecordedTextField.frame.height + 24
        
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
        
        //MARK: Picker Views
        self.selectVitalPickerView.delegate = self
        self.selectVitalPickerView.dataSource = self
        self.selectVitalPickerView.tag = 0

        selectVitalTextField.inputView = selectVitalPickerView
        selectVitalTextField.inputAccessoryView = toolBar
        
        self.selectDatePickerView.delegate = self
        self.selectDatePickerView.dataSource = self
        self.selectDatePickerView.tag = 1

        dateRecordedTextField.inputView = selectDatePickerView
        dateRecordedTextField.inputAccessoryView = toolBar
        
        self.selectValuePickerView.delegate = self
        self.selectValuePickerView.dataSource = self
        self.selectValuePickerView.tag = 2

        valueRecordedTextField.inputView = selectValuePickerView
        valueRecordedTextField.inputAccessoryView = toolBar
        
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
    
    @IBAction func backBtnPressed(_ sender: Any) {
        dismiss(animated: true)
    }
        
}

extension AddVitalVC: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        if pickerView.tag == 0 {
            return 1
        } else {
            return 1
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 0 {
            return vitals.count
        } else if pickerView.tag == 1 {
            return dates.count
        } else if pickerView.tag == 2 {
            return values.count
        } else {
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 0 {
            return vitals[row]
        } else if pickerView.tag == 1 {
            return dates[row]
        } else if pickerView.tag == 2 {
            return values[row]
        } else {
            return ""
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 0 {
            currentVital = vitals[row]
            
            selectVitalTextField.text = currentVital
        } else if pickerView.tag == 1 {
            currentDate = dates[row]
            
            dateRecordedTextField.text = currentDate
        } else if pickerView.tag == 2 {
            currentValue = values[row]
            
            valueRecordedTextField.text = currentValue
        }
    }
    
    
    
}


