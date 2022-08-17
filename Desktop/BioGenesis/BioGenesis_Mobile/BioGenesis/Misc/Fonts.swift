//
//  Fonts.swift
//  BioGenesis
//
//  Created by Martin on 18/07/2022.
//

import UIKit

extension UIFont {
    static func unicaRegular(size: CGFloat) -> UIFont? {
        return UIFont(name: "Avenir", size: size)
    }
    
    static func header1() -> UIFont? {
        return UIFont(name: "Avenir-Heavy", size: 18)
    }
    
    static func header2() -> UIFont? {
        return UIFont(name: "Avenir-Medium", size: 16)
    }
    
    static func header3() -> UIFont? {
        return UIFont(name: "Avenir-Heavy", size: 16)
    }
    
    static func paragraph1() -> UIFont? {
        return UIFont(name: "Avenir-Roman", size: 14)
    }
    
    static func paragraph2() -> UIFont? {
        return UIFont(name: "Avenir", size: 12)
    }
    
    static func paragraph3() -> UIFont? {
        return UIFont(name: "Avenir-Light", size: 12)
    }
    
    static func paragraph4() -> UIFont? {
        return UIFont(name: "Avenir", size: 10)
    }
}

