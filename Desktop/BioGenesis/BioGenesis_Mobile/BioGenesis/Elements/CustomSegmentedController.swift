//
//  SegmentedController.swift
//  BioGenesis
//
//  Created by Martin on 06/09/2022.
//

import UIKit

class CustomSegmentedController: UISegmentedControl {
    
    override init(items: [Any]?) {
        super.init(items: items)
        setupSegmentedConteroller()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupSegmentedConteroller()
    }
    
    
    private func setupSegmentedConteroller() {
        
        let font = UIFont.graphikMedium(size: 12)
        self.setTitleTextAttributes([NSAttributedString.Key.font: font, NSAttributedString.Key.foregroundColor: UIColor.white], for: .normal)
        self.setTitleTextAttributes([NSAttributedString.Key.font: font, NSAttributedString.Key.foregroundColor: bioGenesisDark], for: .selected)
        self.backgroundColor = grayTextColor
        self.selectedSegmentTintColor = .white
    }
    
}
