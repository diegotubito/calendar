//
//  CalendarView.swift
//  Calendar
//
//  Created by David Diego Gomez on 23/07/2022.
//

import UIKit

struct CalendarViewModel {
    var startingDate: Date
}

class CalendarView: UIView {
    var dateDidSelect: ((Date?) -> Void)?
    
    var model: CalendarViewModel! {
        didSet {
            headerView.updateValue(model: model)
        }
    }
    
    lazy var mainStackView: UIStackView = {
        let mainStack = UIStackView()
        mainStack.alignment = .fill
        mainStack.distribution = .fill
        mainStack.spacing = 0
        mainStack.axis = .vertical
        return mainStack
    }()
    
    lazy var headerView: CalendarHeaderView = {
        let view = CalendarHeaderView()
        return view
    }()
    
    lazy var weekDayView: CalendarWeekDayView = {
        return CalendarWeekDayView()
    }()
    
    lazy var bodyView: CalendarBodyView = {
       return CalendarBodyView()
    }()
        
    override init(frame: CGRect) {
        super .init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super .init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        drawCalendar()
        setupBinding()
    }
    
    public func setInitialValue(currentDate: Date) {
        let startingDate = convertToStartingDate(date: currentDate)
        model = CalendarViewModel(startingDate: startingDate)
        bodyView.update(model: model)
    }
    
    private func convertToStartingDate(date: Date) -> Date {
        let dayNumber = Calendar.current.component(.day, from: date)
        let start = Calendar.current.date(byAdding: .day, value: -(dayNumber - 1), to: date)
        return start ?? Date()
    }
    
    private func setupBinding() {
        headerView.rightButtonTapped = { [weak self] in
            guard let self = self else { return }
            print("right button tapped")
            self.nextMonth()
            self.bodyView.update(model: self.model)
        }
        
        headerView.leftButtonTapped = { [weak self] in
            guard let self = self else { return }
            print("left button tapped")
            self.previousMonth()
            self.bodyView.update(model: self.model)
        }
        
        bodyView.dateTapped = { [weak self] date in
            guard let self = self else { return }
        
            self.dateDidSelect?(date)
            self.bodyView.update(model: self.model)
        }
    }
   
    private func nextMonth() {
        model.startingDate = Calendar.current.date(byAdding: .month, value: 1, to: model.startingDate)!
    }
    
    private func previousMonth() {
        model.startingDate = Calendar.current.date(byAdding: .month, value: -1, to: model.startingDate)!
    }
}


// MARK: DRAWING

extension CalendarView {
    private func drawCalendar() {
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        addSubview(mainStackView)
        mainStackView.addArrangedSubview(headerView)
        mainStackView.addArrangedSubview(weekDayView)
        mainStackView.addArrangedSubview(bodyView)
    }
    
    private func setupConstraints() {
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            mainStackView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0),
            mainStackView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0),
            mainStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0)
        ])
        
        headerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            headerView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0),
            headerView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0),
            headerView.heightAnchor.constraint(equalToConstant: 35)
        ])
        
        weekDayView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            weekDayView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0),
            weekDayView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0),
            weekDayView.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        
    }
}
