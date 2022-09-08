//
//  CustomTabBar.swift
//  BioGenesis
//
//  Created by Martin on 12/07/2022.
//

import UIKit

class TabBarController: UITabBarController, UITabBarControllerDelegate {
       
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        
        guard let tabItems = tabBar.items else { return }
        tabBar.backgroundColor = .white
//        tabItems[0].titlePositionAdjustment = UIOffset(horizontal: -4, vertical: 0)
//        tabItems[1].titlePositionAdjustment = UIOffset(horizontal: -30, vertical: 0)
//        tabItems[2].titlePositionAdjustment = UIOffset(horizontal: 30, vertical: 0)
//        tabItems[3].titlePositionAdjustment = UIOffset(horizontal: 4, vertical: 0)
        
        tabItems[0].titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 0)
        tabItems[1].titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 0)
        
        tabBar.backgroundColor = backgroundColorMain
        tabBar.tintColor = mainColor
        tabBar.barTintColor = .white
        tabBar.isTranslucent = true
        
        let normalAttributes = [NSAttributedString.Key.font : UIFont(name: "Graphik-Regular", size: 10), NSAttributedString.Key.foregroundColor : grayTextColor]
        
        let selectedAttributes = [NSAttributedString.Key.font : UIFont(name: "Graphik-Regular", size: 10), NSAttributedString.Key.foregroundColor : mainColor]

        UITabBarItem.appearance().setTitleTextAttributes(normalAttributes, for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes(selectedAttributes, for: .selected)
        

//        for item in tabItems {
//            item.setTitleTextAttributes(attributes as [NSAttributedString.Key : Any], for: .normal)
//        }
        
    }

}

@IBDesignable
class MyTabBar: UITabBar, UIAdaptivePresentationControllerDelegate {
    
    private var shapeLayer: CALayer?
    private var middleButton = UIButton()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //last int is spacing from top
        var isBottom: Bool {
            if #available(iOS 11.0, *), let keyWindow = UIApplication.shared.keyWindow, keyWindow.safeAreaInsets.bottom > 0 {
                return true
            }
            return false
        }
        
        let divider = UIView()
        divider.frame = CGRect(x: 0, y: 0, width: screenSize.width, height: 1)
        divider.backgroundColor = colorPalette[1]
//        addSubview(divider)
    }

}


