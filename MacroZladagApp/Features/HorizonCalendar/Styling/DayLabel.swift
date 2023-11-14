//
//  DayLabel.swift
//  MacroZladagApp
//
//  Created by Daniel Bernard Sahala Simamora on 09/11/23.
//
//

import UIKit
import HorizonCalendar

struct DayLabel: CalendarItemViewRepresentable {

    /// Properties that are set once when we initialize the view.
    struct InvariantViewProperties: Hashable {
        var font: UIFont
        var textColor: UIColor
        var backgroundColor: UIColor
    }

    /// Properties that will vary depending on the particular date being displayed.
    struct ViewModel: Equatable {
        let day: Day
    }

    static func makeView(withInvariantViewProperties invariantViewProperties: InvariantViewProperties) -> UILabel {
        let label = UILabel()

        label.backgroundColor = invariantViewProperties.backgroundColor
        label.font = invariantViewProperties.font
        label.textColor = invariantViewProperties.textColor

        label.textAlignment = .center
        label.clipsToBounds = true
        label.layer.cornerRadius = 19
        label.layer.borderWidth = 0
        label.layer.borderColor = UIColor.clear.cgColor

        return label
    }

    static func setViewModel(_ viewModel: ViewModel, on view: UILabel) {
        view.text = "\(viewModel.day.day)"
    }

}
