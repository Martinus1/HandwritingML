//
//  TherapeuticProtocolsVC.swift
//  BioGenesis
//
//  Created by Martin on 18/08/2022.
//

import UIKit
import Hero

class TherapeuticProtocolsVC: UIViewController {
    
    var topView = CustomTopBar()
    let scrollView = UIScrollView()
    
    var therapeutics = [
        "Morning" : [("Vitamin D", 1000, "ui", false), ("Tylenol", 650, "mg", false), ("Iron", 19, "mg", true)],
        "Afternoon" : [],
        "Evening" : [],
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hero.isEnabled = true
        
        self.view.backgroundColor = backgroundColorMain
        
        setupTopView()
        setupScrollView()
        
        setupProtocolsView()
        
        //MARK: Add protocols Button
        let tapBarHeight = self.tabBarController?.tabBar.frame.height ?? 49.0
        let addProtocolsBtnWH: CGFloat = 50
        let addProtocolsButton = UIButton()
        addProtocolsButton.frame = CGRect(x: screenSize.width - addProtocolsBtnWH - 12 , y: view.frame.height - addProtocolsBtnWH - 24 - tapBarHeight, width: addProtocolsBtnWH, height: addProtocolsBtnWH)
        addProtocolsButton.setImage(UIImage(named: "general_add_button") , for: .normal)
        addProtocolsButton.addTarget(self, action: #selector(addProtocolBtnPressed(_:)), for: .touchUpInside)
        addProtocolsButton.layer.zPosition = 1
        addProtocolsButton.hero.id = "addProtocols"
        
        self.view.addSubview(addProtocolsButton)
    
    }
    
    var sortedTherapeutics: [(String, Int, String, Bool)] = []
    
    func setupProtocolsView() {
        
        for subview in scrollView.subviews {
            subview.removeFromSuperview()
        }
        
        var yPosition: CGFloat = 12
        let protocolBoxHeight: CGFloat = 75
        
        var completeTherapeutics: [(String, Int, String, Bool)] = []
        var incompleteTherapeutics: [(String, Int, String, Bool)] = []
        
        for therapeutic in therapeutics["Morning"]! {
            if therapeutic.3 == true {
                completeTherapeutics.append(therapeutic)
            } else {
                incompleteTherapeutics.append(therapeutic)
            }
        }

        sortedTherapeutics = incompleteTherapeutics + completeTherapeutics
        
        for (index, therapetic) in sortedTherapeutics.enumerated()  {
            generateTherapeuticBox(yPosition: yPosition, index: index,boxHeight: protocolBoxHeight, name: therapetic.0, volume: therapetic.1, unit: therapetic.2, beforeMeal: false, isFinished: therapetic.3)
            
            yPosition += protocolBoxHeight + 12
        }
    }
    
    func setupTopView() {
        
        topView.title = "Protocols"
        topView.height = largeTabBarHeight
        self.view.addSubview(topView)
        
        scrollView.frame = CGRect(x: 0, y: topView.frame.height, width: screenSize.width, height: screenSize.height - topView.frame.height)
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        view.addSubview(scrollView)
    
        
        let segmentedControl = CustomSegmentedController(items: ["Morning", "Afternoon", "Evening"])
        segmentedControl.frame = CGRect(x: 12, y: topView.frame.height - 30 - 12, width: screenSize.width - 24, height: 30)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(self.segmentedValueChanged(_:)), for: .valueChanged)
        
        topView.addSubview(segmentedControl)
    }
    
    func generateTherapeuticBox(yPosition: CGFloat, index: Int, boxHeight: CGFloat, name: String, volume: Int, unit: String, beforeMeal: Bool, isFinished: Bool) {
        
        let toggleButtonWH: CGFloat = 32
        let boxExtraSideShift: CGFloat = 60
        let toggleButtonY: CGFloat = (boxHeight - toggleButtonWH) / 2
        
        let individualProtocolBox = UIButton()
        individualProtocolBox.frame = CGRect(x: 12 + boxExtraSideShift, y: yPosition, width: screenSize.width - 24 - boxExtraSideShift, height: boxHeight)
        individualProtocolBox.backgroundColor = .white
        individualProtocolBox.layer.cornerRadius = 10
        individualProtocolBox.addTarget(self, action: #selector(protocolBtnPressed(_:)), for: .touchUpInside)
        scrollView.addSubview(individualProtocolBox)
        
        let protocolName = UILabel()
        protocolName.frame = CGRect(x: 12, y: (boxHeight - 15) / 2, width: 150, height: 15)
        protocolName.text = name
        protocolName.font = .paragraph1()
        protocolName.textColor = .black
        individualProtocolBox.addSubview(protocolName)
        
        let protocolValue = UILabel()
        protocolValue.frame = CGRect(x: -boxExtraSideShift, y: (boxHeight - 15) / 2, width: 150, height: 15)
        protocolValue.text = String(volume) + unit
        protocolValue.font = .paragraph1()
        protocolValue.textColor = #colorLiteral(red: 0.6941176471, green: 0.6941176471, blue: 0.6941176471, alpha: 1)
        individualProtocolBox.addSubview(protocolValue)
        
        let protocolToggleButton = UIButton()
        protocolToggleButton.frame = CGRect(x: individualProtocolBox.frame.width - toggleButtonWH - 24, y: toggleButtonY, width: toggleButtonWH, height: toggleButtonWH)
        protocolToggleButton.setImage(UIImage(named: "protocol_incomplete"), for: .normal)
        protocolToggleButton.addTarget(self, action: #selector(toggleProtocolBtnPressed(_:)), for: .touchUpInside)
        protocolToggleButton.tag = index
        individualProtocolBox.addSubview(protocolToggleButton)
        
        if isFinished {
            protocolToggleButton.setImage(UIImage(named: "protocol_complete"), for: .normal)
            individualProtocolBox.backgroundColor = #colorLiteral(red: 0.937254902, green: 0.937254902, blue: 0.937254902, alpha: 1)
            protocolName.textColor = #colorLiteral(red: 0.7254901961, green: 0.7254901961, blue: 0.7254901961, alpha: 1)
        }
    }
    
    
    func setupScrollView() {
        
        //TODO: implement this
        /*
        let addProtocolButton = UIButton()
        addProtocolButton.setTitleColor(.black, for: .normal)
        addProtocolButton.setTitle("Add Protocol", for: .normal)
        addProtocolButton.titleLabel?.font = .header2()
        addProtocolButton.frame = CGRect(x: (screenSize.width / 2) - 70, y: yPositionProtocols, width: 140, height: 40)
        addProtocolButton.addTarget(self, action: #selector(addProtocolBtnPressed(_:)), for: .touchUpInside)
        scrollView.addSubview(addProtocolButton)
         */
    }
    
    @IBAction func toggleProtocolBtnPressed(_ sender: UIButton) {
        
        sortedTherapeutics[sender.tag].3 = !(sortedTherapeutics[sender.tag].3)
        
        therapeutics["Morning"] = sortedTherapeutics
        
        setupProtocolsView()
    }
    
    @IBAction func protocolBtnPressed(_ sender: UIButton) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "ProtocolDetailsVC")
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func addProtocolBtnPressed(_ sender: UIButton) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "AddProtocolVC") as! AddProtocolVC
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    
    @objc func segmentedValueChanged(_ sender:UISegmentedControl!)
    {
        print("Selected Segment Index is : \(sender.selectedSegmentIndex)")
    }

    
}
