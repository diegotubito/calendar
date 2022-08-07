//
//  CalendarBodyView.swift
//  Calendar
//
//  Created by David Diego Gomez on 23/07/2022.
//

import UIKit

class CalendarBodyView: UIView {
    private var dayViews: [CalendarDayView] = []
    var selectedDay: Date?
    var dateTapped: ((Date?) -> Void)?
    
    enum DayStyle {
        case normal
        case highlighted
        case hidden
        case nonSelectable
    }
    
    lazy var columnStackView: UIStackView = {
        let stack = createColumnStackView()
        
        addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stack.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0),
            stack.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0),
            stack.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            stack.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0)
        ])
        
        return stack
    }()
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        draw()
    }
    
    private func draw() {
        
        let maxColumn = 7
        let maxRow = 6
        self.dayViews.removeAll()
        for _ in 1...maxRow {
            let rowStack = createRowStackView()
            
            for _ in 1...maxColumn {
                let dayView = CalendarDayView()
                dayView.delegate = self
                rowStack.addArrangedSubview(dayView)
                self.dayViews.append(dayView)
            }
            columnStackView.addArrangedSubview(rowStack)
        }
    }
    
    private func createRowStackView() -> UIStackView {
        let rowStackView = UIStackView()
        rowStackView.alignment = .fill
        rowStackView.distribution = .fillEqually
        rowStackView.spacing = 0
        rowStackView.axis = .horizontal
        return rowStackView
    }
    
    private func createColumnStackView() -> UIStackView {
        let columnStackView = UIStackView()
        columnStackView.alignment = .fill
        columnStackView.distribution = .fillEqually
        columnStackView.spacing = 0
        columnStackView.axis = .vertical
        return columnStackView
    }
    
    public func update(model: CalendarViewModel) {
        print("day views updated")
        let currentMonth = Calendar.current.component(.month, from: model.startingDate)
        let weekDay = Calendar.current.component(.weekday, from: model.startingDate) - 1
        var startDate = Calendar.current.date(byAdding: .day, value: -weekDay, to: model.startingDate)!
        for (index, dayView) in dayViews.enumerated() {
            let monthNumber = Calendar.current.component(.month, from: startDate)
            let dayNumber = Calendar.current.component(.day, from: startDate)
            let dayString = String(dayNumber)
            if monthNumber > currentMonth {
                // Next month: these is a day that belongs to the next month
                // should be displayed with a different style
                showDayWithStyle(dayView: dayView, title: dayString, style: .hidden)
                dayView.date = nil
                dayView.index = nil
                dayView.isEnabled = false
                
            } else if monthNumber < currentMonth {
                // Previous month: these is a day that belongs to the previous month
                // should be displayed with a different style
                showDayWithStyle(dayView: dayView, title: dayString, style: .hidden)
                dayView.date = nil
                dayView.index = nil
                dayView.isEnabled = false
            } else {
                let isEnabled = isSelectable(date: startDate)
                dayView.isEnabled = isEnabled
                if isEnabled {
                    if isSelected(date: startDate) {
                        showDayWithStyle(dayView: dayView, title: dayString, style: .highlighted)
                    } else {
                        showDayWithStyle(dayView: dayView, title: dayString, style: .normal)
                    }
                } else {
                    showDayWithStyle(dayView: dayView, title: dayString, style: .nonSelectable)
                }
                dayView.date = startDate
                dayView.index = index
            }
            
            startDate = Calendar.current.date(byAdding: .day, value: 1, to: startDate) ?? startDate
        }
    }
    
    private func isSelected(date: Date) -> Bool {
        if let selectedDay = selectedDay, selectedDay == date {
            return true
        }
        return false
    }
    
    private func isSelectable(date: Date) -> Bool {
        let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: Date())!
        if date < yesterday {
            return false
        }
        return true
    }
    
    private func showDayWithStyle(dayView: CalendarDayView, title: String, style: DayStyle) {
        switch style {
        case .normal:
            dayView.titleLabel.text = title
            dayView.roundedBackground.backgroundColor = .white
            dayView.titleLabel.textColor = .black
        case .highlighted:
            dayView.titleLabel.text = title
            dayView.roundedBackground.backgroundColor = .blue
            dayView.titleLabel.textColor = .white
        case .hidden:
            dayView.titleLabel.text = title
            dayView.roundedBackground.backgroundColor = .white
            dayView.titleLabel.textColor = .clear
        case .nonSelectable:
            dayView.titleLabel.text = title
            dayView.roundedBackground.backgroundColor = .white
            dayView.titleLabel.textColor = .lightGray
        }
    }
}

extension CalendarBodyView: CalendarDayViewDelegate {
    
    func didSelectDayView(date: Date?) {
        selectedDay = date
        dateTapped?(date)
    }
}
