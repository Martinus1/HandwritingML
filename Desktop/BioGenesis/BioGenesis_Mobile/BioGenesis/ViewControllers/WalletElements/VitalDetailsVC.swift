//
//  VitalDetailsVC.swift
//  BioGenesis
//
//  Created by Martin on 07/09/2022.
//

import UIKit

class VitalDetailsVC: UIViewController {

    let scrollView = UIScrollView()
    let topView = CustomTopBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = backgroundColorMain
        scrollView.backgroundColor = backgroundColorMain
        setupScrollView()
    }
    
    func setupScrollView() {
        topView.title = "Vitals"
        topView.height = normalTabBarHeight
        self.view.addSubview(topView)
    }

}
