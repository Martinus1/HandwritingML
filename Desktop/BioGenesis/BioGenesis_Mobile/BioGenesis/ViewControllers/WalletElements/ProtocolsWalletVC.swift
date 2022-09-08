//
//  ProtocolsDetailsVC.swift
//  BioGenesis
//
//  Created by Martin on 17/07/2022.
//

import UIKit

class ProtocolsWalletVC: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = backgroundColorMain
        scrollView.backgroundColor = backgroundColorMain
        
        setupScrollView()
    }

    func setupScrollView() {
        
        let topView = CustomTopBar()
        topView.title = "Protocols"
        topView.height = normalTabBarHeight
        self.view.addSubview(topView)

        var yPosition: CGFloat = topView.frame.maxY + 12
        
        let profileValues = [
                "titles": ["Advill", "Cabergoline","Vitamin B12", "Vitamin D"],
                "frequencies": ["3x in the last week", "2x last month", "yesterday", "last year"]
        ]
        
        for (index, title) in profileValues["titles"]!.enumerated() {
            
            addSymptomBox(yPosition: yPosition, title: title, frequency: profileValues["frequencies"]![index])
            yPosition += 60 + 12
        }
        
        scrollView.contentSize = CGSize(width: screenSize.width, height: yPosition + 90)
    }
    
    func addSymptomBox(yPosition: CGFloat, title: String, frequency: String) {
        let sideSpacing: CGFloat = 12
        let boxHeight: CGFloat = 60
        
        //MARK: Back Box
        let detailsBox = UIButton()
        detailsBox.backgroundColor = .white
        detailsBox.layer.cornerRadius = 10
        detailsBox.frame = CGRect(x: sideSpacing, y: yPosition, width: screenSize.width - (sideSpacing * 1.5), height: boxHeight)
        detailsBox.addTarget(self, action: #selector(protocolDetailsPressed(_:)), for: .touchUpInside)
        scrollView.addSubview(detailsBox)
        
        //MARK: Title
        let titleLabel = UILabel()
        titleLabel.frame = CGRect(x: 24, y: 12, width: screenSize.width - (48), height: 20)
        titleLabel.text = title
        titleLabel.textColor = .black
        titleLabel.font = .header2()
        
        detailsBox.addSubview(titleLabel)
        
        //MARK: Frequency
        let frequencyLabel = UILabel()
        frequencyLabel.frame = CGRect(x: 24, y: 32, width: screenSize.width - (48), height: 20)
        frequencyLabel.text = frequency
        frequencyLabel.textColor = .black
        frequencyLabel.font = .paragraph2()
        
        detailsBox.addSubview(frequencyLabel)
        
    }
    
    @IBAction func protocolDetailsPressed(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "ProtocolDetailsVC")
        present(vc, animated: true, completion: nil)
    }
    
}
