//
//  TherapeuticProtocolsVC.swift
//  BioGenesis
//
//  Created by Martin on 18/08/2022.
//

import UIKit

class TherapeuticProtocolsVC: UIViewController {

    @IBOutlet weak var topView: UIView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = #colorLiteral(red: 0.955485642, green: 0.9675140977, blue: 0.9673025012, alpha: 1)
        
        setupTopView()
        setupScrollView()
    }
    
    func setupTopView() {
        
        let pageTitle = UILabel()
        pageTitle.frame = CGRect(x: 12, y: 60, width: screenSize.width - 24, height: 30)
        pageTitle.text = "Therapeutic Protocols"
        pageTitle.textAlignment = .center
        pageTitle.font = .header1()
        topView.addSubview(pageTitle)
        
        let segmentedControl = UISegmentedControl (items: ["Morning", "Afternoon", "Evening"])
        segmentedControl.frame = CGRect(x: 12, y: 150, width: screenSize.width - 24, height: 30)
        segmentedControl.selectedSegmentIndex = 0
        let font = UIFont.paragraph4()
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.font: font], for: .normal)
        segmentedControl.addTarget(self, action: #selector(self.segmentedValueChanged(_:)), for: .valueChanged)
        
        topView.addSubview(segmentedControl)
    }
    
    
    func setupScrollView() {
        
        var yPositionProtocols: CGFloat = 12
        
        //MARK: Individual Protocols
        //TODO: Account for other days than today
        for _ in 0...2 {
            
            let boxHeight: CGFloat = 60
            
            let toggleButtonWH: CGFloat = 32
            let toggleButtonY: CGFloat = (boxHeight - toggleButtonWH) / 2
            
            let individualProtocolBox = UIView()
            individualProtocolBox.frame = CGRect(x: 0, y: yPositionProtocols, width: screenSize.width, height: boxHeight)
            scrollView.addSubview(individualProtocolBox)
            
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
        scrollView.addSubview(addProtocolButton)
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
    
    @IBAction func addProtocolBtnPressed(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let addProtocolVC = storyboard.instantiateViewController(identifier: "AddProtocolVC")
        present(addProtocolVC, animated: true, completion: nil)
    }
    
    @objc func segmentedValueChanged(_ sender:UISegmentedControl!)
    {
        print("Selected Segment Index is : \(sender.selectedSegmentIndex)")
    }

    
}
