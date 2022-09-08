//
//  Fonts.swift
//  BioGenesis
//
//  Created by Martin on 18/07/2022.
//

import UIKit

extension UIFont {
    static func graphikRegular(size: CGFloat) -> UIFont? {
        return UIFont(name: "Graphik-Regular", size: size)
    }
    
    static func graphikMedium(size: CGFloat) -> UIFont? {
        return UIFont(name: "Graphik-Medium", size: size)
    }
    
    static func graphikBold(size: CGFloat) -> UIFont? {
        return UIFont(name: "Graphik-Bold", size: size)
    }
    
    
    
    
    static func header1() -> UIFont? {
        return UIFont(name: "Graphik-Bold", size: 18)
    }
    
    static func header2() -> UIFont? {
        return UIFont(name: "Graphik-Medium", size: 16)
    }
    
    static func header3() -> UIFont? {
        return UIFont(name: "Graphik-Medium", size: 14)
    }
    
    static func paragraph1() -> UIFont? {
        return UIFont(name: "Graphik-Regular", size: 14)
    }
    
    static func paragraph2() -> UIFont? {
        return UIFont(name: "Graphik-Regular", size: 12)
    }
    
    static func paragraph3() -> UIFont? {
        return UIFont(name: "Graphik-Light", size: 12)
    }
    
    static func paragraph4() -> UIFont? {
        return UIFont(name: "Graphik-Bold", size: 10)
    }
}

