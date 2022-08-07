//
//  CalendarHeaderView.swift
//  Calendar
//
//  Created by David Diego Gomez on 23/07/2022.
//

import UIKit

class CalendarHeaderView: UIView {
    var leftButtonTapped: (() -> Void)?
    var rightButtonTapped: (() -> Void)?
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.alignment = .fill
        return stack
    }()
    
    private lazy var leftButton: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "icon.chevron.left")
        view.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(leftButtonDidTapped))
        view.addGestureRecognizer(tap)
        view.tintColor = .black
        return view
    }()
    
    private lazy var rightButton: UIImageView = {
        let view = UIImageView()
        let tap = UITapGestureRecognizer(target: self, action: #selector(rightButtonDidTapped))
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(tap)
        view.image = UIImage(named: "icon.chevron.right")
        view.tintColor = .black
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.text = "-"
        return label
    }()
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        addStackView()
        addLeftButton()
        addTitleLabel()
        addRightButton()
    }
    
    private func addStackView() {
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0),
            stackView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0),
            stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0)
        ])
    }
    
    private func addLeftButton() {
        stackView.addArrangedSubview(leftButton)
        
        leftButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            leftButton.widthAnchor.constraint(equalToConstant: 25),
            leftButton.heightAnchor.constraint(equalToConstant: 25)
        ])
    }
    
    private func addRightButton() {
        stackView.addArrangedSubview(rightButton)
        
        rightButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            rightButton.widthAnchor.constraint(equalToConstant: 25),
            rightButton.heightAnchor.constraint(equalToConstant: 25)
        ])
    }
    
    private func addTitleLabel() {
        stackView.addArrangedSubview(titleLabel)
    }
    
    @objc private func leftButtonDidTapped() {
        leftButtonTapped?()
    }
    
    @objc private func rightButtonDidTapped() {
        rightButtonTapped?()
    }
    
    public func updateValue(model: CalendarViewModel) {
        var text: [String] = []
        text.append(getMonthName(model).capitalized)
        text.append(getYear(model))
        titleLabel.text = text.joined(separator: " ")
    }
    
    private func getYear(_ value: CalendarViewModel) -> String {
        let yearNumber = Calendar.current.component(.year, from: value.startingDate)
        return String(yearNumber)
    }
    
    private func getMonthName(_ value: CalendarViewModel) -> String {
        let monthNumber = Calendar.current.component(.month, from: value.startingDate)
        
        switch monthNumber {
        case 1:
            return "january"
        case 2:
            return "february"
        case 3:
            return "march"
        case 4:
            return "april"
        case 5:
            return "may"
        case 6:
            return "june"
        case 7:
            return "july"
        case 8:
            return "august"
        case 9:
            return "september"
        case 10:
            return "october"
        case 11:
            return "november"
        case 12:
            return "december"
        default:
            return "*"
        }
    }
}
