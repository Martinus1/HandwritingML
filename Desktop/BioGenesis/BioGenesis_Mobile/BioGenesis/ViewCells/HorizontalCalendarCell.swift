//
//  HorizontalCalendarCell.swift
//  BioGenesis
//
//  Created by Martin on 31/08/2022.
//

import UIKit

class HorizontalCalendarCell: UICollectionViewCell {

    let dateLabel: UILabel = {
        let label = UILabel()
        label.font =  .paragraph1()
        label.textColor = grayTextColor
        label.text = "Nov, 13 2021"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.isUserInteractionEnabled = false
        //self.cell.backgroundColor = .random
        self.backgroundColor = .clear
        addViews()
    }

    func addViews(){
        backgroundColor = UIColor.white

        addSubview(dateLabel)

        NSLayoutConstraint.activate([
            dateLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            dateLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])

    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                dateLabel.textColor = .black
                dateLabel.font = .header3()
            } else {
                dateLabel.textColor = grayTextColor
                dateLabel.font = .paragraph1()
            }
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
