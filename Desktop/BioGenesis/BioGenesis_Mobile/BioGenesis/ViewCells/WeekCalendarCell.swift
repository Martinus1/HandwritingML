//
//  WeekCalendarCell.swift
//  BioGenesis
//
//  Created by Martin on 13/07/2022.
//

import Foundation
import JTAppleCalendar

//Paging Enabled
//Horizontal Scroll
//Scroll Indicators Disabled
class WeekCalendarCell: JTACDayCell {
    //MARK: The Outline around the cell
    @IBOutlet weak var outlineBox: UIView!
    //MARK: The circle behind the date symbol
    @IBOutlet weak var dateIndicatorBox: UIView!
    //MARK: Date of month
    @IBOutlet var dayNumberLabel: UILabel!
    //MARK: Date of the week
    @IBOutlet weak var daySymbolLabel: UILabel!
}
