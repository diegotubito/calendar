//
//  WeekDayView.swift
//  Calendar
//
//  Created by David Diego Gomez on 23/07/2022.
//

import UIKit

class CalendarWeekDayView: UIView {
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        drawWeekDayView()
    }
    
    func drawWeekDayView() {
        let containerStack = UIStackView()
        containerStack.alignment = .fill
        containerStack.distribution = .fillEqually
        containerStack.spacing = 0
        containerStack.axis = .horizontal
        
        for day in 0...6 {
            let label = UILabel()
            label.font = UIFont.systemFont(ofSize: 14)
            let weekDay = getWeekDayName(day).prefix(3)
            label.text = String(weekDay.capitalized)
            label.textAlignment = .center
            label.textColor = .darkGray
            containerStack.addArrangedSubview(label)
        }
        
        addSubview(containerStack)
        
        containerStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            containerStack.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            containerStack.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0),
            containerStack.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0),
            containerStack.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0)
        ])
    }
    
    private func getWeekDayName(_ day: Int) -> String {
        switch day {
        case 0:
            return "sunday"
        case 1:
            return "monday"
        case 2:
            return "tuesday"
        case 3:
            return "wednesday"
        case 4:
            return "thursday"
        case 5:
            return "friday"
        case 6:
            return "saturday"
        default:
            return "x"
        }
    }
}
