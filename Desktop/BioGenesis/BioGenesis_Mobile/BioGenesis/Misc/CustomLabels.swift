//
//  CustomLabels.swift
//  BioGenesis
//
//  Created by Martin on 06/09/2022.
//

import UIKit

func getAddLabel(yPosition: CGFloat, text: String, parent: UIView, height: CGFloat, font: UIFont = .graphikRegular(size: 12)!, spacing: CGFloat = 12, textColor: UIColor = .black, allignment: NSTextAlignment = .left) -> UILabel? {
    let label = UILabel()
    label.text = text
    label.textColor = textColor
    label.textAlignment = allignment
    label.font = font
    label.frame = CGRect(x: spacing, y: yPosition, width: parent.frame.width - (spacing * 2), height: height)
    parent.addSubview(label)
    return label
}
