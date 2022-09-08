//
//  TopBars.swift
//  BioGenesis
//
//  Created by Martin on 06/09/2022.
//

import UIKit

let largeTabBarHeight: CGFloat = 130
let normalTabBarHeight: CGFloat = 85
let calendarTabBarHeight: CGFloat = 95
let controllerTabBarHeight: CGFloat = 110

class CustomTopBar: UIView {
    private var label = UILabel()
    
    lazy var title: String = "" { didSet { updateUI() } }
    lazy var height: CGFloat = normalTabBarHeight { didSet { updateUI() } }
    
    private let topBarTitle = UILabel()
    private var thinDivider = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTopBar()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
//        setupTopBar()
    }
    
    
    private func setupTopBar() {

        self.frame = CGRect(x: 0, y: 0, width: screenSize.width, height: height)
        self.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)

        topBarTitle.frame = CGRect(x: 0, y: self.safeAreaTop + 8, width: screenSize.width, height: 20)
        topBarTitle.text = title
        topBarTitle.textColor = .black
        topBarTitle.textAlignment = .center
        topBarTitle.font = .graphikMedium(size: 15)
        self.addSubview(topBarTitle)
        
        thinDivider = getThinDivider(yPosition: height - 1, parentView: self)
        self.addSubview(thinDivider)
    }
    
    private func updateUI() {
        self.frame = CGRect(x: 0, y: 0, width: screenSize.width, height: height)
        
        topBarTitle.text = title
        
        topBarTitle.frame = CGRect(x: 0, y: self.safeAreaTop + 8, width: screenSize.width, height: 20)
        
        thinDivider.frame = CGRect(x: 0, y: height - 1, width: screenSize.width, height: 1)
    }
    
    
    
}
