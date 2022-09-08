//
//  LabworkResultsVC.swift
//  BioGenesis
//
//  Created by Martin on 04/09/2022.
//

import UIKit

class LabworkResultsVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = backgroundColorMain
//        scrollView.backgroundColor = backgroundColorMain
//        setupScrollView()
    }
    
    func setupScrollView() {
        
        //MARK: Top View - Search Bar & Back Buttom
        ///NOT ADDED - CARD VIEW
        let backBtn = UIButton()
        backBtn.frame = CGRect(x: 20, y: 50, width: 30, height: 30)
        backBtn.backgroundColor = .black
//        backBtn.addTarget(self, action: #selector(backBtnPressed(_:)), for: .touchUpInside)
        
//        scrollView.addSubview(backBtn)
        
        var yPosition: CGFloat = 30
    }

}
